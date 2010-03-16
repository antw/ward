require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Acceptance do

  it 'should be registered with :accepted' do
    matcher = Ward::Matchers.matchers[:accepted]
    matcher.should == Ward::Matchers::Acceptance
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/acceptance_matcher.feature

end
