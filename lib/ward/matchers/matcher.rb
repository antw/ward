module Ward
  module Matchers
    # A base class used for creating custom matchers.
    #
    # @abstract
    #
    class Matcher

      # Returns the expected value.
      #
      # @return [Object]
      #
      attr_reader :expected

      # Returns any extra arguments given to the matcher.
      #
      # @return [Array]
      #
      attr_reader :extra_args

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil, *extra_args)
        @expected   = expected
        @extra_args = extra_args
      end

      # Returns whether the given value matches the expected value.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      # @abstract
      #
      def matches?(actual)
        actual
      end

      # Allows matcher subclasses to change -- or add values to -- the hash
      # whose values are interpolated with the error string.
      #
      # @param [Hash]
      #   The standard values which are interpolated with the error string;
      #   contains :context and :expected keys.
      #
      # @return [Hash{Symbol => String}]
      #
      def customise_error_values(values)
        values
      end

      # Determines the key to be used to find error messages in lang files.
      #
      # @return [String]
      #
      def self.error_id
        @error_id ||= ActiveSupport::Inflector.underscore(
          ActiveSupport::Inflector.demodulize(to_s))
      end

    end # Matcher
  end # Matchers
end # Ward
