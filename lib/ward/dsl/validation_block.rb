module Ward
  module DSL
    # Creates one or more validators using a block.
    #
    # @see Ward::ValidatorSet.build
    #
    # @example
    #
    #   # Builds a validation set with two validators
    #   #
    #   #   * One for "author.name" and the EqualTo matcher.
    #   #   * One for "title" with the Match matcher.
    #
    #   ValidationBlock.new do |object|
    #     object.author.name.is.equal_to('Michael Scarn')
    #     object.title.match(/something/)
    #   end
    #
    class ValidationBlock < Support::BasicObject

      # Creates a new ValidationBlock instance.
      #
      # NOTE: Providing an existing ValidatorSet will result in a copy of that
      # set being mutated; the original will not be changed.
      #
      # @param [Ward::ValidatorSet] set
      #   A ValidatorSet to which the built validators should be added.
      #
      def initialize(set = nil, &block)
        @set = if set.nil? then Ward::ValidatorSet.new else set.dup end
        run(&block) if block
      end

      # Returns the ValidatorSet created by the DSL.
      #
      # @return [Ward::ValidatorSet]
      #
      def to_validator_set
        @set
      end

      private

      # Runs a block, creating the appropriate validators.
      #
      # @todo Ensure that each matcher was correctly set up.
      #
      def run
        @builders = []
        yield self
        @set.merge!(@builders.map { |builder| builder.to_validator })
        @builders = nil
      end

      # Provides the DSL.
      #
      # Will take the given message and creates a new ValidationBuilder.
      #
      # @return [Ward::DSL::ValidationBuilder]
      #   Returns the created builder.
      #
      def method_missing(method, *extra_args, &block)
        raise 'ValidationBlock can only be used when provided ' \
          'with a block' if @builders.nil?

        builder = ValidationBuilder.new.__send__(method, *extra_args, &block)
        @builders.push(builder)
        builder
      end

    end # ValidationBlock
  end # DSL
end # Ward
