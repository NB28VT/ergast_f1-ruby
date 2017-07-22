require "ergast_client"
require "net/http"
require "json"
require "pry"

module ErgastF1
  class Season
    def initialize(year)
      @year = year
      # TODO: SUPPORT NON JSON RETURNS/FAILURES
      @season_data = JSON.parse(get_season)
    end

    def races
      @season_data.dig("MRData", "RaceTable", "Races")
    end

    private

    def get_season
      uri = URI("http://ergast.com/api/f1/#{@year}.json")
      Net::HTTP.get(uri)
    end

  end
end