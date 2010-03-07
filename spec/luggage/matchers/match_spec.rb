require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Match do

  it 'should be registered with :matches' do
    matcher = Luggage::Matchers.matchers[:matches]
    matcher.should == Luggage::Matchers::Match
  end

  it 'should be registered with :match' do
    matcher = Luggage::Matchers.matchers[:match]
    matcher.should == Luggage::Matchers::Match
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/match_matcher.feature

end
