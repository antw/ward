require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Acceptance do

  it 'should be registered with :accepted' do
    matcher = Luggage::Matchers.matchers[:accepted]
    matcher.should == Luggage::Matchers::Acceptance
  end

  #
  # matches?
  #

  describe '#matches?' do
    describe 'with the default expectated values' do
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
      %w( 0 n no false ).each do |value|
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
      %w( 1 y yes true ).each do |value|
        it "should pass when given #{value.inspect}" do
          @matcher.should pass_matcher_with(value)
        end
      end
    end

    describe 'with a single custom expected value' do
      before(:all) do
        @matcher = Luggage::Matchers::Acceptance.new('accept')
      end

      it 'should pass when the actual value is the expected value' do
        @matcher.should pass_matcher_with('accept')
      end

      it 'should pass when given true' do
        @matcher.should pass_matcher_with(true)
      end

      it 'should fail when the actual value is not the expected value' do
        @matcher.should fail_matcher_with(1)
      end
    end

    describe 'with many custom expected values' do
      before(:all) do
        @matcher = Luggage::Matchers::Acceptance.new(%w(accept 1))
      end

      it 'should pass when the actual value matches the expected value' do
        @matcher.should pass_matcher_with('accept')
        @matcher.should pass_matcher_with('1')
      end

      it 'should pass when given true' do
        @matcher.should pass_matcher_with(true)
      end

      it 'should fail when the actual value does not match the expected value' do
        @matcher.should fail_matcher_with(1)
        @matcher.should fail_matcher_with(2)
      end
    end
  end # matches?

end
