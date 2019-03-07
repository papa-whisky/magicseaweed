# Magicseaweed CLI

[![Powered by Magicseaweed](https://im-1-uk.msw.ms/msw_powered_by.png)](https://magicseaweed.com)

Check surf forecasts from [Magicseaweed](https://magicseaweed.com) in your terminal.

## Requirements

- [Ruby](https://www.ruby-lang.org/en) ~> 2.6

(I'm sure it will run in many earlier versions as well, but haven't tested.)

## Installation

```console
$ gem install magicseaweed
Successfully installed magicseaweed-0.1.0
```

## Usage

To view a basic star-rating forecast for a given spot for the next five days:

```console
$ magicseaweed API_KEY SPOT_ID
Spot: SPOT_ID
Forecast:
Thu: ***, Fri: **, Sat: **, Sun: **, Mon:
```

To get an API key you'll need to contact Magicseaweed, there's more info on their [developer page](https://magicseaweed.com/developer/api).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/papa-whisky/magicseaweed](https://github.com/papa-whisky/magicseaweed).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
