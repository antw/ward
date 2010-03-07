require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::EqualTo do

  it 'should be registered with :equal_to' do
    matcher = Luggage::Matchers.matchers[:equal_to]
    matcher.should == Luggage::Matchers::EqualTo
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/equal_to_matcher.feature

end
