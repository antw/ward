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

    it 'should pass when given the same object' do
      @matcher.should pass_matcher_with(@original)
    end

    it 'should pass when given a different object of equal value' do
      @matcher.should pass_matcher_with(@original.dup)
    end

    it 'should fail when given objects of different value' do
      @matcher.should fail_matcher_with(Object.new)
    end
  end # matches?

end
