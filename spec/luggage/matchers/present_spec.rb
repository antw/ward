require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Present do

  it 'should be registered with :present' do
    matcher = Luggage::Matchers.matchers[:present]
    matcher.should == Luggage::Matchers::Present
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/present_matcher.feature

end
