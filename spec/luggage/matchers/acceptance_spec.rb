require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Acceptance do

  it 'should be registered with :accepted' do
    matcher = Luggage::Matchers.matchers[:accepted]
    matcher.should == Luggage::Matchers::Acceptance
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/acceptance_matcher.feature

end
