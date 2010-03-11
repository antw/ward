module Luggage
  # ContextChain combines one or more contexts in order to be able to retrieve
  # values from composed objects.
  #
  # For example, if the chain contains two contexts, the first with a +length+
  # attribute, and the second with a +to_s+ attribute, the chain would resolve
  # to calling +target.length.to_s+ in order to retrieve a value for
  # validation.
  #
  class ContextChain

    # Creates a new ContextChain instance.
    #
    def initialize
      @contexts = []
    end

    # Returns the name of the attribute to be validated.
    #
    # Returns the attribute for the first context.
    #
    # @return [Symbol]
    #
    def attribute
      @contexts.empty? ? :base : @contexts.first.attribute
    end

    # Returns the 'natural name' of the contained contexts.
    #
    # @return [String]
    #
    def natural_name
      @contexts.map { |context| context.natural_name }.join(' ')
    end

    # Retrieves the value for the given +target+.
    #
    # @param [Object] target
    #   The object which holds the value to be retrieved
    #
    # @return [Object]
    #
    def value(target)
      if @contexts.size > 1
        resolved = @contexts[0..-2].inject(target) do |intermediate, context|
          context.value(intermediate) unless intermediate.nil?
        end

        raise ArgumentError,
          "Couldn't retrieve a value for #{natural_name.downcase}; " \
          "something along the way evaluated to nil" if resolved.nil?

        @contexts.last.value(resolved)
      elsif @contexts.size == 1
        @contexts.first.value(target)
      else
        target
      end
    end

    # Returns the contexts contained in the chain as an Array.
    #
    # @return [Array<Luggage::Context>]
    #   An array containing the contexts.
    #
    def to_a
      @contexts.dup
    end

    # Adds a new context to the end of the chain.
    #
    # @param [Luggage::Context] context
    #   The context to be added to the chain.
    #
    def push(context)
      @contexts << context
    end

    alias_method :<<, :push

  end # ContextChain
end # Luggage
