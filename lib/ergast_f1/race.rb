module ErgastF1
  class Race
    def initialize(year: nil, circuit: nil, round: nil)
      @year = year || Time.now.year
      @circuit = circuit
      @round = round
    end

    def result
      race_result(race_path) || (raise BadQuery, "The supplied race could not be found.")
    end

    def fastest_lap
      raise BadQuery, "Fastest lap data isn't available for races before 2004" if @year < 2004
      race_result("#{race_path}/fastest/1")["Results"].first
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

    def race_result(endpoint)
      parsed_response = ErgastClient.new(endpoint + "/results").api_get_request
      parsed_response.dig("MRData", "RaceTable", "Races").first
    end
  end
end