require "bundler/setup"
require "rspec_on_failure"
require 'byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'tempfile'
module Kernel
  # Was removed from active_support
  # Copied from https://apidock.com/rails/v4.2.7/Kernel/capture
  def capture(stream)
    stream = stream.to_s
    captured_stream = Tempfile.new(stream)
    stream_io = eval("$#{stream}")
    origin_stream = stream_io.dup
    stream_io.reopen(captured_stream)

    yield

    stream_io.rewind
    return captured_stream.read
  ensure
    captured_stream.close
    captured_stream.unlink
    stream_io.reopen(origin_stream)
  end
end
