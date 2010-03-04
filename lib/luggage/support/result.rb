module Luggage
  module Support
    # Used when validating objects which don't include the Validation
    # module. Contains the results of running a ValidatorSet against a record,
    # and any errors which occurred.
    #
    #
    class Result

      # Returns the errors which were found when validating.
      #
      # An Errors instance will always be returned, even if there were no
      # errors with the record.
      #
      # @return [Luggage:Errors]
      #
      attr_reader :errors

      # Creates a new Result instance.
      #
      # @param [Luggage::Errors] errors
      #   The errors which were found by the validations.
      #
      def initialize(errors)
        @errors = errors
        @result = errors.empty?
      end

      # Returns true if the validations passed.
      #
      # @return [Boolean]
      #
      def pass?
        @result
      end

      alias_method :valid?, :pass?

      # Returns true if the validations failed.
      #
      # @return [Boolean]
      #
      def fail?
        not pass?
      end

    end # Result
  end # Support
end # Luggage