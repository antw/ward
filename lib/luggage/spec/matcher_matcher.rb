module Luggage
  module Spec
    module MatcherMatcher

      # Formats error messages for spec failures.
      #
      # @param [String, Symbol] result
      #   Did you expect a :pass or :fail?
      # @param [Luggage::Matchers::Matcher] matcher
      #   The matcher instance which was used for the expectation.
      # @param [Object] value
      #   The actual value which was supplied to the Luggage matcher.
      #
      # @return [String]
      #
      def self.error_message(result, matcher, value)
        status = if result.to_sym == :pass then 'failed' else 'passed' end

        expected = unless matcher.expected.nil?
          "expected: #{matcher.expected.inspect}, "
        end

        "expected #{matcher.class.inspect} matcher to #{result}, but it " \
        "#{status} (#{expected}actual: #{value.inspect})"
      end

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
          Luggage::Spec::MatcherMatcher.error_message(:pass, matcher, value)
        end

        failure_message_for_should_not do |matcher|
          Luggage::Spec::MatcherMatcher.error_message(:fail, matcher, value)
        end
      end

      # An RSpec matcher which tests that the Luggage matcher fails with a
      # particular value.
      #
      ::Spec::Matchers.define :fail_matcher_with do |value|
        # Allows further customisation of the matcher, asserting that a
        # particular error message was returned along with the failure. Using
        # this with +should_not+ makes little sense.
        #
        # @param [Symbol, String] expected_error
        #
        def with_error(expected_error)
          @expected_error = expected_error
          self
        end

        match do |matcher|
          result, error = matcher.matches?(value)

          if @expected_error and not error.eql?(@expected_error)
            @actual_error = error
            false
          elsif result == false
            true
          else
            false
          end
        end

        failure_message_for_should do |matcher|
          if @actual_error
            expected = unless matcher.expected.nil?
              "expected: #{matcher.expected.inspect}, "
            end

            "expected #{matcher.class.inspect} matcher to fail with error " \
            "#{@expected_error.inspect}, but it failed with " \
            "#{@actual_error.inspect} (#{expected}actual: #{value.inspect})"
          else
            Luggage::Spec::MatcherMatcher.error_message(:fail, matcher, value)
          end
        end

        failure_message_for_should_not do |matcher|
          Luggage::Spec::MatcherMatcher.error_message(:pass, matcher, value)
        end
      end

    end # MatcherMatcher
  end # Spec
end # Luggage
