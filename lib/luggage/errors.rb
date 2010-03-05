module Luggage
  # Holds errors associated with a valid? call.
  #
  class Errors

    include Enumerable

    class << self

      # Returns the en-US error message hash. TEMPORARY.
      #
      # @return [Hash]
      #
      def messages
        @error_messages ||= YAML.load(
          File.read(File.expand_path('../../../lang/en-US.yml', __FILE__)))
      end

      # Returns the unformatted error message for a matcher.
      #
      # @param [Luggage::Matchers::Matcher] matcher
      #   The matcher.
      # @param [Boolean] negative
      #   Whether to return a negative message, rather than a positive.
      # @param [nil, Symbol, String] key
      #   If a string is supplied, +error_for+ will assume that the string
      #   should be used as the error. A symbol will be assumed to be a 'key'
      #   from the language file, while nil will result in the validator using
      #   the default error message for the matcher.
      #
      # @return [String]
      #
      def error_for(matcher, negative, key = nil)
        return key if key.is_a?(String)

        matcher_messages = messages[matcher.class.error_id]
        matcher_messages = matcher_messages[key.to_s] unless key.nil?

        if matcher_messages.nil?
          '%{context} is invalid' # Uh-oh.
        else
          matcher_messages[ negative ? 'negative' : 'positive' ]
        end
      end

    end # class << self

    # Creates a new Errors instance.
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

    # Returns if there are no errors contained.
    #
    # @return [Boolean]
    #
    def empty?
      @errors.empty?
    end

  end # Errors
end # Luggage
