module Luggage
  # Holds one or more Validators which are associated with a particular class.
  #
  # This class is considered part of Luggage's semi-public API; which is to
  # say that it's methods should not be called in end-user applications, but
  # are available for library and plugin authors who wish to extent it's
  # functionality.
  #
  # @example Retrieving the validators for a class.
  #   MyClass.validators # => #<ValidatorSet [#<Validator>, ...]>
  #
  class ValidatorSet

    include Enumerable

    # Creates a new ValidatorSet.
    #
    # @param [Enumerable<Luggage::Validator>] validators
    #   An optional collection of validators.
    #
    def initialize(validators = [])
      @validators = validators
    end

    # Determines if all of the contained validators are valid for the given
    # record in the given scenario.
    #
    # @param [Object] record
    #   The object whose validations are to be run.
    # @param [Symbol] scenario
    #   A name identifying the scenario.
    #
    # @return [Boolean]
    #   Returns true if the record validated, otherwise returns false.
    #
    def valid?(record, scenario = :default)
      inject(true) do |result, validator|
        validator.valid?(record).first && result
      end
    end

    # Iterates through each validator in the set.
    #
    # @yield [validator] Yields each validator in turn.
    # @yieldparam [Luggage::Validator]
    #
    def each(&block)
      @validators.each(&block)
    end

    # Adds a new validator to set.
    #
    # @param [Luggage::Validator] validator
    #   The validator to be added to the set.
    #
    def push(validator)
      @validators << validator
    end

    alias_method :<<, :push

    # Adds the validators contained in +other+ to the receiving set.
    #
    # @param [Luggage::ValidatorSet] set
    #   The validator set whose validators are to be added to the receiver.
    #
    #
    def merge!(other)
      @validators |= other.to_a
      self
    end

  end # ValidatorSet
end # Luggage
