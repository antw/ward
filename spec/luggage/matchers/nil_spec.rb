require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Nil do

  #
  # matches?
  #

  describe '#should fail_matcher_with' do
    before(:all) do
      @matcher = Luggage::Matchers::Nil.new
    end

    it 'should pass when given nil' do
      @matcher.should pass_matcher_with(nil)
    end

    it 'should fail when given true' do
      @matcher.should fail_matcher_with(true)
    end

    it 'should fail when given false' do
      @matcher.should fail_matcher_with(false)
    end

    it 'should fail when given a blank string' do
      @matcher.should fail_matcher_with('')
    end

    it 'should fail when given a non-blank string' do
      @matcher.should fail_matcher_with('string')
    end

    it 'should fail when given :symbol' do
      @matcher.should fail_matcher_with(:symbol)
    end

    it 'should fail when given 0' do
      @matcher.should fail_matcher_with(0)
    end

    it 'should fail when given -1' do
      @matcher.should fail_matcher_with(-1)
    end
  end # matches?

end
