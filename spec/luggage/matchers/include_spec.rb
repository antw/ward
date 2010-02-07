require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Include do

  #
  # initialize
  #

  describe '#initialize' do
    describe 'when given an object which responds to #include?' do
      it 'should not raise an error' do
        running_this = lambda { Luggage::Matchers::Include.new([]) }
        running_this.should_not raise_exception
      end
    end

    describe 'when given an object which does not respond to #include?' do
      it 'should raise an ArgumentError' do
        running_this = lambda { Luggage::Matchers::Include.new(nil) }
        running_this.should raise_exception(ArgumentError)
      end
    end
  end

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher  = Luggage::Matchers::Include.new([0, 1, 2])
    end

    it 'should pass if the actual value is included in the expectation' do
      @matcher.should pass_matcher_with(1)
    end

    it 'should fail if the actual value is not included in the expectation' do
      @matcher.should fail_matcher_with(3)
    end
  end # matches?

end
