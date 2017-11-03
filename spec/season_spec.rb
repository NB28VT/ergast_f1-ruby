require "spec_helper"
require "support/spec_helpers/response_validator/season"

RSpec.configure do |c|
  c.include SpecHelpers::ResponseValidator::Season
end

RSpec.describe ErgastF1::Season do  
  describe ".driver_standings" do
    context "when supplied a year" do
      it "returns the driver's championship standings for that year" do
        VCR.use_cassette("season/driver_standings_1950") do
          standings = ErgastF1::Season.driver_standings(1950)
          expect(valid_season?(standings)).to be true
          expect(for_year?(1950)).to be true
        end
      end
    end
  end

  describe ".winners" do
    it "returns a list of winners for a given season by driver" do
      pending("not implemented")
      fail
      # VCR.use_cassette("suzuka_1989_by_circuit_name") do
      #   result = ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result
      #   expect(result).to eq(ExpectedVars::Race::SUZUKA_1989)
      # end
    end
  end

  describe ".winners" do
    it "returns a list of winners for a given season by constructor" do
      pending("not implemented")
      fail
      
      # VCR.use_cassette("suzuka_1989_by_circuit_name") do
      #   result = ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result
      #   expect(result).to eq(ExpectedVars::Race::SUZUKA_1989)
      # end
    end
  end

  describe ".constructor_standings" do
    it "returns the constructor's championship standings" do
      VCR.use_cassette("construction_standings") do
        standings = ErgastF1::Season.new(1992).constructor_standings
        expect(standings).to eq(ExpectedVars::Season::CONSTRUCTOR_STANDINGS_1992)
      end
    end
  end

  describe ".races" do
    before(:each) do
      @season_1950 = ErgastF1::Season.new(1950)
    end

    it "returns a list of races for the supplied season if no round is specified" do
      VCR.use_cassette("season_cassette") do
        races = @season_1950.races
        expect(races).to eq(ExpectedVars::Season::SEASON_RACE_LIST_1950)
      end
    end

    it "returns round data for a supplied round number" do
      VCR.use_cassette("season_cassette") do
        monza_1950_race = @season_1950.races(7)
        expect(monza_1950_race).to eq(ExpectedVars::Season::MONZA_1950_RACE)
      end
    end

    it "returns an error if the round number doesn't exist, with a helpful message" do
      VCR.use_cassette("season_cassette") do
        expect {@season_1950.races(8)}.to raise_error(ApiError, "Nonexistent Round Number Specified")
      end
    end

    it "returns the current season if none is supplied" do
      VCR.use_cassette("current_season_cassette") do
        season = ErgastF1::Season.new
        races = season.races
        expect(races).to eq(ExpectedVars::Season::CURRENT_SEASON)
      end
    end    
  end
end