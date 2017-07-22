require "spec_helper"
# This is in gem file. Make availabe?
require "pry"

RSpec.describe ErgastF1::Season do
  before (:each) do
    VCR.use_cassette("season_cassette") do
      @season = ErgastF1::Season.new(1950)
    end
  end

  it "returns the current season if none is supplied" do
    pending("not implemented")
    fail
  end


  describe ".race_count" do
    it "returns the number of races in a season" do
      pending("not implemented")
      fail
    end
  end

  describe ".champion" do
    it "returns the name of the season's champion" do
      pending("not implemented")
      fail
    end
  end

  describe ".standings" do
    it "returns the season standings" do
      pending("not implemented")
      fail
    end 
  end

  describe ".races" do
    # it "returns a list of races for the supplied season if no round is specified" do
    #   races = @season.races
    #   expect(races).to eq(ExpectedVars::Season::SEASON_RACE_LIST_1950)
    # end

    # it "returns round data for a supplied round number" do
    #   monza_1950_race = @season.races(7)
    #   expect(monza_1950_race).to eq(ExpectedVars::Season::MONZA_1950_RACE)
    # end

    it "returns an error if the round number doesn't exist, with a helpful message" do
      expect(@season.races(8)).to raise_error(ApiError, "Nonexistent Round Number Specified")
    end
  end

end
