module Ward
  # Holds errors associated with a valid? call.
  #
  class Errors

    include Enumerable

    class << self

      # Returns a localisation message.
      #
      # @param [keys] String
      #   The key of the message to be returned from the current language
      #   file.
      #
      # @return [String, nil]
      #   Returns the message or nil if it couldn't be found.
      #
      # @example
      #
      #   Ward::Errors.message('has.eql.positive')
      #   # => '%{context} should have %{expected} %{collection}'
      #
      # @example Passing multiple keys as fallbacks.
      #
      #   Ward::Errors.message(
      #     'does.not.exist', 'has.eql.negative', 'has.eql.positive')
      #
      #   # => '%{context} should not have %{expected} %{collection}'
      #
      def message(*keys)
        messages[ keys.detect { |key| messages.has_key?(key) } ]
      end

      # Returns the unformatted error message for a matcher.
      #
      # @param [Ward::Matchers::Matcher] matcher
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
        language_key = "#{matcher.class.error_id}."
        language_key << "#{key}." unless key.nil?
        language_key << (negative ? 'negative' : 'positive')

        message(language_key) || '%{context} is invalid'
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
        format_list(list, message('generic.exclusive_conjunction'))
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
        format_list(list, message('generic.inclusive_conjunction'))
      end

      private

      # Formats a list.
      #
      # @see Ward::Errors.format_exclusive_list
      # @see Ward::Errors.format_inclusive_list
      #
      def format_list(list, conjunction)
        case list.size
          when 0 then ''
          when 1 then list.first.to_s
          when 2 then "#{list.first} #{conjunction} #{list.last}"
          else
            as_strings = list.map { |value| value.to_s }
            as_strings[-1] = "#{conjunction} #{as_strings[-1]}"
            as_strings.join("#{message('generic.list_seperator')} ")
        end
      end

      # Returns the en-US error message hash. TEMPORARY.
      #
      # @return [Hash]
      #
      def messages
        @error_messages ||= normalise_messages(YAML.load(
          File.read(File.expand_path('../../../lang/en.yml', __FILE__)) ))
      end

      # Transforms a hash of messages to a single hash using dot notation.
      #
      def normalise_messages(messages, transformed = {}, key_prefix = '')
        messages.each do |key, value|
          item_key = key_prefix.empty? ? key : "#{key_prefix}.#{key}"

          if value.is_a?(Hash)
            normalise_messages(value, transformed, item_key)
          else
            transformed[item_key] = value
          end
        end

        transformed
      end

    end # class << self

    # Creates a new Errors instance.
    #
    def initialize
      @errors = {}
    end

    # Adds an error message to the instance.
    #
    # @param [Symbol, Ward::Context, Ward::ContextChain] attribute
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
end # Ward
