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
  # .build
  #

  describe '.build' do
    describe 'when no initial set is provided' do
      it 'should add the validators to the set' do
        dsl = Luggage::DSL::ValidationBlock.build do |object|
          object.name.matches(/abc/)
          object.name.length.is.equal_to(3)
        end

        # ValidatorSet doesn't have a size method, but does implement Enumerable
        dsl.inject(0) { |c, *| c += 1 }.should == 2
      end
    end # when no initial set is provided

    describe 'when an initial set is provided' do
      before(:all) do
        @initial = Luggage::DSL::ValidationBlock.build do |object|
          object.name.matches(/abc/)
          object.name.length.is.equal_to(3)
        end

        @set = Luggage::DSL::ValidationBlock.build(@initial) do |object|
          object.name.present
        end
      end

      it 'should add the new validators to a copy of the initial set' do
        # ValidatorSet doesn't have a size method, but does implement Enumerable
        @set.inject(0) { |c, *| c += 1 }.should == 3
      end

      it 'should return a copy of the initial set' do
        @set.should_not == @initial
        @initial.inject(0) { |c, *| c += 1 }.should == 2
      end
    end # when an initial set is provided
  end # .build

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