RSpec.describe ErgastF1::Season do  
  it "Handles a non-JSON response from the ErgastF1 server with a helpful message" do
    pending("not implemented")
    fail

    # Use webmock here
    # season = ErgastF1::Season.new(1950)
    # expect {season.races}.to raise_error(ApiError, "Error: invalid JSON reponse from ErgastF1 server")
  end

  describe ".driver_standings" do
    it "returns the driver's championship standings" do
      VCR.use_cassette("driver_standings") do
        standings = ErgastF1::Season.new(1950).driver_standings
        expect(standings).to eq(ExpectedVars::Season::DRIVER_STANDINGS_1950)
      end
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