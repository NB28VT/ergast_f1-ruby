# ErgastF1-Ruby
ErgastF1-Ruby is a Ruby gem wrapper for using the [ErgastF1 API](http://ergast.com/mrd/).
It current supports querying Formula 1 race results by season year and round number of circuit name. Additionally, it includes support for filtering a race result by driver, constructor, finishing position, grid position and finishing status/cause of retirement (ex. "Finished", "Gearbox", "Engine"). Future features will include schedules, qualifying results, standings, driver information and more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ergast_f1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ergast_f1

## Usage

### Querying Race Results
To return all data for a specific race, initialize an instance of `ErgastF1::Race` with a season year and either a round number or a circuit name and call `.result`:

```
ErgastF1::Race.new(year: 1989, round: 15).result
ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result

```
Results from the ErgastF1 API are supplied as an array. If no results are found, an empty array is returned.

### Filtering results
Results can be filtered by a number of parameters:

```
race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")

#Constructor Name
race.constructor_result("Ferrari")

#Driver Family Name
race.driver_result("Vettel")

#Starting Grid Position
race.grid_position(6)

#Fastest Laptime Ranking - the driver with the supplied ranking for fastest laptime
race.laptime_ranking(1)

```
### Filtering by finishing status
ErgastF1-Ruby supports filtering race results by a scored "finishing status", i.e., if the driver finished or, if they retired, the reason why.
```
race.finishing_status("Engine")
```
Valid Filters For Finishing Status:

* Finished
* Disqualified
* Accident
* Collision
* Engine
* Gearbox
* Transmission
* Clutch
* Hydraulics
* Electrical
* Spun
* Radiator
* Suspension
* Brakes
* Differential
* Overheating
* Mechanical
* Tyre
* Driver Seat
* Puncture
* Driveshaft

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nathan Burgess/ergast_f1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

