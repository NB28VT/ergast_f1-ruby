require "spec_helper"
require "support/spec_helpers/response_validator/season_list"

RSpec.configure do |c|
  c.include SpecHelpers::ResponseValidator::SeasonList
end

RSpec.describe ErgastF1::SeasonList do
  context "when supplied a valid circuit name" do
    it "returns all seasons featuring that circuit" do
      VCR.use_cassette("season_list/suzuka_seasons") do
        season_list = ErgastF1::SeasonList.find(circuit: "Suzuka")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["circuitId"]).to eq("suzuka")
        expect(season_list["Seasons"].any?).to be true
      end
    end
  end

  context "when supplied an invalid circuit name" do
    it "returns an empty array" do
      VCR.use_cassette("season_list/rainbow_road") do
        season_list = ErgastF1::SeasonList.find(circuit: "RainbowRoad")
        expect(season_list["circuitId"]).to eq("rainbowroad")
        expect(season_list["Seasons"]).to eq([])
      end
    end
  end

  context "when supplied a valid constructor name" do
    it "returns all seasons a constructor competed in" do
      VCR.use_cassette("season_list/williams_seasons") do
        season_list = ErgastF1::SeasonList.find(constructor: "williams")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["constructorId"]).to eq("williams")
        expect(season_list["Seasons"].any?).to be true
      end
    end
  end

  context "when supplied an invalid constructor name" do
    it "returns an empty array" do
      VCR.use_cassette("season_list/racer_motors_seasons") do
        season_list = ErgastF1::SeasonList.find(constructor: "Racermotors")
        expect(season_list["constructorId"]).to eq("racermotors")
        expect(season_list["Seasons"]).to eq([])
      end
    end
  end

  context "when supplied a valid driver name" do
    it "returns all seasons a driver competed in" do
      VCR.use_cassette("season_list/schumacher_seasons") do
        season_list = ErgastF1::SeasonList.find(driver: "michael_schumacher")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["driverId"]).to eq("michael_schumacher")
        expect(season_list["Seasons"].any?).to be true
      end
    end
  end

  context "when supplied an invalid driver name" do
    it "returns an empty array" do
      VCR.use_cassette("season_list/GoMifune_seasons") do
        season_list = ErgastF1::SeasonList.find(driver: "GoMifune")
        expect(season_list["Seasons"]).to eq([])
      end
    end
  end

  context "when supplied a constructor and a driver" do
    it "returns all seasons that driver drove for that constructor" do
      VCR.use_cassette("season_list/schumacher_ferrari_seasons") do
        season_list = ErgastF1::SeasonList.find(driver: "michael_schumacher", constructor: "ferrari")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["driverId"]).to eq("michael_schumacher")
        expect(season_list["constructorId"]).to eq("ferrari")
        expect(season_list["Seasons"].any?).to be true
      end
    end
  end

  context "when supplied a constructor and a driver that never drove for that constructor" do
    it "returns an empty array" do
      VCR.use_cassette("season_list/constructor_with_wrong_driver") do
        season_list = ErgastF1::SeasonList.find(driver: "senna", constructor: "ferrari")
        expect(season_list["driverId"]).to eq("senna")
        expect(season_list["constructorId"]).to eq("ferrari")
        expect(season_list["Seasons"]).to eq([])
      end
    end
  end

  context "when supplied a constructor and a finishing position" do
    it "returns all seasons that that constructor finished in that position" do
      VCR.use_cassette("season_list/ferrari_titles") do
        season_list = ErgastF1::SeasonList.find(rank: 1, constructor: "ferrari")
        expect(valid_season_list?(season_list)).to be true
        expect(season_list["constructorStandings"]).to eq("1")
        expect(season_list["constructorId"]).to eq("ferrari")
        expect(season_list["Seasons"].any?).to be true
      end
    end
  end

  context "when supplied a constructor and a finishing position they never achieved" do
    it "returns an empty arry" do
      VCR.use_cassette("season_list/minardi_titles") do
        season_list = ErgastF1::SeasonList.find(rank: 1, constructor: "mindardi")
        expect(season_list["constructorId"]).to eq("mindardi")
        expect(season_list["constructorStandings"]).to eq("1")
        expect(season_list["Seasons"]).to eq([])
      end
    end
  end
end
