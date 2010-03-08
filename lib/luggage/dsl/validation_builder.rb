module Luggage
  module DSL
    # Creates a single {Validator}. Any message received which doesn't
    # correspond with a matcher will be assumed to be part of the context.
    #
    # @example
    #
    #   # Builds a validation whose context is "author.name" and uses the
    #   # EqualTo matcher to ensure that the "author.name" is "Michel Scarn".
    #
    #   ValidationBuilder.new.author.name.is.equal_to('Michael Scarn')
    #
    class ValidationBuilder < Support::BasicObject

      # Creates a new ValidationBuilder instance.
      #
      def initialize
        @context = Luggage::ContextChain.new
        @matcher, @message, @scenarios, @negative = nil, nil, nil, false
      end

      # Sets the error message to be used if the validation fails.
      #
      # This can be one of three possibilities:
      #
      #   * A Hash. If the matcher used returns a different error state in
      #     order to provide more details about what failed (such as the Has
      #     matcher), you may provide a hash with custom error messages for
      #     each error state.
      #
      #   * A String which will be used whenever the validation fails,
      #     regardless of what went wrong.
      #
      #   * nil (default). The validation will use the default error message
      #     for the matcher.
      #
      # @param [Hash{Symbol => String}, String, nil] message
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      # @example Setting an explicit error message.
      #
      #   validate do |person|
      #     person.name.is.present.message('You must enter a name!')
      #   end
      #
      # @example Setting an explicit error message with a Hash.
      #
      #   validate do |person|
      #     person.name.length.is(1..50).message(
      #       :too_short => "Your name must be at least 1 character long",
      #       :too_long  => "That's an interesting name!"
      #     )
      #   end
      #
      def message(message)
        @message = message
        self
      end

      # Sets the scenarios under which the built validator should run.
      #
      # @param [Symbol, ...] scenarios
      #   The scenarios as Symbols.
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def scenarios(*scenarios)
        @scenarios = scenarios.flatten
        self
      end

      alias_method :scenario, :scenarios

      # Set this as a positive expectation. Can be omitted.
      #
      # @example
      #   object.name.is.blank
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def is(*args)
        equal_to(*args) unless args.empty?
        self
      end

      # Set this as a negative expectation.
      #
      # @example
      #   object.name.is_not.blank
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def is_not(*args)
        @negative = true
        is(*args)
      end

      alias_method :does_not, :is_not

      # Provides the DSL.
      #
      # Will take the given message and use it to customise the matcher (if
      # one is set), set a matcher, or extend the context.
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def method_missing(method, *args, &block)
        # I'd normally shy away from using method_missing, but there's no
        # good alternative here since a user may register their own matchers
        # later in the load process.

        if @matcher
          @matcher.__send__(method, *args, &block)
        elsif Luggage::Matchers.matchers.has_key?(method)
          @matcher = Luggage::Matchers.matchers[method].new(*args, &block)
        else
          @context << Luggage::Context.new(method)
        end

        self
      end

      # Converts the builder to a Validator instance.
      #
      # @return [Luggage::Validator]
      #
      # @raise [IncompleteValidation]
      #   An IncompleteValidationError will be raised if builder does not have
      #   all of the needed information in order to create the necessary
      #   validation (for example, if no matcher has been set).
      #
      # @todo
      #   More descriptive error messages.
      #
      def to_validator
        raise Luggage::IncompleteValidator,
          'Validator was missing a matcher' if @matcher.nil?

        Luggage::Validator.new(@context, @matcher, :message => @message,
          :scenarios => @scenarios, :negative => @negative)
      end

    end # Validate
  end # DSL
end # Luggage
