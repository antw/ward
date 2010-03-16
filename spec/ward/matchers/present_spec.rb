require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Present do

  it 'should be registered with :present' do
    matcher = Ward::Matchers.matchers[:present]
    matcher.should == Ward::Matchers::Present
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/present_matcher.feature

end
