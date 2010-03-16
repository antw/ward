require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Match do

  it 'should be registered with :matches' do
    matcher = Ward::Matchers.matchers[:matches]
    matcher.should == Ward::Matchers::Match
  end

  it 'should be registered with :match' do
    matcher = Ward::Matchers.matchers[:match]
    matcher.should == Ward::Matchers::Match
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/match_matcher.feature

end
