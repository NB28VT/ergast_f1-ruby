module ErgastF1
  class SeasonList
    def initialize(circuit: nil, constructor: nil, driver_name: nil, finishing_position: nil)
      @circuit = circuit
      @constructor = constructor
      @driver_name = driver_name
      @finishing_position = finishing_position

      return query_results
    end


    private

    def query_results
      endpoint = season_list_path


      parsed_response = ErgastClient.new(endpoint).api_get_request

    end

    def season_list_path
      url_path = ""
      url_path += "/drivers/#{@driver_name}" if @driver_name
      url_path += "/constructor/#{@constructor}" if @constructor
      url_path += "/constructor/#{@constructor}" if



    end





  end
end
