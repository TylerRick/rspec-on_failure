require 'spec_helper'

RSpec.describe 'on_failure', on_failure: ->(example) { "proc from metadata: example: #{example.inspect}" } do
  def expect_failure_and_capture_output
    output = capture(:stdout) {
    expect {
      yield
    }.to raise_exception RSpec::Expectations::ExpectationNotMetError
    }
  end

  it('on_failure with a block, failing for that block') do
    output = expect_failure_and_capture_output {
      on_failure -> { 'in effect for this block only' } do
        expect(true).to eq false
      end
    }
    expect(output).to eq "\"in effect for this block only\"\n"
  end

  it('on_failure with a block, not failing for that block') do
    output = expect_failure_and_capture_output {
      on_failure -> { 'in effect for this block only' } do
        expect(true).to eq true
      end
      expect(true).to eq false
    }
    expect(output).to eq ""
  end

  it('on_failure with no block') do
    output = expect_failure_and_capture_output {
      on_failure -> { 'in effect until end of example' }
      on_failure -> { 'in effect for this block only' } do
        expect(true).to eq false
      end
    }
    expect(output).to eq "\"in effect for this block only\"\n"
    # can't check here for "in effect until end of example" because that is output *after* the example
  end
end
