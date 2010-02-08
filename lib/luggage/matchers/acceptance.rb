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
    #     validate(:terms).is.accepted
    #   end
    #
    class Acceptance < Matcher

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil, *extra_args)
        @@_include_matcher ||= Include.new(%w( t true y yes 1 ) + [1])

        super
      end

      # Returns whether the given value is accepted.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        if actual == true or actual == false
          actual
        elsif actual.respond_to?(:to_s)
          @@_include_matcher.matches?(actual.to_s.downcase)
        else
          false
        end
      end

    end # Acceptance
  end # Matchers
end # Luggage
