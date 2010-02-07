module Luggage
  # A class which represents "somewhere" from which a value can be retrieved
  # for validation.
  #
  # A context initialized with a +:length+ attribute assumes, by default, that
  # the value for validation can be retrieved by calling +length+ on the
  # target object.
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
    # @param [Block] fetcher
    #   An optional block to be used to fetch the context value from a target
    #   object. If no block is given, it is assumed that the target has a
    #   method name matching the attribute.
    #
    def initialize(attribute, &fetcher)
      @attribute = attribute.to_sym
      @fetcher = fetcher || lambda { |object| object.__send__(@attribute) }
      @natural_name = ActiveSupport::Inflector.humanize(@attribute.to_s)
    end

    # Returns the value of the context for the given target object.
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
    #   The object which holds the value to be retrieved
    #
    # @return [Object]
    #
    def value(target)
      @fetcher.call(target)
    end

  end # Context
end # Luggage
