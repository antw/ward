require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Matcher do
  subject { Ward::Matchers::Matcher }

  it { should have_public_method_defined(:extra_args) }

  it 'should be registered with :valid' do
    matcher = Ward::Matchers.matchers[:valid]
    matcher.should == Ward::Matchers::Matcher
  end

  #
  # initialize
  #

  describe '#initialize' do
    it 'should not require an argument' do
      lambda { Ward::Matchers::Matcher.new }.should_not raise_exception
    end

    it 'should store extra arguments' do
      Ward::Matchers::Matcher.new(1, 2, 3).extra_args.should == [2, 3]
    end
  end

  #
  # expected
  #

  it { should have_public_method_defined(:expected) }

  describe '#expected' do
    before(:each) do
      @matcher = Ward::Matchers::Matcher.new(1)
    end

    it 'should return the expected value' do
      @matcher.expected.should == 1
    end
  end

  #
  # matches?
  #

  it { should have_public_method_defined(:matches?) }

end
