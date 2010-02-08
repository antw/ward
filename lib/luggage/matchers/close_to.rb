module Luggage
  module Matchers
    # Tests whether the validation value is within the delta of the expected
    # value.
    #
    # @example Validating that the estimate attribute is 10 (+- 5).
    #
    #   class Price
    #     validate(:estimate).is.close_to(10, 5)
    #   end
    #
    class CloseTo < Matcher

      # Creates a new CloseTo matcher instance.
      #
      # @param [Numeric] expected
      #   The expected value for the matcher.
      # @param [Numeric] delta
      #   The the acceptable range by which the actual value can deviate.
      #
      def initialize(expected, delta, *extra_args)
        raise ArgumentError,
          'The CloseTo matcher requires that the +expected+ value ' \
          'responds to +-+' unless expected.respond_to?(:-)

        raise ArgumentError,
          'The CloseTo matcher requires that a Numeric +delta+ value ' \
          'is supplied' unless delta.kind_of?(Numeric)

        super(expected, *extra_args)

        @delta = delta
      end

      # Returns whether the given value is close to the expected value.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        (actual - @expected).abs <= @delta
      end

    end # CloseTo
  end # Matchers
end # Luggage
