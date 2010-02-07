module Luggage
  module Matchers
    # A base class used for creating custom matchers.
    #
    # @abstract
    #
    class Matcher

      # Returns the expected value.
      #
      # @return [Object]
      #
      attr_reader :expected

      # Returns any extra arguments given to the matcher.
      #
      # @return [Array]
      #
      attr_reader :extra_args

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil, *extra_args)
        @expected   = expected
        @extra_args = extra_args
        @actual     = nil
      end

      # Returns whether the given value matches the expected value.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      # @abstract
      #
      def matches?(actual)
        true
      end

    end # Matcher
  end # Matchers
end # Luggage
