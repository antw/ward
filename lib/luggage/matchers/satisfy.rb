module Luggage
  module Matchers
    # Tests whether the validation value satisfies the given block.
    #
    # If the block returns any value other than false, the matcher will assume
    # that the match passed.
    #
    # Alternatively, you may pass a Symbol which identifies a method name; the
    # method will be run with it's return value used to determine if the
    # matcher passed.
    #
    # @example Matching with a block
    #   class Record
    #     validate do |record|
    #       record.name.satisfies do |value, record|
    #         value == 'Michael Scarn'
    #       end
    #     end
    #   end
    #
    # @example Matching with a Symbol and method
    #
    #   class Record
    #     validate do |record|
    #       record.name.satisfies(:require_michael_scarn)
    #     end
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
        block ||= lambda { |value| not value.__send__(expected) == false }
        super(block, *extra_args)
      end

      # Returns whether the given value is satisfied by the expected block.
      #
      # @param [Object] actual
      #   The validation value.
      # @param [Object] record
      #   The full record.
      #
      # @return [Boolean]
      #
      def matches?(actual, record = nil)
        if @expected.arity != 1
          not @expected.call(actual, record) == false
        else
          not @expected.call(actual) == false
        end
      end

    end # Satisfy
  end # Matchers
end # Luggage
