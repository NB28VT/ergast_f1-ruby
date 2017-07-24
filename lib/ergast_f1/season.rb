require "ergast_client"
require "net/http"
require "json"
require "pry"

module ErgastF1
  class Season
    def initialize(year=nil)
      @year = year || Time.now.year
      
      begin
        @season_data = JSON.parse(get_season)
      rescue JSON::ParserError
        return "Non-JSON reponse from ErgastF1 server"
      end
    end

    def races(round=nil)
      if round
        @season_data.dig("MRData", "RaceTable", "Races").select{|r| r["round"] == round.to_s}.first || (raise ApiError, "Nonexistent Round Number Specified")
      else
        @season_data.dig("MRData", "RaceTable", "Races")
      end
    end

    def driver_standings
      uri = URI("http://ergast.com/api/f1/#{@year}/driverStandings.json")
      Net::HTTP.get(uri)
    end

    private

    def get_season
      uri = URI("http://ergast.com/api/f1/#{@year}.json")
      Net::HTTP.get(uri)
    end

  end
end