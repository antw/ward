require File.expand_path('../../../spec_helper', __FILE__)

describe "Luggage RSpec matcher matcher" do
  before(:each) do
    @exception = Spec::Expectations::ExpectationNotMetError
    @matcher   = Object.new

    @matcher.stub!(:expected).and_return('expected')
  end

  describe 'pass_matcher_with' do
    describe 'when given a valid value' do
      it 'should be pass when using "should"' do
        @matcher.should_receive(:matches?).with('valid').and_return(true)

        running = lambda { @matcher.should pass_matcher_with('valid') }
        running.should_not raise_exception(@exception)
      end

      it 'should be fail when using "should not"' do
        @matcher.should_receive(:matches?).with('valid').and_return(true)

        running = lambda { @matcher.should_not pass_matcher_with('valid') }
        running.should raise_exception(@exception)
      end
    end

    describe 'when given an invalid value' do
      it 'should be fail when using "should"' do
        @matcher.should_receive(:matches?).with('invalid').and_return(false)

        running = lambda { @matcher.should pass_matcher_with('invalid') }
        running.should raise_exception(@exception)
      end

      it 'should be pass when using "should not"' do
        @matcher.should_receive(:matches?).with('invalid').and_return(false)

        running = lambda { @matcher.should_not pass_matcher_with('invalid') }
        running.should_not raise_exception(@exception)
      end
    end
  end # pass_matcher_with

  describe 'fail_matcher_with' do
    describe 'when given a valid value' do
      it 'should fail when using "should"' do
        @matcher.should_receive(:matches?).with('valid').and_return(true)

        running = lambda { @matcher.should fail_matcher_with('valid') }
        running.should raise_exception(@exception)
      end

      it 'should pass when using "should not"' do
        @matcher.should_receive(:matches?).with('valid').and_return(true)

        running = lambda { @matcher.should_not fail_matcher_with('valid') }
        running.should_not raise_exception(@exception)
      end
    end

    describe 'when given an invalid value' do
      it 'should pass when using "should"' do
        @matcher.should_receive(:matches?).with('invalid').and_return(false)

        running = lambda { @matcher.should fail_matcher_with('invalid') }
        running.should_not raise_exception(@exception)
      end

      it 'should fail when using "should not"' do
        @matcher.should_receive(:matches?).with('invalid').and_return(false)

        running = lambda { @matcher.should_not fail_matcher_with('invalid') }
        running.should raise_exception(@exception)
      end
    end
  end # fail_matcher_with
end
