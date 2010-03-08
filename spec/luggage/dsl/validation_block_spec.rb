require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::DSL::ValidationBlock do

  #
  # to_validator_set
  #

  describe '#to_validator_set' do
    it 'should return a Luggage::ValidatorSet' do
      set = Luggage::DSL::ValidationBlock.new.to_validator_set
      set.should be_a(Luggage::ValidatorSet)
    end
    end # to_validator_set

  #
  # method_missing
  #

  describe '#method_missing' do
    it 'should raise an exception when used outside of a run block' do
      running = lambda { Luggage::DSL::ValidationBlock.new.name }
      running.should raise_error(RuntimeError, /a block/)
    end
  end

end