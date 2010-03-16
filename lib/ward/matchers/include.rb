module Ward
  module Matchers
    # Tests whether the validation value is contained in the expected value.
    #
    # The expected value can be anything which responds to +include?+; if it
    # returns true, the matcher will pass.
    #
    # @example Person role is either :admin or :staff
    #
    #   class Person
    #     validate do |person|
    #       person.role.is.in([:admin, :staff])
    #     end
    #   end
    #
    class Include < Matcher

      # Creates a new Include matcher instance.
      #
      # @param [#include?] expected
      #   The expected value for the matcher.
      #
      def initialize(expected = nil)
        raise ArgumentError,
          'The Include matcher requires that a value which responds ' \
          'to #include? is supplied' unless expected.respond_to?(:include?)

        super
      end

      # Returns whether the given value is included in the expected value.
      #
      # @param [#include?] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        @expected.include?(actual)
      end

      # Adds extra information to the error message.
      #
      # @param  [String] error
      # @return [String]
      #
      def customise_error_values(values)
        values[:expected] = Ward::Errors.format_exclusive_list(@expected)
        values
      end

    end # Include
  end # Matchers
end # Ward
