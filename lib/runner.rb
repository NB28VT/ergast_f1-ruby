require "net/http"
require "json"
require "awesome_print"

parsed_response = JSON.parse(Net::HTTP.get(URI("http://ergast.com/api/f1/2017/circuits/hungaroring/status/4/results.json")))

parsed_response.dig("MRData", "RaceTable", "Races", "Results").first