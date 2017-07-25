require "ergast_client"
require "net/http"
require "json"
require "pry"

module ErgastF1
  class Season
    def initialize(year=nil)
      @year = year || Time.now.year
    end

    def races(round=nil)
      season_data = json_parse_response(get_season)

      if round
        season_data.dig("MRData", "RaceTable", "Races").select{|r| r["round"] == round.to_s}.first || (raise ApiError, "Nonexistent Round Number Specified")
      else
        season_data.dig("MRData", "RaceTable", "Races")
      end
    end

    def driver_standings
      uri = URI("http://ergast.com/api/f1/#{@year}/driverStandings.json")
      response = Net::HTTP.get(uri)
      parsed_response = json_parse_response(response)
      # Uh oh, array for standings lists
      parsed_response.dig("MRData", "StandingsTable", "StandingsLists").first["DriverStandings"]
    end

    def constructor_standings
      uri = URI("http://ergast.com/api/f1/#{@year}/constructorStandings.json")
      response = Net::HTTP.get(uri)
      parsed_response = json_parse_response(response)
      # Uh oh, array for standings lists
      parsed_response.dig("MRData", "StandingsTable", "StandingsLists").first["ConstructorStandings"]
    end

    private

    def json_parse_response(response)
      begin
        return JSON.parse(response)
      rescue JSON::ParserError
        return ApiError, "Error: invalid JSON reponse from ErgastF1 server"
      end
    end

    def get_season
      uri = URI("http://ergast.com/api/f1/#{@year}.json")
      Net::HTTP.get(uri)
    end

  end
end