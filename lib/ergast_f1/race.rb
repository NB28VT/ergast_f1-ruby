module ErgastF1
  class Race
    def initialize(year: nil, circuit: nil, round: nil)
      @year = year || Time.now.year
      # TODO: default circuit fallback?
      @circuit = circuit
      @round = round || "last"
    end

    def result
      # Handle nil values
      if @round
        race_result("#{@year}/#{@round}/results.json") || (raise RaceNotFound, "The supplied round number does not exist for this season")
      elsif @circuit
        race_result("#{@year}/circuits/#{@circuit}/results.json") || (raise CircuitNotFound, "The supplied circuit does not exist for this season")
      else
        race_result("current/last/results.json")
      end
    end

    private

    def race_result(endpoint)
      parsed_response = ErgastClient.new(endpoint).api_get_request
      parsed_response.dig("MRData", "RaceTable", "Races").first
    end
  end
end