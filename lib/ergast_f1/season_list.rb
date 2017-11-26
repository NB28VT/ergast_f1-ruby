module ErgastF1
  class SeasonList
    def self.find(circuit: nil, constructor: nil, driver: nil, rank: nil)
      query_path = ""
      query_path += "drivers/#{driver}/" if driver
      query_path += "constructors/#{constructor}/" if constructor
      query_path += "circuits/#{circuit}/" if circuit

      # TODO: RANK AND CONSTRUCTOR AND DRIVER

      if rank && constructor
        query_path += "constructorStandings/#{rank}/"
      elsif rank && driver
        query_path += "driverStandings/#{rank}/"
      end

      return query_results(query_path)
    end

    private

    def self.query_results(query_path)
      endpoint = query_path + "seasons"
      parsed_response = ErgastClient.new(endpoint).api_get_request
      return parsed_response.dig("MRData", "SeasonTable") || []
    end
  end
end
