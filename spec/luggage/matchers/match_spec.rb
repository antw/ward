require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Match do

  it 'should be registered with :matches' do
    matcher = Luggage::Matchers.matchers[:matches]
    matcher.should == Luggage::Matchers::Match
  end

  it 'should be registered with :match' do
    matcher = Luggage::Matchers.matchers[:match]
    matcher.should == Luggage::Matchers::Match
  end

  #
  # matches?
  #

  describe '#matches?' do
    describe 'when the expected value is a String' do
      before(:all) do
        @matcher = Luggage::Matchers::Match.new('Michael Scarn')
      end

      it 'should pass when the actual value matches the expectation' do
        @matcher.should pass_matcher_with('My name is Michael Scarn')
      end

      it 'should fail when the actual value does not match the expectation' do
        @matcher.should fail_matcher_with('My name is Samuel L. Chang')
      end
    end

    describe 'when the expected value is a Regexp' do
      before(:all) do
        @matcher = Luggage::Matchers::Match.new(/Michael Scarn/)
      end

      it 'should pass when the actual value matches the expectation' do
        @matcher.should pass_matcher_with('My name is Michael Scarn')
      end

      it 'should fail when the actual value does not match the expectation' do
        @matcher.should fail_matcher_with('My name is Samuel L. Chang')
      end
    end
  end # matches?

end
