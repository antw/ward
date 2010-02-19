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

    # Creates a new Validator.
    #
    # @param [Luggage::ContextChain, Luggage::Context] context
    #   The context to be used to fetch the value for the matcher.
    # @param [Luggage::Matchers::Matcher] matcher
    #   A matcher to be used to validate the context value.
    #
    def initialize(context, matcher, scenarios = [])
      @context, @matcher, @scenarios = context, matcher, scenarios
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
      result, error = @matcher.matches?(@context.value(record))
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
