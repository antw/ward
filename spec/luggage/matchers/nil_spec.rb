require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Nil do

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher = Luggage::Matchers::Nil.new
    end

    it 'should return true when given nil' do
      @matcher.matches?(nil).should be_true
    end

    it 'should return false when given true' do
      @matcher.matches?(true).should be_false
    end

    it 'should return false when given false' do
      @matcher.matches?(false).should be_false
    end

    it 'should return false when given a blank string' do
      @matcher.matches?('').should be_false
    end

    it 'should return false when given a non-blank string' do
      @matcher.matches?('string').should be_false
    end

    it 'should return false when given :symbol' do
      @matcher.matches?(:symbol).should be_false
    end

    it 'should return false when given 0' do
      @matcher.matches?(0).should be_false
    end

    it 'should return false when given -1' do
      @matcher.matches?(-1).should be_false
    end
  end # matches?

end
