require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::EqualTo do

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @original = 'one'
      @matcher  = Luggage::Matchers::EqualTo.new(@original)
    end

    it 'should return true when given the same object' do
      @matcher.matches?(@original).should be_true
    end

    it 'should return true when given a different object of equal value' do
      @matcher.matches?(@original.dup).should be_true
    end

    it 'should return false when given objects of different value' do
      @matcher.matches?(Object.new).should be_false
    end
  end # matches?

end
