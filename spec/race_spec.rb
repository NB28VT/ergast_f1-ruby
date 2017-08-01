require "spec_helper"
RSpec.describe ErgastF1::Race do

  describe ".result" do
    # Keep this test in sync or remove
    # it "returns the latest race results if no race is supplied" do
    #   # Note this will change in the future
    #   VCR.use_cassette("latest_race_result") do
    #     result = ErgastF1::Race.new.result
    #     expect(result).to eq(ExpectedVars::Race::LATEST_RACE)
    #   end
    # end

     it "returns the result of a race when supplied a season year and a round number" do
      VCR.use_cassette("suzuka_1989_by_round") do
        result = ErgastF1::Race.new(year: 1989, round: 15).result
        expect(result).to eq(ExpectedVars::Race::SUZUKA_1989)
      end
    end

    it "returns an error if the supplied round number doesn't exist for the year" do
      VCR.use_cassette("nonexistent_round") do
        race = ErgastF1::Race.new(year: 1989, round: 20)
        expect {race.result}.to raise_error(BadQuery, "The supplied race could not be found.")
      end
      
    end

    it "returns the result of a race when supplied a season year and circuit name" do
      VCR.use_cassette("suzuka_1989_by_circuit_name") do
        result = ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result
        expect(result).to eq(ExpectedVars::Race::SUZUKA_1989)
      end
    end

    it "returns an error if the supplied circuit name doesn't exist for the year" do
      VCR.use_cassette("nonexistent_1989_circuit_name") do
        expect {ErgastF1::Race.new(year: 1989, circuit: "Malaysia").result}.to raise_error(BadQuery, "The supplied race could not be found.")
      end
    end

    it "returns the final season race results if a season is supplied, but a round isn't" do
      VCR.use_cassette("last_round_1997") do
        result = ErgastF1::Race.new(year: 1997).result
        expect(result).to eq(ExpectedVars::Race::LAST_ROUND_1997)
      end
    end
  end

  describe ".fastest_lap" do
    it "returns the fastest lap of the race" do
      VCR.use_cassette("fastest_lap_australia_2017") do
        race = ErgastF1::Race.new(year: 2017, round: 1)
        result = race.fastest_lap
        expect(result).to eq(ExpectedVars::Race::FASTEST_LAP_AUSTRALIA_2017)
      end
    end
    
    it "returns a helpful message if the year supplied is before 2004" do
      expect {ErgastF1::Race.new(year: 1998, round: 1).fastest_lap}.to raise_error(BadQuery, "Fastest lap data isn't available for races before 2004")
    end
  end

  describe ".finishing position" do
    it "returns the finishing position of a supplied driver by name" do
      race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
      vettel_finishing_position = race.finishing_position("Vettel")
      expect(vettel_finishing_position).to eq(1)
    end

    it "returns the finishing position of a supplied driver by name" do
      race = ErgastF1::Race.new(year: 1994, circuit: "Monaco") 
      expect{race.finishing_position("Senna")}.to raise_error(BadQuery, "The supplied driver did not compete in this race.")
    end
  end
end