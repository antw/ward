module Luggage
  module Matchers
    # Tests whether the validation value is equal in value to -- but not
    # necessarily the same object as -- the expected value.
    #
    class EqualTo < Matcher

      # Returns whether the given value is equal to the expected value.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        actual.eql?(@expected)
      end

    end # EqualTo
  end # Matchers
end # Luggage
