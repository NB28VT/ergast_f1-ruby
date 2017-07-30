require "ergast_f1/version"
require "ergast_f1/season"
require "ergast_f1/race"
require "ergast_f1/ergast_client"

# TODO: INHERIT FROM MORE USEFUL ERROR TYPES
class ApiError < StandardError; end
class RaceNotFound < StandardError; end
class CircuitNotFound < StandardError; end

module ErgastF1
  # Your code goes here...
end

