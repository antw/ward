module Luggage
  module Matchers
    # Tests whether the actual value is a collection with the expected number
    # of members, or contains a collection with the expected number of
    # members.
    #
    # @example Setting the exact size for a collection
    #
    #   class Author
    #     # All mean the same thing.
    #     validate.has(5).posts
    #     validate.has.exactly(5).posts
    #   end
    #
    # @example Setting the minimum size for a collection
    #
    #   class Author
    #     # All mean the same thing.
    #     validate.has.at_least(5).posts
    #     validate.has.gte(5).posts
    #
    #     validate.has.greater_than(4).posts
    #     validate.has.more_than(4).posts
    #     validate.has.gt(4).posts
    #   end
    #
    # @example Setting the maximum size for a collection
    #
    #   class Author
    #     # All mean the same thing.
    #     validate.has.at_most(5).posts
    #     validate.has.lte(5).posts
    #
    #     validate.has.less_than(6).posts
    #     validate.has.fewer_than(6).posts
    #     validate.has.lt(6).posts
    #   end
    #
    # @example Setting a range of acceptable sizes for a collection
    #
    #   class Author
    #     # All mean the same thing.
    #     validate.has.between(1..5).posts
    #     validate.has.between(1, 5).posts
    #   end
    #
    class Has < Matcher

      # The name of the collection whose size is being checked.
      #
      # @return [Symbol, nil]
      #   nil indicates that no collection name has been set, and the matcher
      #   will attempt to call +size+ or +length+ on the collection owner.
      #
      attr_reader :collection_name

      # Returns how to test the length of the collection.
      #
      # @return [Symbol]
      #
      attr_reader :relativity

      # Creates a new matcher instance.
      #
      # @param [Object] expected
      #   The expected value for the matcher.
      #
      def initialize(*args)
        super
      end

      # Returns whether the given value is satisfied by the expected block.
      #
      # @param [Object] collection
      #   The collection or the collection owner.
      #
      # @return [Boolean]
      #
      def matches?(collection)
        unless @collection_name.nil? or
            not collection.respond_to?(@collection_name)
          collection = collection.__send__(@collection_name)
        end

        if collection.respond_to?(:size)
          actual = collection.size
        elsif collection.respond_to?(:length)
          actual = collection.length
        else
          raise RuntimeError,
            'The given value is not a collection (it does not respond to ' \
            '#length or #size)'
        end

        case @relativity
          when :eql, nil then actual == @expected
          when :lte      then actual <= @expected
          when :gte      then actual >= @expected
          when :between  then @expected.include?(actual)
          else                false
        end
      end

      # Sets that the collection should be smaller than the expected value.
      #
      # @param [Numeric] n
      #   The maximum size of the collection + 1.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def lt(n)
        set_relativity(:lte, n - 1)
      end

      alias_method :fewer_than, :lt
      alias_method :less_than,  :lt

      # Sets that the collection should be no larger than the expected value.
      #
      # @param [Numeric] n
      #   The maximum size of the collection.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def lte(n)
        set_relativity(:lte, n)
      end

      alias_method :at_most, :lte

      # Sets that the collection should be the exact size of the expectation.
      #
      # @param [Numeric] n
      #   The exact expected size of the collection.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def eql(n)
        set_relativity(:eql, n)
      end

      alias_method :exactly, :eql

      # Sets that the collection should be no smaller than the expected value.
      #
      # @param [Numeric] n
      #   The minimum size of the collection.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def gte(n)
        set_relativity(:gte, n)
      end

      alias_method :at_least, :gte

      # Sets that the collection should be greater than the expected value.
      #
      # @param [Numeric] n
      #   The minimum size of the collection - 1.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def gt(n)
        set_relativity(:gte, n + 1)
      end

      alias_method :greater_than, :gt
      alias_method :more_than,    :gt

      # Sets that the collection size should be between two values.
      #
      # @param [Range, Numeric] n
      #   The lowest boundary for the collection size. Alternatively, a range
      #   specifying the acceptable size of the collection.
      # @param [Numeric] upper
      #   The lowest boundary for the collection size. Omit if a range is
      #   supplied as the first argument.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      def between(n, upper = nil)
        if n.kind_of?(Range)
          set_relativity(:between, n)
        elsif upper.nil?
          raise ArgumentError,
            'You must supply an upper boundary for the collection size'
        else
          set_relativity(:between, (n..upper))
        end
      end

      private

      # Sets the collection name to be used by the matcher.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      # @todo
      #   Capture args and block to be used when fetching the collection.
      #
      def method_missing(method, *args, &block)
        @collection_name = method.to_sym
        self
      end

      # Sets the relativity and the expected value.
      #
      # @param [Symbol] relativity
      #   The relativity to set.
      # @param [Numeric] expected
      #   The expected value to set.
      #
      # @return [Luggage::Matchers::Has]
      #   Returns self.
      #
      # @raise
      #
      def set_relativity(relativity, expected)
        raise RuntimeError,
          "A relativity (#{@relativity}) was already set; you cannot " \
          "set another" unless @relativity.nil?

        @relativity, @expected = relativity, expected
        self
      end

    end # Has
  end # Matchers
end # Luggage
