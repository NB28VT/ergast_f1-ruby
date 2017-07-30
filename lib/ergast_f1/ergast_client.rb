class ErgastClient
  BASE_URL = "http://ergast.com/api/f1/"

  def initialize(endpoint_path)
    @endpoint = BASE_URL + endpoint_path
  end

  def api_get_request
    c = Curl::Easy.new(@endpoint)
    c.connect_timeout = 60
    c.timeout = 300
    c.http_get()
    # TODO: ADD CONNECTION ERROR HANDLING
    return json_parse_response(c.body_str)
  end

  private

  def json_parse_response(response)
    begin
      return JSON.parse(response)
    rescue JSON::ParserError
      return ApiError, "Error: invalid JSON reponse from ErgastF1 server"
    end
  end
end