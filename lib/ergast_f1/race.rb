module ErgastF1
  class Race
    STATUS_TABLE = {"Finished" => "1",
       "Disqualified" => "2",
       "Accident" => "3",
       "Collision" => "4",
       "Engine" => "5",
       "Gearbox" => "6",
       "Transmission" => "7",
       "Clutch" => "8",
       "Hydraulics" => "9",
       "Electrical" => "10",
       "Spun" => "20",
       "Radiator" => "21",
       "Suspension" => "22",
       "Brakes" => "23",
       "Differential" => "24",
       "Overheating" => "25",
       "Mechanical" => "26",
       "Tyre" => "27",
       "Driver Seat" => "28",
       "Puncture" => "29",
       "Driveshaft" => "30"
     }
    
    def initialize(year: nil, circuit: nil, round: nil)
      @year = year || Time.now.year
      @circuit = circuit
      @round = round
    end

    # driver: nil, constructor: nil, finishing_position: nil, status: nil, grid_position: nil
    def result(query_params = {})
      # return finishing_position(query_params[:driver]) if query_params[:driver]
      # query_path = query_path(query_params)
      # race_data(race_path + query_path) || (raise BadQuery, "No results found.")
    end

    def finishing_position(driver)
      driver_result = result.find{|r| r["Driver"]["driverId"] == driver.downcase}
      raise BadQuery, "The supplied driver did not compete in this race." if driver_result.nil?
      return driver_result.dig("position").to_i
    end

    def constructor_result(constuctor_name)
    end

    def driver_result(driver_name)
      
    end

    def starting_position(position)
    end

    def finishing_status(status)
    end

    def laptime_rankings(position=nil)
      raise BadQuery, "Fastest lap data isn't available for races before 2004" if @year < 2004
      race_data("#{race_path}/fastest/#{position}/results")
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
      return "/grid/#{query_params[:grid_position]}/results" if query_params[:grid_position]
      return "/status/#{resolve_finishing_status(query_params[:status])})/results" if query_params[:status]
      return "/results"
    end

    def resolve_finishing_status(status)
      STATUS_TABLE[status] || (raise BadQuery, "Invalid status supplied. Valid status arguments are: Finished, Disqualified, Accident, Collision, Engine, Gearbox, Transmission, Clutch, Hydraulics, Electrical, Spun, Radiator, Suspension, Brakes, Differential, Overheating, Mechanical, Tyre, Driver, Puncture, Driveshaft.")
    end

    def race_data(endpoint)
      parsed_response = ErgastClient.new(endpoint).api_get_request
      race_results = parsed_response.dig("MRData", "RaceTable", "Races")
      return nil if race_results.empty?
      race_results.first["Results"]
    end
  end
end