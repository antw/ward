require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::Matchers::Nil do

  it 'should be registered with :nil' do
    matcher = Ward::Matchers.matchers[:nil]
    matcher.should == Ward::Matchers::Nil
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/nil_matcher.feature

end
