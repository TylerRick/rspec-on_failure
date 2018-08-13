require "rspec_on_failure/version"

module RspecOnFailure
  # Provide additional debugging information to be printed if a test fails.
  #
  # In case the debugging information you want to display on failure cannot be easily determined prior
  # to evaluating the expectation. This won't work as expected, for example:
  #
  #   expect(user).to be_valid, user.errors.full_messages
  #
  # because user.errors.full_messages is evaluated *before* it actually calls user.valid?, so it will be empty.
  #
  # Instead, you can do this, which defers evaluation of the debug information until the time of the
  # failure:
  #
  #    on_failure ->{ user.errors.full_messages } do
  #      user.should be_valid
  #    end
  #
  # If no block is given, the provided on_failure proc remains in effect until the end of the current
  # example.
  #
  def on_failure(on_failure_proc)
    if block_given?
      on_failure_call_proc(on_failure_proc) do
        yield
      end
    else
      # The provided proc remains in effect until the end of the current example
      @_on_failure_proc = on_failure_proc
    end
  end

  def on_failure_call_proc(on_failure_proc)
    begin
      yield
    rescue RSpec::Expectations::ExpectationNotMetError
      run_failure_call_proc on_failure_proc
      raise
    end
  end

  def run_failure_call_proc(on_failure_proc, *args)
    return unless on_failure_proc
    result = on_failure_proc.call *[args].first(on_failure_proc.arity)
    p result unless result.nil?
  end
end

RSpec.configure do |config|
  config.include RspecOnFailure
  config.after(:each) do |example|
    begin
      if example.exception.is_a? RSpec::Expectations::ExpectationNotMetError
        run_failure_call_proc example.metadata[:on_failure], example
        #puts %(@_on_failure_proc=#{(@_on_failure_proc).inspect})
        run_failure_call_proc @_on_failure_proc,             example
      end
    ensure
      @_on_failure_proc = nil
    end
  end
end
