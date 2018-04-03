# ErgastF1-Ruby
ErgastF1-Ruby is a Ruby gem wrapper for using the [ErgastF1 API](http://ergast.com/mrd/).
It currently supports querying and filtering Formula 1 race results and seasons by year, driver, constructor, circuit name and more.

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

>Note: Results from the ErgastF1 API are supplied as an array. If no results are found, an empty array is returned.

### Querying Race Results
Results data for a specific race is available by passing a season year and either the round number for that race in the Formula 1 World Championship that year, or the name of the circuit where the race was held.

```ruby
ErgastF1::Race.new(year: 1989, round: 15).result
ErgastF1::Race.new(year: 1989, circuit: "Suzuka").result

```

#### Filtering results
Results for each race can be filtered by a number of parameters:

```ruby
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

>#### Note on Driver Names
Driver results from the ErgastF1 API can be queried in most cases using the driver's last name. However, certain drivers who share a last name with another historical driver may only respond to a snakecase version of their full name. (Example, results for Michael Schumacher and Damon Hill are only available by passing "michael_schumacher" and "damon_hill" respectively).


#### Filtering by finishing status
ErgastF1-Ruby supports filtering race results by a scored "finishing status", i.e., if the driver finished or, if they retired, the reason why.
```ruby
race.finishing_status("Engine")
```
> Valid filters for finishing status include: ("Finished", "Disqualified", "Accident", "Collision", "Engine", "Gearbox", "Transmission", "Clutch", "Hydraulics", "Electrical", "Spun", "Radiator", "Suspension", "Brakes", "Differential", "Overheating", "Mechanical", "Tyre", "Driver Seat", "Puncture", "Driveshaft")

### Querying Season Lists



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nathan Burgess/ergast_f1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
