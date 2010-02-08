module Luggage
  module Spec
    module MatcherMatcher

      EXPECTED_PASS = "expected %s matcher to pass (expected: %s, " \
                      "actual: %s), but it failed"

      EXPECTED_FAIL = "expected %s matcher to fail (expected: %s, " \
                      "actual: %s), but it passed"

      # An RSpec matcher which tests that the Luggage matcher passes with a
      # particular value.
      #
      ::Spec::Matchers.define :pass_matcher_with do |value|
        match do |matcher|
          case result = matcher.matches?(value)
            when false then false
            when Array then result.first
            else            true
          end
        end

        failure_message_for_should do |matcher|
          Luggage::Spec::MatcherMatcher::EXPECTED_PASS % [
            matcher.class.inspect, matcher.expected.inspect, value.inspect ]
        end

        failure_message_for_should_not do |matcher|
          Luggage::Spec::MatcherMatcher::EXPECTED_FAIL % [
            matcher.class.inspect, matcher.expected.inspect, value.inspect ]
        end
      end

      # An RSpec matcher which tests that the Luggage matcher fails with a
      # particular value.
      #
      ::Spec::Matchers.define :fail_matcher_with do |value|
        match do |matcher|
          case result = matcher.matches?(value)
            when false then true
            when Array then not result.first
            else            not result
          end
        end

        failure_message_for_should do |matcher|
          Luggage::Spec::MatcherMatcher::EXPECTED_FAIL % [
            matcher.class.inspect, matcher.expected.inspect, value.inspect ]
        end

        failure_message_for_should_not do |matcher|
          Luggage::Spec::MatcherMatcher::EXPECTED_PASS % [
            matcher.class.inspect, matcher.expected.inspect, value.inspect ]
        end
      end

    end # MatcherMatcher
  end # Spec
end # Luggage
