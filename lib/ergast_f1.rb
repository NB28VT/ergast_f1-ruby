require "ergast_f1/version"
require "ergast_f1/season"
require "ergast_f1/race"
require "ergast_f1/ergast_client"

require "json"
require "curb"

# TODO: INHERIT FROM MORE USEFUL ERROR TYPES
class BadQuery < StandardError; end
class ApiError < StandardError; end

class TestMe
  def self.hello
    puts "hello world"
  end
end


module ErgastF1
  # Your code goes here...
end
