require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::CloseTo do

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

  describe '#matches?' do
    describe 'when the expected value is 10 with a delta of 5' do
      before(:all) do
        @matcher = Luggage::Matchers::CloseTo.new(10, 5)
      end

      it 'should pass if given 10' do
        @matcher.should pass_matcher_with(10)
      end

      it 'should pass if given 5' do
        @matcher.should pass_matcher_with(5)
      end

      it 'should pass if given 15' do
        @matcher.should pass_matcher_with(5)
      end

      it 'should pass if given 12.5' do
        @matcher.should pass_matcher_with(12.5)
      end

      it 'should pass if given 7.5' do
        @matcher.should pass_matcher_with(7.5)
      end

      it 'should fail if given 4' do
        @matcher.should fail_matcher_with(4)
      end

      it 'should fail if given 16' do
        @matcher.should fail_matcher_with(16)
      end

      it 'should fail if given 0' do
        @matcher.should fail_matcher_with(0)
      end

      it 'should fail if given -10' do
        @matcher.should fail_matcher_with(-10)
      end
    end

    describe 'when the expected value is 10 with a delta of 0' do
      before(:all) do
        @matcher = Luggage::Matchers::CloseTo.new(10, 0)
      end

      it 'should pass if given 10' do
        @matcher.should pass_matcher_with(10)
      end

      it 'should fail if given 9.9' do
        @matcher.should fail_matcher_with(9.9)
      end

      it 'should fail if given 10.1' do
        @matcher.should fail_matcher_with(10.1)
      end

      it 'should fail if given 0' do
        @matcher.should fail_matcher_with(0)
      end
    end

    describe 'when the expected value is 10 with a delta of 0.5' do
      before(:all) do
        @matcher = Luggage::Matchers::CloseTo.new(10, 0.5)
      end

      it 'should pass if given 10' do
        @matcher.should pass_matcher_with(10)
      end

      it 'should pass if given 10.5' do
        @matcher.should pass_matcher_with(10.5)
      end

      it 'should pass if given 9.5' do
        @matcher.should pass_matcher_with(9.5)
      end

      it 'should fail if given 10.6' do
        @matcher.should fail_matcher_with(10.6)
      end

      it 'should fail if given 9.4' do
        @matcher.should fail_matcher_with(9.4)
      end

      it 'should fail if given 0' do
        @matcher.should fail_matcher_with(0)
      end

      it 'should fail if given 11' do
        @matcher.should fail_matcher_with(11)
      end
    end

    describe 'when the expected value is 0.5 with a delta of 0.1' do
      before(:all) do
        @matcher = Luggage::Matchers::CloseTo.new(0.5, 0.1)
      end

      it 'should pass if given 0.5' do
        @matcher.should pass_matcher_with(0.5)
      end

      it 'should pass if given 0.4' do
        @matcher.should pass_matcher_with(0.4)
      end

      it 'should pass if given 0.6' do
        @matcher.should pass_matcher_with(0.6)
      end

      it 'should fail if given 0.7' do
        @matcher.should fail_matcher_with(0.7)
      end

      it 'should fail if given 0.3' do
        @matcher.should fail_matcher_with(0.3)
      end

      it 'should fail if given 0' do
        @matcher.should fail_matcher_with(0)
      end

      it 'should fail if given 1' do
        @matcher.should fail_matcher_with(1)
      end

      it 'should fail if given -0.5' do
        @matcher.should fail_matcher_with(-0.5)
      end
    end
  end # matches?

end
