require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::DSL::ValidationBlock do

  #
  # to_validator_set
  #

  describe '#to_validator_set' do
    it 'should return a Ward::ValidatorSet' do
      set = Ward::DSL::ValidationBlock.new.to_validator_set
      set.should be_a(Ward::ValidatorSet)
    end
    end # to_validator_set

  #
  # method_missing
  #

  describe '#method_missing' do
    it 'should raise an exception when used outside of a run block' do
      running = lambda { Ward::DSL::ValidationBlock.new.name }
      running.should raise_error(RuntimeError, /a block/)
    end
  end

end