# Changelog

This project follows [semver 2.0.0](http://semver.org/spec/v2.0.0.html) and the
recommendations of [keepachangelog.com](http://keepachangelog.com/).

## (Unreleased)

## 1.0.1 (2019-10-18)
- Rename to rspec-on_failure

## 1.0.0 (2019-10-18)

### Breaking changes
- Rescue a broader set of exceptions, not just `RSpec::Expectations::ExpectationNotMetError`

### Fixed
- It was failing to trigger the `on_failure` block when the failure was due to an
  exception other than a `ExpectationNotMetError`, like `Capybara::ElementNotFound`.

