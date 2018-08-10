# RspecOnFailure

Provide additional debugging information to be printed if a test fails.

In case the debugging information you want to display on failure cannot be easily determined prior
to evaluating the expectation. This won't work as expected, for example:

  expect(user).to be_valid, user.errors.full_messages

because user.errors.full_messages is evaluated *before* it actually calls user.valid?, so it will be empty.

Instead, you can do this, which defers evaluation of the debug information until the time of the
failure:

   on_failure ->{ user.errors.full_messages } do
     user.should be_valid
   end

If no block is given, the provided on_failure proc remains in effect until the end of the current
example.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec_on_failure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_on_failure

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TylerRick/rspec_on_failure.
