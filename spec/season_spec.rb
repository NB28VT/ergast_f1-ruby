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

  describe ".races" do
    it "returns a list of races for the supplied season" do
      # BLAGGHHHH SYMBOLIZE KEYS LAMEO
      races = @season.races
      expect(races).to eq(ExpectedVars::Season::SEASON_RACE_LIST_1950)
    end


    it "returns round data for a supplied round number" do
      pending("not implemented")
      fail
    end

    it "return an error if the round number doesn't exist" do
      pending("not implemented")
      fail
    end

    it "returns the number of races in a season" do
      pending("not implemented")
      fail
    end

  end

end
