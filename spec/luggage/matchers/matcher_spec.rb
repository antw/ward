require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Matcher do

  it 'should respond to #expected' do
    Luggage::Matchers::Matcher.new(1).should respond_to(:extra_args)
  end

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

  it 'should respond to #expected' do
    Luggage::Matchers::Matcher.new(1).should respond_to(:expected)
  end

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

  it 'should respond to #matches?' do
    Luggage::Matchers::Matcher.new(1).should respond_to(:matches?)
  end

  describe '#matches?' do
    before(:each) do
      @matcher = Luggage::Matchers::Matcher.new(1)
    end

    it 'should return true' do
      @matcher.matches?(nil).should be_true
    end
  end

end
