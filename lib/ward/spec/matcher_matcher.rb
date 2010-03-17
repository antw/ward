module Ward
  module Spec
    # Since Ward matchers are permitted to return either false, or an Array
    # whose first member is false, to indicate a failure, determining the
    # status of a match attempt relies in you knowing this in advance:
    #
    #     result, error = matcher.matches?(value)
    #     result.should be_false
    #
    # The helpers within the MatcherMatcher module simplify this situation:
    #
    #     matcher.should pass_matcher_with(value)
    #     matcher.should fail_matcher_with(value)
    #
    # The +fail_matcher_with+ helper also provides the ability to check the
    # error message returned by the matcher:
    #
    #     matcher.should fail_matcher_with(value, :too_short)
    #
    module MatcherMatcher

      # Formats error messages for spec failures.
      #
      # @param [String, Symbol] result
      #   Did you expect a :pass or :fail?
      # @param [Ward::Matchers::Matcher] matcher
      #   The matcher instance which was used for the expectation.
      # @param [Object] value
      #   The actual value which was supplied to the Ward matcher.
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

      # An RSpec matcher which tests that the Ward matcher passes with a
      # particular value.
      #
      ::Spec::Matchers.define :pass_matcher_with do |value|
        match do |matcher|
          case result = matcher.matches?(value)
            when false, nil then false
            when Array      then !! result.first
            else                 true
          end
        end

        failure_message_for_should do |matcher|
          Ward::Spec::MatcherMatcher.error_message(:pass, matcher, value)
        end

        failure_message_for_should_not do |matcher|
          Ward::Spec::MatcherMatcher.error_message(:fail, matcher, value)
        end
      end

      # An RSpec matcher which tests that the Ward matcher fails with a
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
          elsif result == false || result.nil?
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
            Ward::Spec::MatcherMatcher.error_message(:fail, matcher, value)
          end
        end

        failure_message_for_should_not do |matcher|
          Ward::Spec::MatcherMatcher.error_message(:pass, matcher, value)
        end
      end

    end # MatcherMatcher
  end # Spec
end # Ward
