module Luggage
  module Matchers
    # Tests whether the validation value is present.
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

      # Returns whether the given value is "accepted".
      #
      # An "accepted" value is true, "t", "true", "1", "y", "yes".
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