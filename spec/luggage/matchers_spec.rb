require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Matchers do
  subject  { Luggage::Matchers }
  Matchers = Luggage::Matchers

  #
  # matchers
  #

  it { should respond_to(:matchers) }

  describe '#matchers' do
    it 'should return a Hash' do
      Matchers.matchers.should be_a(Hash)
    end
  end

  #
  # register
  #

  it { should respond_to(:register) }

  describe '#register' do
    before(:all) do
      class ::TestMatcher < Luggage::Matchers::Matcher  ; end
      class ::TestMatcher2 < Luggage::Matchers::Matcher ; end
    end

    it 'should register the Matcher with the given slug' do
      Matchers.matchers.should_not have_key(:__test_matcher__)
      Matchers.matchers.should_not have_value(::TestMatcher)
      Matchers.register(:__test_matcher__, ::TestMatcher)
      Matchers.matchers[:__test_matcher__].should == ::TestMatcher
    end

    it 'should overwrite an existing registration' do
      Matchers.register(:__test_matcher__, ::TestMatcher)
      Matchers.register(:__test_matcher__, ::TestMatcher2)
      Matchers.matchers[:__test_matcher__].should == ::TestMatcher2
    end

    it 'should permit registration multiple times with different slugs' do
      Matchers.register(:__test_matcher__, ::TestMatcher)
      Matchers.register(:__another_test_matcher__, ::TestMatcher)
      Matchers.matchers[:__test_matcher__].should == ::TestMatcher
      Matchers.matchers[:__another_test_matcher__].should == ::TestMatcher
    end
  end

end
