module ErgastF1
  class SeasonList
    def initialize(circuit: nil, constructor: nil, driver_name: nil)
      @circuit = circuit
      @constructor = constructor
      @driver_name = driver_name

      return query_results
    end


    private

    def query_results
      endpoint = path + "seasons"
      parsed_response = ErgastClient.new(endpoint).api_get_request
      binding.pry_remote
    end

    def path
      url_path = ""
      url_path += "drivers/#{@driver_name}/" if @driver_name
      url_path += "constructor/#{@constructor}/" if @constructor
      url_path += "circuits/#{@circuit}/" if @circuit
    end





  end
end
