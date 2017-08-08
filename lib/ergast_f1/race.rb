module ErgastF1
  class Race
    
    def initialize(year: nil, circuit: nil, round: nil)
      
      @year = year || Time.now.year
      @circuit = circuit
      @round = round
    end


    # TODO: Clean up query params
    # driver: nil, constructor: nil, finishing_position: nil, status: nil, grid_position: nil
    def result(query_params = {})
      return finishing_position(query_params[:driver]) if query_params[:driver]
      query_path = query_path(query_params)
      race_data(race_path + query_path) || (raise BadQuery, "No results found.")
    end

    def laptime_rankings(position=nil)
      raise BadQuery, "Fastest lap data isn't available for races before 2004" if @year < 2004
      race_data("#{race_path}/fastest/#{position}")["Results"].first
    end

    def finishing_position(driver)
      full_result = result
      # Not ideal to parse this, see if can find endpoint that supports this
      driver_result = full_result.dig("Results").find{|r| r["Driver"]["driverId"] == driver.downcase}
      raise BadQuery, "The supplied driver did not compete in this race." if driver_result.nil?
      # TODO: returns 0 on non 
      return driver_result.dig("position").to_i
    end

    private

    def race_path
      if @round
        "#{@year}/#{@round}"
      elsif @circuit
        "#{@year}/circuits/#{@circuit}"
      else
        "#{@year}/last"
      end
    end

    def query_path(query_params)
      return "/results/#{query_params[:position]}" if query_params[:position]
      return "/constructors/#{query_params[:constructor]}/results" if query_params[:constructor]
      return "/status/#{query_params[:status]}/results" if query_params[:status]
      return "/results"
    end

    def race_data(endpoint)
      parsed_response = ErgastClient.new(endpoint).api_get_request
      # Possible this could be unreliable
      parsed_response.dig("MRData", "RaceTable", "Races").first
    end
  end
end