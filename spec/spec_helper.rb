# require 'codeclimate-test-reporter'
# ::CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
Bundler.setup

require 'rspec'
require 'libis-services'

def check_container(expected, result)
  case expected
    when Array
      expect(result).to be_a Array
      expected.each_with_index { |value, i| check_container(value, result[i]) }
    when Hash
      expect(result).to be_a Hash
      expected.each_key do |key|
        expect(result[key]).not_to be_nil
        check_container(expected[key], result[key])
      end
    else
      expect(result).to eq expected
  end
end

