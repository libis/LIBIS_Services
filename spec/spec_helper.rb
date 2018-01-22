# require 'codeclimate-test-reporter'
# ::CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
Bundler.setup

require 'rspec'
require 'rspec/matchers'
require 'libis-services'

# adapted from https://gist.github.com/mltsy/21fd5e15ae12a004c8b13d6ec4534458
RSpec::Matchers.define :deep_include do

  match {|actual| deep_include?(actual, expected)}

  def deep_include?(actual, expected, path = [])
    return true if actual == expected

    @failing_actual = actual
    @failing_expected = expected
    @failing_path = path

    case expected
      when Array
        return false unless actual.is_a? Array
        expected.each_with_index do |expected_item, index|
          match_found = actual.any? do |actual_item|
            deep_include? actual_item, expected_item, path + [index]
          end
          unless match_found
            @failing_array = actual
            @failing_array_path = path + [index]
            @failing_expected_array_item = expected_item
            return false
          end
        end
      when Hash
        return false unless actual.is_a? Hash
        expected.all? do |key, expected_value|
          return false unless actual.has_key? key
          deep_include? actual[key], expected_value, path + [key]
        end
      else
        false
    end
  end

  failure_message do |_actual|
    if @failing_array_path
      path = @failing_array_path.map {|p| "[#{p.inspect}]"}.join
      path = "root" if path.blank?
      message = "Actual array did not include value at #{path}: \n" +
          "  expected #{@failing_expected_array_item.inspect}\n" +
          "  but matching value not found in array: #{@failing_array}\n"
    else
      path = @failing_path.map {|p| "[#{p.inspect}]"}.join
      path = "root" if path.blank?
      message = "Actual hash did not include expected value at #{path}: \n" +
          "  expected #{@failing_expected.inspect}\n" +
          "  got #{@failing_actual.inspect}\n"
    end

    message
  end
end

def check_container(expected, result)
  # puts "Checking expected: #{expected} vs result: #{result}"
  case expected
    when Array
      # puts "Checking if result is an array"
      expect(result).to be_a Array
      expected.each do |value|
        # puts "Checking if expected value: #{value} included in result"
        expect(result).to include(value)
      end
    when Hash
      # puts "Checking if result is a hash"
      expect(result).to be_a Hash
      expected.each_key do |key|
        # puts "Checking if expected key: #{key} included in result"
        expect(result).to include(key)
        check_container(expected[key], result[key])
      end
    else
      # puts "Checking if expected equals result"
      expect(result).to eq expected
  end
end
