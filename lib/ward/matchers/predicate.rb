module Ward
  module Matchers
    # Tests that a predicate method responds with true.
    #
    # @example Validating that the predicate method responds with true.
    #
    #   class Person
    #     validate do |person|
    #       person.is.important?
    #     end
    #   end
    #
    class Predicate < Matcher

      # Returns whether the given value is responds true to the predicate.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        raise ArgumentError, "#{actual.inspect} does not respond " \
          "to #{expected}" unless actual.respond_to?(@expected)

        actual.__send__(@expected)
      end

    end # Predicate
  end # Matchers
end # Ward
