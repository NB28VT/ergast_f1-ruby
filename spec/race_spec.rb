RSpec.describe ErgastF1::Race do

  describe ".result" do
    it "returns the latest race results if no race is supplied" do
      # Note this will change in the future
      VCR.use_cassette("latest_race_result") do
        result = ErgastF1::Race.new.result
        expect(result).to eq(ExpectedVars::Race::LATEST_RACE)
      end
    end

    it "returns the final season race results if a season is supplied, but a round isn't" do
      result = ErgastF1::Race.new(1997).result
      expect(result).to eq(ExpectedVars::Race::LAST_ROUND_1997)
    end

    it "returns the result of a race when supplied a season year and a round number" do
      # Suzuka?
      result = ErgastF1::Race.new(1989, 15).result
      expect(result).to eq(ExpectedVars::Race::LAST_ROUND_1997)
    end

    it "returns an error if the supplied round number doesn't exist for the year" do
      pending("not implemented")
      fail
    end

    it "returns the result of a race when supplied a season year and circuit name" do
      pending("not implemented")
      fail
    end

    it "returns an error if the supplied circuit name doesn't exist for the year" do
      pending("not implemented")
      fail
    end

    it "returns the result of a race when supplied a season year and circuit id" do
      pending("not implemented")
      fail
    end

    it "returns an error if the supplied circuit id doesn't exist for the year" do
      pending("not implemented")
      fail
    end
  end


  describe ".fastest_lap" do
    it "returns the fastest lap of the race" do
      pending("not implemented")
      fail
    end
    
    it "returns a helpful message if the year supplied is before 2004" do
      # Records not available before 2004
      pending("not implemented")
      fail
    end
  end

  describe ".finishing position" do
    it "returns the finishing position of a supplied driver by name" do
      pending("not implemented")
      fail
    end

    it "returns the finishing position of a supplied driver by id" do
      pending("not implemented")
      fail
    end
    
    it "returns a helpful message if a supplied driver did not compete in the race" do
      pending("not implemented")
      fail
    end


  end


end