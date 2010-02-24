module Luggage
  module Matchers
    # Tests whether the validation value is accepted.
    #
    # An "accepted" value one which is exactly true, "t", "true", "1", "y",
    # or "yes".
    #
    # @example
    #
    #   class Person
    #     validate do |person|
    #       person.name.is.accepted
    #     end
    #   end
    #
    class Acceptance < Matcher

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil, *extra_args)
        expected = Array(expected || %w( t true y yes 1 ) + [1])
        @include_matcher = Include.new(expected)

        super(expected, *extra_args)
      end

      # Returns whether the given value is accepted.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        actual == true or @include_matcher.matches?(actual)
      end

    end # Acceptance
  end # Matchers
end # Luggage
