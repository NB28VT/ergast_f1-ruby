module ErgastF1
  class SeasonList
    def self.find(circuit: nil, constructor: nil, driver: nil, finishing_position: nil)
      query_path = ""
      query_path += "drivers/#{driver}/" if driver
      query_path += "constructors/#{constructor}/" if constructor
      query_path += "circuits/#{circuit}/" if circuit
      query_path += "results/#{finishing_position}/" if finishing_position

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
