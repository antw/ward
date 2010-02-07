module Luggage
  module Matchers
    # Tests whether the validation value is contained in the expected value.
    #
    class Include < Matcher

      # Creates a new Include matcher instance.
      #
      # @param [#include?] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil)
        raise ArgumentError,
          'The Include matcher requires that a value which responds ' \
          'to #include? is supplied' unless expected.respond_to?(:include?)

        super
      end

      # Returns whether the given value is included in the expected value.
      #
      # @param [#include?] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        @expected.include?(actual)
      end

    end # Include
  end # Matchers
end # Luggage
