module Ward
  module Matchers
    # Tests whether the validation value matches the expected value with a
    # regular expression.
    #
    # @example
    #
    #   class Person
    #     validate do |person|
    #       person.name.matches(/^Michael (Scarn|Scott)$/)
    #     end
    #   end
    #
    class Match < Matcher

      # Returns whether the given value matches the expected value.
      #
      # @param [#include?] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        actual.match(@expected)
      end

    end # Match
  end # Matchers
end # Ward
