require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Nil do

  it 'should be registered with :nil' do
    matcher = Luggage::Matchers.matchers[:nil]
    matcher.should == Luggage::Matchers::Nil
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/nil_matcher.feature

end
