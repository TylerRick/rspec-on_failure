# RSpecOnFailure

Provide additional debugging information to be printed if a test fails.

In case the debugging information you want to display on failure cannot be easily determined *prior*
to evaluating the expectation. This won't work as expected, for example:

```ruby
expect(user).to be_valid, user.errors.full_messages
```

because `user.errors.full_messages` gets evaluated too soon. This will show the list of errors as it
was *prior* to calling `user.valid?` (that is, an empty array), rather than the list of errors as it
was *after* validating therecord, which is what we actually want.

Instead, you can do this, which defers evaluation of the debug information until the time of the
failure:

```ruby
   on_failure ->{ user.errors.full_messages } do
     expect(user).to be_valid
   end
```

If no block is given, the provided on_failure proc remains in effect until the end of the current
example.

```ruby
   on_failure ->{ user.errors.full_messages }
   expect(user).to be_valid
   expect(user.errors[:name]).to include "is required"
```

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rspec-on_failure'
end
```

And then execute:

    $ bundle

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TylerRick/rspec-on_failure.
