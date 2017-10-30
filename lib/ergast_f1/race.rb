module ErgastF1
  class Race
    STATUS_TABLE = {"Finished" => "1",
       "Disqualified" => "2",
       "Accident" => "3",
       "Collision" => "4",
       "Engine" => "5",
       "Gearbox" => "6",
       "Transmission" => "7",
       "Clutch" => "8",
       "Hydraulics" => "9",
       "Electrical" => "10",
       "Spun" => "20",
       "Radiator" => "21",
       "Suspension" => "22",
       "Brakes" => "23",
       "Differential" => "24",
       "Overheating" => "25",
       "Mechanical" => "26",
       "Tyre" => "27",
       "Driver Seat" => "28",
       "Puncture" => "29",
       "Driveshaft" => "30"
     }
    
    def initialize(year: nil, circuit: nil, round: nil)
      @year = year || Time.now.year
      @circuit = circuit
      @round = round
    end

    def result
      race_data(race_path + "/results")
    end

    def constructor_result(constructor_name)
      race_data(race_path + "/constructors/#{constructor_name}/results")
    end

    def driver_result(driver_name)
      race_data(race_path + "/drivers/#{driver_name}/results")
    end

    def grid_position(position)
      race_data(race_path + "/grid/#{position}/results")
    end

    def finishing_status(status)
      finishing_status = resolve_finishing_status(status)
      race_data(race_path + "/status/#{finishing_status}/results")
    end

    def laptime_ranking(position=nil)
      raise BadQuery, "Fastest lap data isn't available for races before 2004" if @year < 2004
      race_data(race_path + "/fastest/#{position}/results")
    end

    private

    def race_path
      if @round
        "#{@year}/#{@round}"
      elsif @circuit
        "#{@year}/circuits/#{@circuit}"
      else
        "#{@year}/last"
      end
    end

    def resolve_finishing_status(status)
      STATUS_TABLE[status] || (raise BadQuery, "Invalid status supplied. Valid status arguments are: Finished, Disqualified, Accident, Collision, Engine, Gearbox, Transmission, Clutch, Hydraulics, Electrical, Spun, Radiator, Suspension, Brakes, Differential, Overheating, Mechanical, Tyre, Driver, Puncture, Driveshaft.")
    end

    def race_data(endpoint)
      parsed_response = ErgastClient.new(endpoint).api_get_request
      race_results = parsed_response.dig("MRData", "RaceTable", "Races")
      return [] if race_results.empty?
      race_results.first["Results"]
    end
  end
end