module Luggage
  module DSL
    # Creates a single validator. Any message received which doesn't
    # correspond with a matcher will be assumed to be part of the context.
    #
    # @example
    #
    #   # Builds a validation whose context is "author.name" and uses the
    #   # EqualTo matcher to ensure that the "author.name" is "Michel Scarn".
    #
    #   ValidationBuilder.new.author.name.is.equal_to('Michael Scarn')
    #
    class ValidationBuilder

      # Emulate a BlankSlate on Ruby 1.8.
      instance_methods.each do |method|
        unless method.to_s =~ /^(?:__|instance_eval|object_id|should)/
          undef_method(method)
        end
      end

      # Creates a new ValidationBuilder instance.
      #
      def initialize
        @context = Luggage::ContextChain.new
        @matcher = nil
        @message = nil
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

      # Provides the DSL.
      #
      # Will take the given message and use it to customise the matcher (if
      # one is set), set a matcher, or extend the context.
      #
      # @return [Luggage::DSL::ValidatorBuilder]
      #   Returns self.
      #
      # --
      # Normally I hate method_missing, but there's no alternative here since
      # a user may register their own matchers later in the load process.
      #
      def method_missing(method, *extra_args, &block)
        if @matcher
          @matcher.__send__(method, *extra_args, &block)
        elsif Luggage::Matchers.matchers.has_key?(method)
          @matcher = Luggage::Matchers.matchers[method].new(*extra_args)
        else
          @context << Luggage::Context.new(method)
        end

        self
      end

      # Converts the builder to a Luggage::Validator instance.
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

        Luggage::Validator.new(@context, @matcher, :message => @message)
      end

    end # Validate
  end # DSL
end # Luggage
