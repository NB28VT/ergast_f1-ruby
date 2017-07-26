require "net/http"
require "json"
require "awesome_print"


parsed_response = JSON.parse(Net::HTTP.get(URI("http://ergast.com/api/f1/current/last/results.json")))


parsed_response.dig("MRData", "RaceTable", "Races")