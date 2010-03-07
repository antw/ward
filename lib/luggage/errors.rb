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

      # Receives an array and formats it nicely, assuming that only one value
      # is expected.
      #
      # @example One member
      #   format_exclusive_list([1]) # => '1'
      #
      # @example Two members
      #   format_exclusive_list([1, 2]) # => '1 or 2'
      #
      # @example Many members
      #   format_exclusive_list([1, 2, 3]) # => '1, 2, or 3'
      #
      # @param [Enumerable] list
      #   The list to be formatted.
      #
      # @return [String]
      #
      def format_exclusive_list(list)
        format_list(list, messages['generic']['exclusive_conjunction'])
      end

      # Receives an array and formats it nicely, assuming that all values are
      # expected.
      #
      # @example One member
      #   format_inclusive_list([1]) # => '1'
      #
      # @example Two members
      #   format_inclusive_list([1, 2]) # => '1 and 2'
      #
      # @example Many members
      #   format_inclusive_list([1, 2, 3]) # => '1, 2, and 3'
      #
      # @param [Enumerable] list
      #   The list to be formatted.
      #
      # @return [String]
      #
      def format_inclusive_list(list)
        format_list(list, messages['generic']['inclusive_conjunction'])
      end

      private

      # Formats a list.
      #
      # @see Luggage::Errors.format_exclusive_list
      # @see Luggage::Errors.format_inclusive_list
      #
      def format_list(list, conjunction)
        case list.size
          when 0 then ''
          when 1 then list.first.to_s
          when 2 then "#{list.first.to_s} #{conjunction} #{list.last.to_s}"
          else
            as_strings = list.map { |value| value.to_s }
            as_strings[-1] = "#{conjunction} #{as_strings[-1]}"
            as_strings.join("#{messages['generic']['list_seperator']} ")
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
