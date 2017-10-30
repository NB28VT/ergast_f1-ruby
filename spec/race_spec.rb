require "spec_helper"
require "support/spec_helpers/response_validator"

RSpec.configure do |c|
  c.include SpecHelpers::ResponseValidator::Race
end

RSpec.describe ErgastF1::Race do
  
  let (:race) { ErgastF1::Race.new(year: 2017, circuit: "Hungaroring") }
  
  describe ".result" do
    it "returns the result of a race when supplied a season year and a round number" do
      VCR.use_cassette("suzuka_1989_by_round") do
        result = ErgastF1::Race.new(year: 1989, round: 15).result
        expect(valid_race_result?(result)).to be true
      end
    end

    it "returns an empty array if the supplied round number doesn't exist for the year" do
      VCR.use_cassette("nonexistent_round") do
        expect(ErgastF1::Race.new(year: 1989, round: 20).result).to eq([])
      end  
    end

    it "returns the result of a race when supplied a season year and circuit name" do
      VCR.use_cassette("suzuka_1989_by_circuit_name") do
        result = ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result
        expect(valid_race_result?(result)).to be true
      end
    end

    it "returns an empty array if the supplied circuit name doesn't exist for the year" do
      VCR.use_cassette("nonexistent_1989_circuit_name") do
         expect(ErgastF1::Race.new(year: 1989, circuit: "Malaysia").result).to eq([])
      end
    end
  end

  describe ".constructor_result" do
    it "returns the result of a race when supplied a season year and a constructor" do
      VCR.use_cassette("race_filtered_on_constructor") do
        constructor_result = race.constructor_result("Ferrari")
        expect(valid_race_result?(constructor_result)).to be true
        expect(for_constructor?(constructor_result, "Ferrari")).to be true
      end
    end

    it "returns an empty array if the supplied constructor didn't compete in the event" do
      VCR.use_cassette("race_filtered_on_nonexistent_constructor") do
        expect(race.constructor_result("Lotus")).to eq([])
      end
    end
  end

  describe ".driver_result" do
    it "returns the finishing result of a supplied driver by name" do
      VCR.use_cassette("vettel_result_hungaroring_2017_by_circuit") do
        driver_result = race.driver_result("Vettel")
        expect(valid_race_result?(driver_result)).to be true
        expect(for_driver?(driver_result, "Vettel")).to be true
      end
    end

    it "returns an empty array if the supplied driver did not compete in this race" do
      VCR.use_cassette("senna_monaco_1994") do
        race = ErgastF1::Race.new(year: 1994, circuit: "Monaco") 
        expect(race.driver_result("Senna")).to eq ([])
      end
    end
  end

  describe ".grid_position" do
    it "returns a race result by grid position when supplied a season year" do
      VCR.use_cassette("race_by_grid_position") do
        position_result = race.grid_position(2)
        expect(valid_race_result?(position_result)).to be true
        expect(for_position?(position_result, 2)).to be true
      end
    end

    it "returns an empty array if a supplied grid position doesn't exist for an event" do
      VCR.use_cassette("nonexistent_grid_position") do
        expect(race.grid_position(30)).to eq ([])
      end
    end
  end

  describe ".finishing_status" do
    it "returns a race result by finishing status when supplied a valid status" do
      VCR.use_cassette("collisions_hungary_2017") do
        status_result = race.finishing_status("Collision")
        expect(valid_race_result?(status_result)).to be true
        expect(for_status?(status_result, "Collision")).to be true
      end
    end
  
    it "returns an empty array if a finishing status is supplied but doesn't apply to any of the results" do
      VCR.use_cassette("engine_failure_hungary_2017") do
        expect(race.finishing_status("Engine")).to eq([])
      end
    end

    it "returns a helpful error if the user supplies an invalid status name" do
      VCR.use_cassette("engine_failure_hungary_2017") do
        expect { race.finishing_status("UNICORN EXPLOSION")}.to raise_error(BadQuery, "Invalid status supplied. Valid status arguments are: Finished, Disqualified, Accident, Collision, Engine, Gearbox, Transmission, Clutch, Hydraulics, Electrical, Spun, Radiator, Suspension, Brakes, Differential, Overheating, Mechanical, Tyre, Driver, Puncture, Driveshaft.")
      end
    end
  end

  describe ".finishing_position" do
    it "returns the finishing position of a supplied driver by name and a round by number" do
      VCR.use_cassette("vettel_result_hungaroring_2017_by_round_number") do
        expect(race.finishing_position("Vettel")).to eq(1)
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
        expect(for_fast_lap_ranking?(result, 1)).to be true
      end
    end

    it "returns a ranked lap of the race that is not the fastest lap" do
      VCR.use_cassette("second_fastest_lap") do
        race = ErgastF1::Race.new(year: 2017, round: 1)
        result = race.laptime_rankings(2)
        expect(valid_race_result?(result)).to be true
        expect(for_fast_lap_ranking?(result, 2)).to be true
      end
    end

    it "returns a helpful message if the year supplied is before 2004" do
      expect {ErgastF1::Race.new(year: 1998, round: 1).laptime_rankings(1)}.to raise_error(BadQuery, "Fastest lap data isn't available for races before 2004")
    end
  end
end