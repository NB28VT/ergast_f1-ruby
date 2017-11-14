require "spec_helper"

# Probably not necessary
# require "support/spec_helpers/response_validator/season_list"
#
# RSpec.configure do |c|
#   c.include SpecHelpers::ResponseValidator::SeasonList
# end

RSpec.describe ErgastF1::SeasonList do
  context "when supplied a valid circuit name" do
    it "returns all seasons featuring that circuit" do
      VCR.use_cassette("season_list/suzuka_seasons") do
        season_list = ErgastF1::SeasonList.new(circuit: "Suzuka")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["circuit"]).to eq("suzuka")
      end
    end
  end

  context "when supplied an invalid circuit name" do
    it "returns an empty array" do
      season_list = ErgastF1::SeasonList.new(circuit: "RainbowRoad")
      expect(season_list).to eq([])
    end
  end

  context "when supplied a valid constructor name" do
    it "returns all seasons a constructor competed in" do
      VCR.use_cassette("season_list/williams_seasons") do
        season_list = ErgastF1::SeasonList.new(constructor: "williams")
        expect(valid_season_list?(season_list)).to be true
        # TODO: MAYBE NOT IN HELPER
        expect(season_list["constructor"]).to eq("williams")
      end
    end
  end

  context "when supplied an invalid constructor name" do
    it "returns an empty array" do
      season_list = ErgastF1::SeasonList.new(constructor: "Racermotors")
      expect(season_list).to eq([])
    end
  end

  context "when supplied a valid driver name" do
    it "returns all seasons a driver competed in" do
      VCR.use_cassette("season_list/schumacher_seasons") do
        season_list = ErgastF1::SeasonList.new(driver: "schumacher")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["driver"]).to eq("schumacher")
      end
    end
  end

  context "when supplied an invalid driver name" do
    it "returns an empty array" do
      season_list = ErgastF1::SeasonList.new(driver: "GoMifune")
      expect(season_list).to eq([])
    end
  end

  context "when supplied a constructor and a driver" do
    it "returns all seasons that driver drove for that constructor" do
      VCR.use_cassette("season_list/schumacher_ferrari_seasons") do
        season_list = ErgastF1::SeasonList.new(driver: "schumacher", constructor: "ferrari")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["driver"]).to eq("schumacher")
        expect(season_list["constructor"]).to eq("ferrari")
      end
    end
  end

  context "when supplied a constructor and a driver that never drove for that constructor" do
    it "returns an empty array" do
      VCR.use_cassette("season_list/constructor_with_wrong_driver") do
        season_list = ErgastF1::SeasonList.new(driver: "senna", constructor: "ferrari")
        expect(season_list).to eq([])
      end
    end
  end

  context "when supplied a constructor and a finishing position" do
    it "returns all seasons that that constructor finished in that position" do
      VCR.use_cassette("season_list/ferrari_titles") do
        season_list = ErgastF1::SeasonList.new(finishing_position: 1, constructor: "ferrari")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["finishing_position"]).to eq(1)
      end
    end
  end

  context "when supplied a constructor and a finishing position they never achieved" do
    it "returns an empty arry" do
      VCR.use_cassette("season_list/minardi_titles") do
        season_list = ErgastF1::SeasonList.new(finishing_position: 1, constructor: "mindardi")
        expect(season_list).to eq([])
      end
    end
  end
end

def valid_season_list(result)
  # TODO IMPLEMENT
  false
end
