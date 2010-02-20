require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Matchers do
  subject  { Luggage::Matchers }

  #
  # matchers
  #

  it { should respond_to(:matchers) }

  describe '#matchers' do
    it 'should return a Hash' do
      Luggage::Matchers.matchers.should be_a(Hash)
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
      Luggage::Matchers.matchers.should_not have_key(:__test_matcher__)
      Luggage::Matchers.matchers.should_not have_value(::TestMatcher)
      Luggage::Matchers.register(:__test_matcher__, ::TestMatcher)
      Luggage::Matchers.matchers[:__test_matcher__].should == ::TestMatcher
    end

    it 'should overwrite an existing registration' do
      Luggage::Matchers.register(:__test_matcher__, ::TestMatcher)
      Luggage::Matchers.register(:__test_matcher__, ::TestMatcher2)
      Luggage::Matchers.matchers[:__test_matcher__].should == ::TestMatcher2
    end

    it 'should permit registration multiple times with different slugs' do
      Luggage::Matchers.register(:__test_matcher__, ::TestMatcher)
      Luggage::Matchers.register(:__another_test_matcher__, ::TestMatcher)
      Luggage::Matchers.matchers[:__test_matcher__].should == ::TestMatcher
      Luggage::Matchers.matchers[:__another_test_matcher__].should == ::TestMatcher
    end
  end

end
