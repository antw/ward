require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Present do

  it 'should be registered with :present' do
    matcher = Luggage::Matchers.matchers[:present]
    matcher.should == Luggage::Matchers::Present
  end

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher = Luggage::Matchers::Present.new
    end

    it 'should fail when given nil' do
      @matcher.should fail_matcher_with(nil)
    end

    it 'should fail when given false' do
      @matcher.should fail_matcher_with(false)
    end

    it 'should pass when given true' do
      @matcher.should pass_matcher_with(true)
    end

    it 'should pass when given a Symbol' do
      @matcher.should pass_matcher_with(:symbol)
    end

    describe 'when given a Numeric' do
      it 'should pass when 0' do
        @matcher.should pass_matcher_with(0)
      end

      it 'should pass when 0.0' do
        @matcher.should pass_matcher_with(0.0)
      end

      it 'should pass when 1' do
        @matcher.should pass_matcher_with(1)
      end

      it 'should pass when 01' do
        @matcher.should pass_matcher_with(01)
      end
    end

    describe 'when given a String' do
      it 'should fail when the string is empty' do
        @matcher.should fail_matcher_with('')
      end

      it 'should fail when the string contains only whitespace' do
        @matcher.should fail_matcher_with('  ')
        @matcher.should fail_matcher_with("\t")
        @matcher.should fail_matcher_with("\n")
      end

      it 'should pass when the string is non-empty' do
        @matcher.should pass_matcher_with('hello')
      end
    end

    describe 'when given an object which responds to #empty?' do
      before(:each) do
        @actual = Object.new
      end

      it 'should pass if #empty? is false' do
        @actual.should_receive(:empty?).and_return(false)
        @matcher.should pass_matcher_with(@actual)
      end

      it 'should fail if #empty? is true' do
        @actual.should_receive(:empty?).and_return(true)
        @matcher.should fail_matcher_with(@actual)
      end
    end
  end # matches?

end
