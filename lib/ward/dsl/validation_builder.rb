module Ward
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
        @context = Ward::ContextChain.new
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
      # @return [Ward::DSL::ValidatorBuilder]
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

      # Sets the name to be used for the context in error messages.
      #
      # When Ward generates error messages for you, it determines the
      # 'context name' by joining the method names; for example 'name.length'
      # becomes 'name length'.
      #
      # This isn't much use if you want to support languages other than
      # English in your application, so the 'context' method allows you to set
      # a custom string to be used. You may provide a String, in which case it
      # will be used literally, a Hash of +language => String+, or a Symbol
      # identifying a string to be used from a language file.
      #
      # See the localisation documentation for more examples.
      #
      def context(name)
        @context_name = name
        self
      end

      # Sets the scenarios under which the built validator should run.
      #
      # @param [Symbol, ...] scenarios
      #   The scenarios as Symbols.
      #
      # @return [Ward::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def scenarios(*scenarios)
        @scenarios = scenarios.flatten
        self
      end

      alias_method :scenario, :scenarios

      # Adds an attribute to the context chain.
      #
      # Useful your classes have attribute which you want to validate, and
      # their name conflicts with a method on the validator DSL (e.g.
      # "message").
      #
      # @param [Symbol] attribute
      #   The attribute to be validated.
      #
      # @return [Ward::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def attribute(attribute, *args, &block)
        @context << Ward::Context.new(attribute, *args, &block)
        self
      end

      # Set this as a positive expectation. Can be omitted.
      #
      # @example
      #   object.name.is.blank
      #
      # @return [Ward::DSL::ValidatorBuilder]
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
      # @return [Ward::DSL::ValidatorBuilder]
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
      # @return [Ward::DSL::ValidatorBuilder]
      #   Returns self.
      #
      def method_missing(method, *args, &block)
        # I'd normally shy away from using method_missing, but there's no
        # good alternative here since a user may register their own matchers
        # later in the load process.

        if @matcher
          @matcher.__send__(method, *args, &block)
        elsif Ward::Matchers.matchers.has_key?(method)
          @matcher = Ward::Matchers.matchers[method].new(*args, &block)
        elsif method.to_s =~ /\?$/
          @matcher = Ward::Matchers::Predicate.new(method, *args, &block)
        else
          attribute(method, *args, &block)
        end

        self
      end

      # Converts the builder to a Validator instance.
      #
      # @return [Ward::Validator]
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
        raise Ward::IncompleteValidator,
          'Validator was missing a matcher' if @matcher.nil?

        Ward::Validator.new(@context, @matcher, :message => @message,
          :scenarios => @scenarios, :negative => @negative,
          :context_name => @context_name)
      end

    end # Validate
  end # DSL
end # Ward
