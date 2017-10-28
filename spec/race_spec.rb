require "spec_helper"
require "support/spec_helpers/response_validator"

RSpec.configure do |c|
  c.include SpecHelpers::ResponseValidator::Race
end

RSpec.describe ErgastF1::Race do
  # TODO: ADD CONTEXT BLOCKS!

  describe ".result" do
    it "returns the result of a race when supplied a season year and a round number" do
      VCR.use_cassette("suzuka_1989_by_round") do
        result = ErgastF1::Race.new(year: 1989, round: 15).result
        expect(valid_race_result?(result)).to be true
      end
    end

    it "returns an error if the supplied round number doesn't exist for the year" do
      VCR.use_cassette("nonexistent_round") do
        race = ErgastF1::Race.new(year: 1989, round: 20)
        expect {race.result}.to raise_error(BadQuery, "No results found.")
      end  
    end

    it "returns the result of a race when supplied a season year and circuit name" do
      VCR.use_cassette("suzuka_1989_by_circuit_name") do
        result = ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result
        expect(valid_race_result?(result)).to be true
      end
    end

    it "returns an error if the supplied circuit name doesn't exist for the year" do
      VCR.use_cassette("nonexistent_1989_circuit_name") do
        expect {ErgastF1::Race.new(year: 1989, circuit: "Malaysia").result}.to raise_error(BadQuery, "No results found.")
      end
    end

    it "returns the result of a race when supplied a season year and a constructor" do
      VCR.use_cassette("race_filtered_on_constructor") do
        constructor =  "Ferrari"
        race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
        result = race.result({constructor: constructor})
        expect(valid_race_result?(result)).to be true
        expect(for_constructor?(result, constructor)).to be true
      end
    end

    it "returns an error if the supplied constructor didn't compete in the event" do
      VCR.use_cassette("race_filtered_on_nonexistent_constructor") do
        expect {
          ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
          .result({constructor: "Lotus"})
        }.to raise_error(BadQuery, "No results found.")
      end
    end

    it "returns a race result by grid position when supplied a season year" do
      VCR.use_cassette("race_by_grid_position") do
        race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
        position = 2
        result = race.result({grid_position: position})
        expect(valid_race_result?(result)).to be true
        expect(for_position?(result, position)).to be true
      end
    end

    it "returns an error if a supplied grid position doesn't exist for an event" do
      VCR.use_cassette("nonexistent_grid_position") do
        expect {
          ErgastF1::Race.new(year: 2017, circuit: "Hungaroring").result(position: 30)
        }.to raise_error(BadQuery, "No results found.")
      end
    end

    it "returns a race result by finishing status when supplied a season year" do
      VCR.use_cassette("collisions_hungary_2017") do
        race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
        status = "Collision"
        result = race.result({status: status})

        expect(valid_race_result?(result)).to be true
        expect(for_status?(result, status)).to be true
      end
    end

    it "returns a helpful error message if a finishing status is supplied but doesn't apply to any of the results" do
      VCR.use_cassette("engine_failure_hungary_2017") do
        expect {
          ErgastF1::Race.new(year: 2017, circuit: "Hungaroring").result(status: "Engine").raise_error(BadQuery, "No results found.")
        }
      end
    end

    it "returns a helpful error if the user supplies an invalid status name" do
      VCR.use_cassette("engine_failure_hungary_2017") do
        expect {
          ErgastF1::Race.new(year: 2017, circuit: "Hungaroring").result(status: "UNICORN EXPLOSION")
        }.to raise_error(BadQuery, "Invalid status supplied. Valid status arguments are: Finished, Disqualified, Accident, Collision, Engine, Gearbox, Transmission, Clutch, Hydraulics, Electrical, Spun, Radiator, Suspension, Brakes, Differential, Overheating, Mechanical, Tyre, Driver, Puncture, Driveshaft.")
      end
    end

    it "returns the final season race results if a season is supplied, but a round isn't" do
      VCR.use_cassette("last_round_1997") do
        # TODO: MAKE THIS A BETTER TEST
        result = ErgastF1::Race.new(year: 1997).result
        expect(valid_race_result?(result)).to be true
      end
    end

    it "returns the finishing result of a supplied driver by name and a round by circuit name" do
      VCR.use_cassette("vettel_result_hungaroring_2017_by_circuit") do
        race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
        vettel_finishing_position = race.result({driver: "Vettel"})
        expect(vettel_finishing_position).to eq(1)
      end
    end

    it "returns the finishing position of a supplied driver by name and a round by number" do
      VCR.use_cassette("vettel_result_hungaroring_2017_by_round_number") do
        race = ErgastF1::Race.new(year: 2017, round: 11)
        vettel_finishing_position = race.result({driver: "Vettel"})
        expect(vettel_finishing_position).to eq(1)
      end
    end

    it "returns an error if the supplied driver did not compete in this race" do
      VCR.use_cassette("senna_monaco_1994") do
        race = ErgastF1::Race.new(year: 1994, circuit: "Monaco") 
        expect{race.result({driver: "Senna"})}.to raise_error(BadQuery, "The supplied driver did not compete in this race.")
      end
    end
  end

  describe ".finishing_position" do
    it "returns the finishing position of a supplied driver by name and a round by number" do
      VCR.use_cassette("vettel_result_hungaroring_2017_by_round_number") do
        race = ErgastF1::Race.new(year: 2017, round: 11)
        vettel_finishing_position = race.finishing_position("Vettel")
        expect(vettel_finishing_position).to eq(1)
      end
    end
  end

  describe ".laptime_rankings" do
    it "returns the fastest lap of the race" do
      VCR.use_cassette("fastest_lap_australia_2017") do
        race = ErgastF1::Race.new(year: 2017, round: 1)
        finishing_position = 1
        result = race.laptime_rankings(finishing_position)
        expect(valid_race_result?(result)).to be true
        expect(for_fast_lap_ranking?(result, finishing_position)).to be true
      end
    end

    it "returns all of the laptime rankings if no position is supplied" do
      pending("Believed not supported by Ergast")
      fail
      # VCR.use_cassette("fastest_lap_australia_2017") do
      #   race = ErgastF1::Race.new(year: 2017, round: 1)
      #   result = race.laptime_rankings
      #   expect(result).to eq(ExpectedVars::Race::LAPTIME_RANKINGS_AUSTRALIA_2017)
      # end
    end

    it "returns a ranked lap of the race that is not the fastest lap" do
      VCR.use_cassette("second_fastest_lap") do
        race = ErgastF1::Race.new(year: 2017, round: 1)
        finishing_position = 2
        result = race.laptime_rankings(finishing_position)
        
        expect(valid_race_result?(result)).to be true
        expect(for_fast_lap_ranking?(result, finishing_position)).to be true
      end
    end

    it "returns a helpful message if the year supplied is before 2004" do
      expect {ErgastF1::Race.new(year: 1998, round: 1).laptime_rankings(1)}.to raise_error(BadQuery, "Fastest lap data isn't available for races before 2004")
    end
  end
end