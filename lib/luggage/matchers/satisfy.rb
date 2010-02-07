module Luggage
  module Matchers
    # Tests whether the validation value satisfies the given block.
    #
    # If the block returns any value other than false, the matcher will assume
    # that the match passed.
    #
    # Alternatively, you may pass a Symbol which identified a method name; the
    # method will be run with it's return value used to determine if the match
    # passed.
    #
    # @example Matching with a block
    #   class Record
    #     validate(:name).satisfies do |value, record|
    #       value == 'Michael Scarn'
    #     end
    #   end
    # 
    # @example Matching with a Symbol and method
    # 
    #   class Record
    #     validate(:name).satisfies(:require_michael_scarn)
    # 
    #     def require_michael_scarn
    #       name == 'Michael Scarn'
    #     end
    #   end
    #
    class Satisfy < Matcher

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil, *extra_args, &block)
        super(block_given? ? block : expected, *extra_args)
      end

      # Returns whether the given value is satisfied by the expected block.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        not @expected.call(actual, nil) == false
      end

    end # Satisfy
  end # Matchers
end # Luggage
