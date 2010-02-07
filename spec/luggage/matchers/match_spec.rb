require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Match do

  #
  # matches?
  #

  describe '#matches?' do
    describe 'when the expected value is a String' do
      before(:all) do
        @matcher = Luggage::Matchers::Match.new('Michael Scarn')
      end

      it 'should return true when the actual value matches the expectation' do
        @matcher.matches?('My name is Michael Scarn').should be_true
      end

      it 'should return true when the actual value does not match ' \
         'the expectation' do
        @matcher.matches?('My name is Samuel L. Chang').should be_false
      end
    end

    describe 'when the expected value is a Regexp' do
      before(:all) do
        @matcher = Luggage::Matchers::Match.new(/Michael Scarn/)
      end

      it 'should return true when the actual value matches the expectation' do
        @matcher.matches?('My name is Michael Scarn').should be_true
      end

      it 'should return true when the actual value does not match ' \
         'the expectation' do
        @matcher.matches?('My name is Samuel L. Chang').should be_false
      end
    end
  end # matches?

end
