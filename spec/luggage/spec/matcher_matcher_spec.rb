require File.expand_path('../../../spec_helper', __FILE__)

describe "Luggage RSpec matcher" do

  before(:each) do
    @exception = Spec::Expectations::ExpectationNotMetError
    @matcher   = Object.new
    @matcher.stub!(:expected).and_return('')
  end

  describe 'pass_matcher_with' do
    describe 'with "should"' do
      it 'should pass when the matcher returns true' do
        @matcher.should_receive(:matches?).and_return(true)

        running = lambda { @matcher.should pass_matcher_with('') }
        running.should_not raise_exception(@exception)
      end

      it 'should pass when the matcher returns nil' do
        @matcher.should_receive(:matches?).and_return(nil)

        running = lambda { @matcher.should pass_matcher_with('') }
        running.should_not raise_exception(@exception)
      end

      it 'should pass when the matcher returns an arbitrary object' do
        @matcher.should_receive(:matches?).and_return(Object.new)

        running = lambda { @matcher.should pass_matcher_with('') }
        running.should_not raise_exception(@exception)
      end

      it 'should fail when the matcher returns false' do
        @matcher.should_receive(:matches?).and_return(false)

        running = lambda { @matcher.should pass_matcher_with('') }
        running.should raise_exception(@exception)
      end

      it 'should fail when the matcher returns [false, ...]' do
        @matcher.should_receive(:matches?).and_return([false])

        running = lambda { @matcher.should pass_matcher_with('') }
        running.should raise_exception(@exception)
      end

    end # with "should"

    describe 'with "should_not"' do
      it 'should fail when the matcher returns true' do
        @matcher.should_receive(:matches?).and_return(true)

        running = lambda { @matcher.should_not pass_matcher_with('') }
        running.should raise_exception(@exception)
      end

      it 'should fail when the matcher returns nil' do
        @matcher.should_receive(:matches?).and_return(nil)

        running = lambda { @matcher.should_not pass_matcher_with('') }
        running.should raise_exception(@exception)
      end

      it 'should fail when the matcher returns an arbitrary object' do
        @matcher.should_receive(:matches?).and_return(Object.new)

        running = lambda { @matcher.should_not pass_matcher_with('') }
        running.should raise_exception(@exception)
      end

      it 'should pass when the matcher returns false' do
        @matcher.should_receive(:matches?).and_return(false)

        running = lambda { @matcher.should_not pass_matcher_with('') }
        running.should_not raise_exception(@exception)
      end

      it 'should pass when the matcher returns [false, ...]' do
        @matcher.should_receive(:matches?).and_return([false])

        running = lambda { @matcher.should_not pass_matcher_with('') }
        running.should_not raise_exception(@exception)
      end

    end # with "should_not"
  end # pass_matcher_with

  describe 'fail_matcher_with' do
    describe 'with no error expectation' do
      describe 'with "should"' do
        it 'should fail when the matcher returns true' do
          @matcher.should_receive(:matches?).and_return(true)

          running = lambda { @matcher.should fail_matcher_with('') }
          running.should raise_exception(@exception)
        end

        it 'should fail when the matcher returns nil' do
          @matcher.should_receive(:matches?).and_return(nil)

          running = lambda { @matcher.should fail_matcher_with('') }
          running.should raise_exception(@exception)
        end

        it 'should fail when the matcher returns an arbitrary object' do
          @matcher.should_receive(:matches?).and_return(Object.new)

          running = lambda { @matcher.should fail_matcher_with('') }
          running.should raise_exception(@exception)
        end

        it 'should pass when the matcher returns false' do
          @matcher.should_receive(:matches?).and_return(false)

          running = lambda { @matcher.should fail_matcher_with('') }
          running.should_not raise_exception(@exception)
        end

        it 'should pass when the matcher returns [false, ...]' do
          @matcher.should_receive(:matches?).and_return([false])

          running = lambda { @matcher.should fail_matcher_with('') }
          running.should_not raise_exception(@exception)
        end
      end # with "should"

      describe 'with "should_not"' do
        it 'should pass when the matcher returns true' do
          @matcher.should_receive(:matches?).and_return(true)

          running = lambda { @matcher.should_not fail_matcher_with('') }
          running.should_not raise_exception(@exception)
        end

        it 'should pass when the matcher returns nil' do
          @matcher.should_receive(:matches?).and_return(nil)

          running = lambda { @matcher.should_not fail_matcher_with('') }
          running.should_not raise_exception(@exception)
        end

        it 'should pass when the matcher returns an arbitrary object' do
          @matcher.should_receive(:matches?).and_return(Object.new)

          running = lambda { @matcher.should_not fail_matcher_with('') }
          running.should_not raise_exception(@exception)
        end

        it 'should fail when the matcher returns false' do
          @matcher.should_receive(:matches?).and_return(false)

          running = lambda { @matcher.should_not fail_matcher_with('') }
          running.should raise_exception(@exception)
        end

        it 'should fail when the matcher returns [false, ...]' do
          @matcher.should_receive(:matches?).and_return([false])

          running = lambda { @matcher.should_not fail_matcher_with('') }
          running.should raise_exception(@exception)
        end
      end # with "should_not"
    end # with no error expectation

    describe 'with an error expectation' do
      it 'should pass when the actual error matches the expected error' do
        @matcher.should_receive(:matches?).and_return([false, :e])

        running = lambda {
          @matcher.should fail_matcher_with('').with_error(:e)
        }

        running.should_not raise_exception(@exception)
      end

      it 'should fail when the actual error does not match the expected error' do
        @matcher.should_receive(:matches?).and_return([false, :e])

        running = lambda {
          @matcher.should fail_matcher_with('').with_error(:whoops)
        }

        running.should raise_exception(@exception)
      end
    end # with an error expectation
  end # fail_matcher_with

end
