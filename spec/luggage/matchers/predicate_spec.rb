require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Predicate do

  #
  # matches?
  #

  # #matches? tests can be found in features/present_matcher.feature

  describe '#matches?' do
    it "should raise an error if the actual value doesn't respond to the method" do
      matcher = Luggage::Matchers::Predicate.new(:important?)
      running = lambda { matcher.matches?(nil) }
      running.should raise_error(ArgumentError, /does not respond/)
    end
  end

end
