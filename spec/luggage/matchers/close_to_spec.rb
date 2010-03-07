require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::CloseTo do

  it 'should be registered with :close_to' do
    matcher = Luggage::Matchers.matchers[:close_to]
    matcher.should == Luggage::Matchers::CloseTo
  end

  #
  # initialize
  #

  describe '#initialize' do
    describe 'when given a numeric as the first and second argument' do
      it 'should not raise an error' do
        running_this = lambda { Luggage::Matchers::CloseTo.new(1, 1) }
        running_this.should_not raise_exception
      end
    end

    describe 'when given a numeric as neither argument' do
      it 'should raise an error' do
        running_this = lambda { Luggage::Matchers::CloseTo.new('', '') }
        running_this.should raise_exception(ArgumentError)
      end
    end

    describe 'when given a numeric as the first, but not second, argument' do
      it 'should raise an error' do
        running_this = lambda { Luggage::Matchers::CloseTo.new(1, '') }
        running_this.should raise_exception(ArgumentError)
      end
    end

    describe 'when given a numeric as the second, but not first, argument' do
      it 'should raise an error' do
        running_this = lambda { Luggage::Matchers::CloseTo.new('', 1) }
        running_this.should raise_exception(ArgumentError)
      end
    end

    describe 'when given only one argument' do
      it 'should raise an error' do
        running_this = lambda { Luggage::Matchers::CloseTo.new(1) }
        running_this.should raise_exception(ArgumentError)
      end
    end
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/close_to_matcher.feature

end
