module Luggage
  module Matchers
    # Tests whether the validation value is not included in the expected
    # value.
    #
    class Exclude < Matcher

      # Creates a new Exclude matcher instance.
      #
      # @param [#include?] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil)
        raise ArgumentError,
          'The Exclude matcher requires that a value which responds ' \
          'to #include? is supplied' unless expected.respond_to?(:include?)

        super
      end

      # Returns whether the given value is not included in the expected value.
      #
      # @param [#include?] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        not @expected.include?(actual)
      end

    end # Exclude
  end # Matchers
end # Luggage
