module Luggage
  module DSL
    # Creates one or more validators using a block.
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
    class ValidationBlock

      # Builds a ValidatorSet using the given block.
      #
      # NOTE: Providing an existing ValidatorSet will result in a copy of that
      # set being mutated; the original will not be changed.
      #
      # @param [Luggage::ValidatorSet] set
      #   A ValidatorSet to which the built validators should be added.
      #
      # @return [Luggage::ValidatorSet]
      #
      def self.build(set = nil, &block)
        new(set, &block).to_validator_set
      end

      # Emulate a BlankSlate on Ruby 1.8.
      instance_methods.each do |method|
        unless method.to_s =~ /^(?:__|instance_eval|object_id|should)/
          undef_method(method)
        end
      end

      # Creates a new ValidationBlock instance.
      #
      # NOTE: Providing an existing ValidatorSet will result in a copy of that
      # set being mutated; the original will not be changed.
      #
      # @param [Luggage::ValidatorSet] set
      #   A ValidatorSet to which the built validators should be added.
      #
      def initialize(set = nil, &block)
        @set = if set.nil? then Luggage::ValidatorSet.new else set.dup end
        run(&block) if block
      end

      # Returns the ValidatorSet created by the DSL.
      #
      # @return [Luggage::ValidatorSet]
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
      # @return [Luggage::DSL::ValidatorBuilder]
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
end # Luggage
