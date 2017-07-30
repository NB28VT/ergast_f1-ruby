module ErgastF1
  class Season
    def initialize(year=nil)
      @year = year || Time.now.year
    end

    def races(round=nil)
      season_data = get_season

      if round
        season_data.dig("MRData", "RaceTable", "Races").select{|r| r["round"] == round.to_s}.first || (raise ApiError, "Nonexistent Round Number Specified")
      else
        season_data.dig("MRData", "RaceTable", "Races")
      end
    end

    def driver_standings
      parsed_response = ErgastClient.new("#{@year}/driverStandings.json").api_get_request
      # Uh oh, array for standings lists
      parsed_response.dig("MRData", "StandingsTable", "StandingsLists").first["DriverStandings"]
    end

    def constructor_standings
      parsed_response = ErgastClient.new("#{@year}/constructorStandings.json").api_get_request
      # Uh oh, array for standings lists
      parsed_response.dig("MRData", "StandingsTable", "StandingsLists").first["ConstructorStandings"]
    end

    private

    def get_season
      ErgastClient.new("#{@year}.json").api_get_request
    end
  end
end