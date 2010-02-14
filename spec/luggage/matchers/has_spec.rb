require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Has do

  describe 'when setting a collection' do
    before(:all) do
      @matcher = Luggage::Matchers::Has.new(1)
      @return  = @matcher.author
    end

    it 'should return the matcher' do
      @return.should == @matcher
    end

    it 'should set the collection name' do
      @matcher.collection_name.should == :author
    end
  end

  #
  # Relativities.
  #

  [:lt, :less_than, :fewer_than].each do |method|
    describe "##{method}" do
      # lt sets the relativity to :lte, and decreases the expectation by
      # such that is is within the :lte range.
      before(:all) { @method, @relativity = method, :lte }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == 4
      end
    end
  end

  [:lte, :at_most].each do |method|
    describe "##{method}" do
      before(:all) { @method, @relativity = method, :lte }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == 5
      end
    end
  end

  [:eql, :exactly].each do |method|
    describe "##{method}" do
      before(:all) { @method, @relativity = method, :eql }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == 5
      end
    end
  end

  [:gte, :at_least].each do |method|
    describe "##{method}" do
      before(:all) { @method, @relativity = method, :gte }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == 5
      end
    end
  end

  [:gt, :greater_than, :more_than].each do |method|
    # gt sets the relativity to :gte, and increases the expectation by 1 such
    # that is is within the :gte range.
    describe "##{method}" do
      before(:all) { @method, @relativity = method, :gte }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == 6
      end
    end
  end

  describe '#between' do
    before(:all) { @method, @relativity = :between, :between }

    describe 'when given a range as the expectation' do
      before(:all) { @expectation = [(1..5)] }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == (1..5)
      end
    end

    describe 'when given a two numerics as the expectation' do
      before(:all) { @expectation = [1, 5] }

      it_should_behave_like 'Has matcher relativity method'

      it 'should set the expected value' do
        @matcher.expected.should == (1..5)
      end
    end

    it 'should raise an error when given a single numeric' do
      running_this = lambda { Luggage::Matchers::Has.new.between(1) }
      running_this.should raise_exception(ArgumentError, /upper boundary/)
    end
  end

  it 'should raise an error if setting a relativity when one is already set' do
    matcher = Luggage::Matchers::Has.new.at_least(1)
    running_this = lambda { matcher.at_most(6) }
    running_this.should raise_exception(RuntimeError, /already set/)
  end

  #
  # matches?
  #

  describe '#matches?' do
    describe 'when no expected value is set' do
      before(:all) do
        @matcher = Luggage::Matchers::Has.new
      end

      it 'should pass if the collection has > 0 members' do
        @matcher.should pass_matcher_with(mock(:size => 1))
      end

      it 'should fail if the collection has 0 members' do
        @matcher.should fail_matcher_with(mock(:size => 0))
      end
    end

    describe "with no collection name" do

      describe 'when no relativity is set' do # defaults to :eql
        before(:all) do
          @matcher = Luggage::Matchers::Has.new(5)
        end

        [:size, :length].each do |method|
          describe "and the value responds to ##{method}" do
            it 'should fail if the collection has < n members' do
              @matcher.should fail_matcher_with(mock(method => 4))
            end

            it 'should pass if the collection has == n members' do
              @matcher.should pass_matcher_with(mock(method => 5))
            end

            it 'should fail if the collection has > n members' do
              @matcher.should fail_matcher_with(mock(method => 6))
            end
          end
        end
      end

      describe 'when relativity is :eql' do
        before(:all) do
          @matcher = Luggage::Matchers::Has.new.eql(5)
        end

        [:size, :length].each do |method|
          describe "and the value responds to ##{method}" do
            it 'should fail if the collection has < n members' do
              @matcher.should fail_matcher_with(mock(method => 4))
            end

            it 'should pass if the collection has == n members' do
              @matcher.should pass_matcher_with(mock(method => 5))
            end

            it 'should fail if the collection has > n members' do
              @matcher.should fail_matcher_with(mock(method => 6))
            end
          end
        end
      end # when relativity is :eql

      describe 'when relativity is :lte' do
        before(:all) do
          @matcher = Luggage::Matchers::Has.new.lte(5)
        end

        [:size, :length].each do |method|
          describe "and the value responds to ##{method}" do
            it "should pass if the collection has < n members" do
              @matcher.should pass_matcher_with(mock(method => 4))
            end

            it 'should pass if the collection has == n members' do
              @matcher.should pass_matcher_with(mock(method => 5))
            end

            it 'should fail if the collection has > n members' do
              @matcher.should fail_matcher_with(mock(method => 6))
            end
          end
        end
      end # when relativity is :lte

      describe 'when relativity is :gte' do
        before(:all) do
          @matcher = Luggage::Matchers::Has.new.gte(5)
        end

        [:size, :length].each do |method|
          describe "and the value responds to ##{method}" do
            it 'should fail if the collection has < n members' do
              @matcher.should fail_matcher_with(mock(method => 4))
            end

            it 'should pass if the collection has == n members' do
              @matcher.should pass_matcher_with(mock(method => 5))
            end

            it 'should pass if the collection has > n members' do
              @matcher.should pass_matcher_with(mock(method => 6))
            end
          end
        end
      end # when relativity is :gte

      describe 'when relativity is :between' do
        before(:all) do
          @matcher = Luggage::Matchers::Has.new.between(4..5)
        end

        [:size, :length].each do |method|
          describe "and the value responds to ##{method}" do
            it 'should fail if the collection has < n members' do
              @matcher.should fail_matcher_with(mock(method => 3))
            end

            it 'should pass if the collection has == n members' do
              @matcher.should pass_matcher_with(mock(method => 4))
              @matcher.should pass_matcher_with(mock(method => 5))
            end

            it 'should fail if the collection has > n members' do
              @matcher.should fail_matcher_with(mock(method => 6))
            end
          end
        end
      end # when relativity is :between
    end # no collection name

    describe 'when a collection name is set' do
      it 'should use the length of the collection' do
        # The matcher will fail if it attempts to use the actual value's size,
        # but will pass if it retrieves the size of the correct collection.
        actual = mock(:size => 0, :posts => mock(:size => 5))

        matcher = Luggage::Matchers::Has.new.eql(5).posts
        matcher.should pass_matcher_with(actual)
      end

      it 'should ignore if if the owner does not respond' do
        matcher = Luggage::Matchers::Has.new.eql(5).characters
        matcher.should pass_matcher_with(mock(:size => 5))
      end
    end

    it 'should raise an error if the collection is nil' do
      matcher = Luggage::Matchers::Has.new.eql(5)

      running_this = lambda { matcher.should pass_matcher_with(nil) }
      running_this.should raise_exception(RuntimeError, /not a collection/)
    end

    it 'should raise an error if the collection does not respond to ' \
       ':size or :length' do
      matcher = Luggage::Matchers::Has.new.eql(5)

      running_this = lambda { matcher.should pass_matcher_with(mock()) }
      running_this.should raise_exception(RuntimeError, /not a collection/)
    end
  end # matches?

end
