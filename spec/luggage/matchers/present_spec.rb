require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Present do

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher = Luggage::Matchers::Present.new
    end

    it 'should return false when given nil' do
      @matcher.matches?(nil).should be_false
    end

    it 'should return false when given false' do
      @matcher.matches?(false).should be_false
    end

    it 'should return true when given true' do
      @matcher.matches?(true).should be_true
    end

    it 'should return true when given a Symbol' do
      @matcher.matches?(:symbol).should be_true
    end

    describe 'when given a Numeric' do
      it 'should return true when 0' do
        @matcher.matches?(0).should be_true
      end

      it 'should return true when 0.0' do
        @matcher.matches?(0.0).should be_true
      end

      it 'should return true when 1' do
        @matcher.matches?(1).should be_true
      end

      it 'should return true when 01' do
        @matcher.matches?(01).should be_true
      end
    end

    describe 'when given a String' do
      it 'should return false when the string is empty' do
        @matcher.matches?('').should be_false
      end

      it 'should return false when the string contains only whitespace' do
        @matcher.matches?('  ').should be_false
        @matcher.matches?("\t").should be_false
        @matcher.matches?("\n").should be_false
      end

      it 'should return true when the string is non-empty' do
        @matcher.matches?('hello').should be_true
      end
    end

    describe 'when given an object which responds to #empty?' do
      before(:each) do
        @actual = Object.new
      end

      it 'should return true if #empty? is false' do
        @actual.should_receive(:empty?).and_return(false)
        @matcher.matches?(@actual).should be_true
      end

      it 'should return false if #empty? is true' do
        @actual.should_receive(:empty?).and_return(true)
        @matcher.matches?(@actual).should be_false
      end
    end
  end # matches?

end
