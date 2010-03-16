require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::EqualTo do

  it 'should be registered with :equal_to' do
    matcher = Ward::Matchers.matchers[:equal_to]
    matcher.should == Ward::Matchers::EqualTo
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/equal_to_matcher.feature

end
