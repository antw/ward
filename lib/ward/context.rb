module Ward
  # A class which represents "somewhere" from which a value can be retrieved
  # for validation.
  #
  # A context initialized with a +:length+ attribute assumes that the value
  # for validation can be retrieved by calling +length+ on the target object.
  #
  class Context

    # Returns the name of the attribute to be validated.
    #
    # @return [Symbol]
    #
    attr_reader :attribute

    # Returns the 'natural name' of the attribute.
    #
    # This name is used when generating error messages, since you probably
    # don't want you end users to be presented with (occasionally) obscure
    # attribute names.
    #
    # @example
    #   :name     # => Name
    #   :a_field  # => A field
    #   :post_id  # => Post
    #
    # @return [String]
    #
    attr_reader :natural_name

    # Creates a new validator instance.
    #
    # @param [#to_sym] attribute
    #   The name of the attribute to be validated.
    # @param [*] *context_args
    #   Arguments to be used when calling the context.
    # @param [Block] context_block
    #   A block to be used when calling the context.
    #
    def initialize(attribute, *context_args, &context_block)
      @attribute = attribute.to_sym
      @context_args, @context_block = context_args, context_block

      @natural_name =
        ActiveSupport::Inflector.humanize(@attribute.to_s).downcase
    end

    # Returns the value of the context for the given +target+ object.
    #
    # @example
    #
    #   Context.new(:length).value('abc')
    #   # => 3
    #
    #   Context.new(:length_as_string) do |target|
    #     target.length.to_s
    #   end.value('abc')
    #   # => '3'
    #
    # @param [Object] target
    #   The object from which the value is to be retrieved.
    #
    # @return [Object]
    #
    def value(target)
      target.__send__(@attribute, *@context_args, &@context_block)
    end

  end # Context
end # Ward
