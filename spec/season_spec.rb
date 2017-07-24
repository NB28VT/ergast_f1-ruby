require "spec_helper"
# This is in gem file. Make availabe?
require "pry"

RSpec.describe ErgastF1::Season do
  
  it "Handles a non-JSON response from the ErgastF1 server with a helpful message" do
    # Use webmock here
    pending("not implemented")
    fail
  end

  describe ".driver_standings" do
    it "returns the driver's championship standings" do
      season = ErgastF1::Season.new(1950)
      VCR.use_cassette("driver_standings") do
        standings = season.driver_standings
        expect(standings).to eq(ExpectedVars::Season::DRIVER_STANDINGS)
      end
    end 
  end

  describe ".constructor_standings" do
    it "returns the constructro's championship standings" do
      pending("not implemented")
      fail
    end 
  end

  describe ".races" do
    before (:each) do
      VCR.use_cassette("season_cassette") do
        @season = ErgastF1::Season.new(1950)
      end
    end

    it "returns a list of races for the supplied season if no round is specified" do
      races = @season.races
      expect(races).to eq(ExpectedVars::Season::SEASON_RACE_LIST_1950)
    end

    it "returns round data for a supplied round number" do
      monza_1950_race = @season.races(7)
      expect(monza_1950_race).to eq(ExpectedVars::Season::MONZA_1950_RACE)
    end

    it "returns an error if the round number doesn't exist, with a helpful message" do
      expect {@season.races(8)}.to raise_error(ApiError, "Nonexistent Round Number Specified")
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
