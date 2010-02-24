module Luggage
  module Matchers
    # Tests whether the validation value is equal in value to -- but not
    # necessarily the same object as -- the expected value.
    #
    # @example
    #
    #   class Person
    #     validate do |person|
    #       person.name.is.equal_to('Michael Scarn')
    #     end
    #   end
    #
    # @todo
    #   Once the validator DSL is is available, amend the class documentation
    #   to provide an example of how to call +is+ and +is_not+ with a value.
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
