module Luggage
  # Holds errors associated with a valid? call.
  #
  class Errors

    include Enumerable

    # Creates a new Errors instance
    #
    def initialize
      @errors = {}
    end

    # Adds an error message to the instance.
    #
    # @param [Symbol, Luggage::Context, Luggage::ContextChain] attribute
    #   The attribute or context for the error.
    # @param [String] message
    #   The error message to add.
    #
    # @return [String]
    #   Returns the error message which was set.
    #
    # @todo
    #   Support symbols for i18n.
    #
    def add(attribute, message)
      if attribute.kind_of?(Context) or attribute.kind_of?(ContextChain)
        attribute = attribute.attribute
      end

      @errors[attribute] ||= []
      @errors[attribute] << message
      message
    end

    # Returns an array of the errors present on an an attribute.
    #
    # @param [Symbol] attribute
    #   The attribute whose errors you wish to retrieve.
    #
    # @return [Array]
    #   Returns the error messages for an attribute, or nil if there are none.
    #
    def on(attribute)
      @errors[attribute]
    end

    # Iterates through each attribute and the errors.
    #
    # @yieldparam [Symbol] attribute
    #   The attribute name.
    # @yieldparam [Array, nil] messages
    #   An array with each error message for the attribute, or nil if the
    #   attribute has no errors.
    #
    def each(&block)
      @errors.each(&block)
    end

  end # Errors
end # Luggage
