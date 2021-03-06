require File.expand_path('../../spec_helper', __FILE__)

describe Ward::Matchers do
  subject  { Ward::Matchers }

  #
  # matchers
  #

  it { should respond_to(:matchers) }

  describe '#matchers' do
    it 'should return a Hash' do
      Ward::Matchers.matchers.should be_a(Hash)
    end
  end

  #
  # register
  #

  it { should respond_to(:register) }

  describe '#register' do
    before(:all) do
      class ::TestMatcher < Ward::Matchers::Matcher  ; end
      class ::TestMatcher2 < Ward::Matchers::Matcher ; end
    end

    it 'should register the Matcher with the given slug' do
      Ward::Matchers.matchers.should_not have_key(:__test_matcher__)
      Ward::Matchers.matchers.should_not have_value(::TestMatcher)
      Ward::Matchers.register(:__test_matcher__, ::TestMatcher)
      Ward::Matchers.matchers[:__test_matcher__].should == ::TestMatcher
    end

    it 'should overwrite an existing registration' do
      Ward::Matchers.register(:__test_matcher__, ::TestMatcher)
      Ward::Matchers.register(:__test_matcher__, ::TestMatcher2)
      Ward::Matchers.matchers[:__test_matcher__].should == ::TestMatcher2
    end

    it 'should permit registration multiple times with different slugs' do
      Ward::Matchers.register(:__test_matcher__, ::TestMatcher)
      Ward::Matchers.register(:__another_test_matcher__, ::TestMatcher)
      Ward::Matchers.matchers[:__test_matcher__].should == ::TestMatcher
      Ward::Matchers.matchers[:__another_test_matcher__].should == ::TestMatcher
    end
  end

end
