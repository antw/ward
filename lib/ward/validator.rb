module Ward
  # Pairs a context (or chain) with a matcher.
  #
  class Validator

    # Returns the context.
    #
    # @return [Ward::ContextChain, Ward::Context]
    #
    attr_reader :context

    # Returns the matcher.
    #
    # @return [Ward::Matchers::Matcher]
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
    # @param [Ward::ContextChain, Ward::Context] context
    #   The context to be used to fetch the value for the matcher.
    # @param [Ward::Matchers::Matcher] matcher
    #   A matcher to be used to validate the context value.
    # @param [Hash] options
    #   Extra options used to customise the Validator.
    #
    # @option options [Symbol, Array<Symbol>] :scenarios
    #   An array of scenarios in which this validator should be run
    # @option options [Hash{Symbol => String}, String] :message
    #   The error message to be used if the validator fails (see
    #   DSL::ValidationBuilder#message).
    # @option options [String] :context_name
    #   The name to be used for the context when generating error messages.
    #
    def initialize(context, matcher, options = {})
      @context, @matcher = context, matcher
      @scenarios = Array(options[:scenarios] || :default).freeze
      @negative = options[:negative] || false
      @message  = options[:message].freeze
      @context_name = options[:context_name].freeze
    end

    # Determines if the validator is valid for the given record.
    #
    # The return value deviates from the ValidatorSet API -- where #valid?
    # returns only a boolean value -- but that's fine since you shouldn't be
    # calling Validator#valid? in your applications anyway. :)
    #
    # @param [Object] record
    #   The object whose attribute is to be validated.
    #
    # @return [Array<Boolean, {nil, String, Symbol}>]
    #   Returns an array with two elements. The first is always either true or
    #   false, indicating whether the validator passed, and the second is the
    #   raw error message returned by the matcher.
    #
    def validate(record)
      # If the matches? method on the matcher takes two arguments, send in the
      # record as well as the value.
      result = if @matcher.method(:matches?).arity != 1
        @matcher.matches?(@context.value(record), record)
      else
        @matcher.matches?(@context.value(record))
      end

      result, error = if defined?(Rubinius)
        # Rubinius treats any value which responds to #to_a as being
        # array-like, thus multiple assignment breaks if the matcher returns
        # such an object.
        result.is_a?(Array) ? result : [result].flatten
      else
        result
      end

      (!! result) ^ negative? ? [ true, nil ] : [ false, error_for(error) ]
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

    # Returns if the validator expects that the matcher _not_ match.
    #
    # Use with the +is_not+ and +does_not+ DSL keyword.
    #
    # @return [Boolean]
    #
    def negative?
      @negative
    end

    private

    # Returns the error message when the matcher fails.
    #
    # If the validator has a message defined, it will always be used in
    # preference over any error returned by the matcher, or defiend in the
    # language files.
    #
    # @param  [nil, Symbol, String] key
    # @return [String]
    #
    # @see Ward::Errors.error_for
    # @see Ward::Matchers::Matcher#format_error
    #
    def error_for(key)
      initial = @message || Ward::Errors.error_for(matcher, negative?, key)

      error = initial % matcher.customise_error_values(
        :expected => matcher.expected,
        :context  => @context_name || context.natural_name)

      error.strip!
      error[0] = error[0].chr.upcase

      error
    end

  end
end # Ward
