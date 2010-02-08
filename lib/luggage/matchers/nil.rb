module Luggage
  module Matchers
    # Tests whether the validation value is nil.
    #
    # @todo Remove once the predicate matcher DSL is available.
    #
    # @example
    #
    #   class AverageDogWalker
    #     validate(:common_sense).is.nil  # Sigh.
    #   end
    #
    class Nil < Matcher

      # Returns whether the given value is nil.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        actual.nil?
      end

    end # Nil
  end # Matchers
end # Luggage
