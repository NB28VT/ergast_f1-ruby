require "ergast_f1/version"
require "ergast_f1/season"
require "ergast_f1/season_list"
require "ergast_f1/race"
require "ergast_f1/ergast_client"

# TODO: INHERIT FROM MORE USEFUL ERROR TYPES
class BadQuery < StandardError; end
class ApiError < StandardError; end

module ErgastF1
  # Your code goes here...
end
