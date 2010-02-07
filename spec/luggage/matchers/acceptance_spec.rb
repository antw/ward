require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Acceptance do

  #
  # matches?
  #

  describe '#matches?' do
    before(:all) do
      @matcher = Luggage::Matchers::Acceptance.new
    end

    it 'should return false when given nil' do
      @matcher.matches?(nil).should be_false
    end

    it 'should return false when given false' do
      @matcher.matches?(false).should be_false
    end

    it 'should return false when given 0' do
      @matcher.matches?(0).should be_false
    end

    # String negatives.
    %w( 0 n no false N NO FALSE ).each do |value|
      it "should return false when given #{value.inspect}" do
        @matcher.matches?(value).should be_false
      end
    end

    it 'should return true when given true' do
      @matcher.matches?(true).should be_true
    end

    it 'should return true when given 1' do
      @matcher.matches?(1).should be_true
    end

    # String positives.
    %w( 1 y yes true Y YES TRUE ).each do |value|
      it "should return true when given #{value.inspect}" do
        @matcher.matches?(value).should be_true
      end
    end
  end # matches?

end
