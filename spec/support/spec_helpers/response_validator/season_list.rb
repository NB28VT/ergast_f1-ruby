module SpecHelpers
  module ResponseValidator
    module SeasonList
      def valid_season_list?(season_list)
        return false unless season_list.key?("Seasons") && season_list["Seasons"].is_a?(Array)
        return false unless season_list["Seasons"].all?{|season| valid_season_data(season)}
        return true
      end

      def valid_season_data(season)
        ["season", "url"].all?{ |k| season.key? k}
      end
    end
  end
end
