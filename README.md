# ErgastF1-Ruby
ErgastF1-Ruby is a Ruby gem wrapper for using [ErgastF1 API]http://ergast.com/mrd/].
It currently supports querying Formula 1 race results by driver, constructor, finishing position and finshing status. Future features include support for 
 

TODO: Delete this and the text above, and describe your gem

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
To return all data for a specific race, initialize an instance of `ErgastF1::Race` and supply a season year and either a round number or a circuit name:

```
ErgastF1::Race.new(year: 1989, round: 15)
ErgastF1::Race.new(year: 1989, circuit: "Suzuka")

```
Results from the ErgastF1 API are supplied as an array. If no results are found, an error message is returned:

```
BadQuery, "No results found."
```

You can query the results of a race using the `.result()` method, which accepts a hash of query parameters. For example, to get the result for a given driver in the event, supply the driver's name:
```
race = ErgastF1::Race.new(year: 2017, circuit: "Hungaroring")
race.result({driver: "Vettel"})
```
Other valid query parameters include:
```
position - result by final finishing position. Accepts a number.
grid_position - result by starting position. Accepts a number.
constructor - result by constructor. Accepts a constructor name (ex. "Ferrari")
status - result by finshing status (ex. "Finished" for drivers that completed the event, and "Engine" for drivers that ended the race with an engine failure)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nathan Burgess/ergast_f1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

