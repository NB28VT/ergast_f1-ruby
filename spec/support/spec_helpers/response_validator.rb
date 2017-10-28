module SpecHelpers
  module ResponseValidator
    
    module Race
      def valid_race_result?(result)
        return false unless result.is_a?(Array)
        return false unless result.all?{|driver| valid_driver_data?(driver)}
        return true
      end

      def valid_driver_data?(driver)
        # TODO: beef up by going deeper into Driver and Constructor
        ["number", "position", "positionText", "points", "Driver", "Constructor", "grid", "laps", "status"].all?{ |k|driver.key? k}
      end

      def for_constructor?(result, constructor_name)
        return false unless result.all?{|driver| driver.dig("Constructor", "name") == constructor_name}
        return true
      end

      def for_position?(result, position)
        return false unless result.size == 1
        return false unless result[0]["position"] == position.to_s
        return true
      end

      def for_status?(result, status)
        return false unless result.all?{|driver| driver["status"] == status}
        return true
      end

      def for_fast_lap_ranking?(result, finishing_position)
        return false unless result.size == 1
        return false unless result[0]["FastestLap"]
        return false unless result[0]["FastestLap"]["rank"] == finishing_position.to_s
        return true
      end

    end
  end
end