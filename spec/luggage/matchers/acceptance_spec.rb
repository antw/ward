require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Acceptance do

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher = Luggage::Matchers::Acceptance.new
    end

    it 'should fail when given nil' do
      @matcher.should fail_matcher_with(nil)
    end

    it 'should fail when given false' do
      @matcher.should fail_matcher_with(false)
    end

    it 'should fail when given 0' do
      @matcher.should fail_matcher_with(0)
    end

    # String negatives.
    %w( 0 n no false N NO FALSE ).each do |value|
      it "should fail when given #{value.inspect}" do
        @matcher.should fail_matcher_with(value)
      end
    end

    it 'should pass when given true' do
      @matcher.should pass_matcher_with(true)
    end

    it 'should pass when given 1' do
      @matcher.should pass_matcher_with(1)
    end

    # String positives.
    %w( 1 y yes true Y YES TRUE ).each do |value|
      it "should pass when given #{value.inspect}" do
        @matcher.should pass_matcher_with(value)
      end
    end
  end # matches?

end
