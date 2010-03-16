require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Include do

  it 'should be registered with :included_in' do
    matcher = Ward::Matchers.matchers[:included_in]
    matcher.should == Ward::Matchers::Include
  end

  it 'should be registered with :one_of' do
    matcher = Ward::Matchers.matchers[:one_of]
    matcher.should == Ward::Matchers::Include
  end

  #
  # initialize
  #

  describe '#initialize' do
    describe 'when given an object which responds to #include?' do
      it 'should not raise an error' do
        running_this = lambda { Ward::Matchers::Include.new([]) }
        running_this.should_not raise_exception
      end
    end

    describe 'when given an object which does not respond to #include?' do
      it 'should raise an ArgumentError' do
        running_this = lambda { Ward::Matchers::Include.new(nil) }
        running_this.should raise_exception(ArgumentError)
      end
    end
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/include_matcher.feature

end
