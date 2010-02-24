module Luggage
  # Pairs a context (or chain) with a matcher.
  #
  class Validator

    # Returns the context.
    #
    # @return [Luggage::ContextChain, Luggage::Context]
    #
    attr_reader :context

    # Returns the matcher.
    #
    # @return [Luggage::Matchers::Matcher]
    #
    attr_reader :matcher

    # The scenarios under which the validator will be run.
    #
    # @return [Enumerable<Symbol>]
    #
    attr_reader :scenarios

    # An override to the default message.
    #
    # If set, this message will always be used if the validation fails,
    # regardless of whether it is used as a positive or negative assertion.
    #
    # @return [Hash, String, nil]
    #   Returns a Hash if the user wishes to use a different message depending
    #   on the error state of the matcher (certain matchers, like Has, return
    #   a different error depending on what went wrong), a String if an
    #   explicit error message is set, or nil if no error message is set (in
    #   which case the default error for the matcher will be used).
    #
    attr_reader :message

    # Creates a new Validator.
    #
    # @param [Luggage::ContextChain, Luggage::Context] context
    #   The context to be used to fetch the value for the matcher.
    # @param [Luggage::Matchers::Matcher] matcher
    #   A matcher to be used to validate the context value.
    # @param [Hash] options
    #   Extra options used to customise the Validator.
    #
    # @option options [Symbol, Array<Symbol>] :scenarios
    #   An array of scenarios in which this validator should be run
    # @option options [Hash{Symbol => String}, String] :message
    #   The error message to be used if the validator fails (see
    #   DSL::ValidationBuilder#message).
    #
    def initialize(context, matcher, options = {})
      @context, @matcher = context, matcher
      @scenarios = Array(options[:scenarios] || :default)
      @message = options[:message]
    end

    # Determines if the validator is valid for the given record.
    #
    # @param [Object] record
    #   The object whose attribute is to be validated.
    #
    # @return [Boolean, Array]
    #   Returns true if the attribute validated; otherwise returns an array
    #   whose first element is false, and second element is an error message.
    #
    def valid?(record)
      # If the matches? method on the matcher takes two arguments, send in the
      # record as well as the value.
      result, error = if @matcher.method(:matches?).arity != 1
        @matcher.matches?(@context.value(record), record)
      else
        @matcher.matches?(@context.value(record))
      end

      result
    end

    # Returns if the validator should be run as part of the given scenario.
    #
    # @param [Symbol] scenario
    #   A name identifying the scenario.
    #
    # @return [Boolean]
    #
    def scenario?(scenario)
      @scenarios.include?(scenario)
    end

  end
end # Luggage
