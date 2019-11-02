# RedshiftSanitizer

Kill redshift load errors with this helper gem. Stop worry about redshift string anymore.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redshift_sanitizer'
```

Config your setting, default settings are as follows

```ruby
RedshiftSanitizer.configure do |config|
  config.delimeter = "^"
  config.replace = ""
  config.eof = "\n"
end
```

## Usage

Clean your target string

```ruby
RedshiftSanitizer.clean(YOUR_STRING)
```

## Best Practices

1. use `ESCAPE`
2. use `NULL AS '\000'`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redshift_sanitizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RedshiftSanitizer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/redshift_sanitizer/blob/master/CODE_OF_CONDUCT.md).
