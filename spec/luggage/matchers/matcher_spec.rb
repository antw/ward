require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Matcher do
  subject { Luggage::Matchers::Matcher }

  it { should have_public_method_defined(:extra_args) }

  #
  # initialize
  #

  describe '#initialize' do
    it 'should not require an argument' do
      lambda { Luggage::Matchers::Matcher.new }.should_not raise_exception
    end

    it 'should store extra arguments' do
      Luggage::Matchers::Matcher.new(1, 2, 3).extra_args.should == [2, 3]
    end
  end

  #
  # expected
  #

  it { should have_public_method_defined(:expected) }

  describe '#expected' do
    before(:each) do
      @matcher = Luggage::Matchers::Matcher.new(1)
    end

    it 'should return the expected value' do
      @matcher.expected.should == 1
    end
  end

  #
  # matches?
  #

  it { should have_public_method_defined(:matches?) }

  describe '#matches?' do
    before(:each) do
      @matcher = Luggage::Matchers::Matcher.new(1)
    end

    it 'should pass' do
      @matcher.matches?(nil).should be_true
    end
  end

end
