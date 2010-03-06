require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Has do

  it 'should be registered with :has' do
    matcher = Luggage::Matchers.matchers[:has]
    matcher.should == Luggage::Matchers::Has
  end

  it 'should be registered with :have' do
    matcher = Luggage::Matchers.matchers[:have]
    matcher.should == Luggage::Matchers::Has
  end

  #
  # Collections.
  #

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
    # Detailsd #matches? tests can be found in features/has_matcher*.feature

    it 'should raise an error if the collection is nil' do
      matcher = Luggage::Matchers::Has.new.eql(5)

      running_this = lambda { matcher.should pass_matcher_with(nil) }
      running_this.should raise_exception(RuntimeError, /not a collection/)
    end

    it 'should call #length if available' do
      actual = mock()
      actual.should_receive(:length).once.and_return(5)
      actual.should_not_receive(:size)

      Luggage::Matchers::Has.new.eql(5).should pass_matcher_with(actual)
    end

    it 'should call #size if #length is not available' do
      actual = mock()
      actual.should_receive(:size).once.and_return(5)

      Luggage::Matchers::Has.new.eql(5).should pass_matcher_with(actual)
    end

    it 'should raise an error if the collection does not respond to ' \
       '#size or #length' do
      matcher = Luggage::Matchers::Has.new.eql(5)

      running_this = lambda { matcher.should pass_matcher_with(mock()) }
      running_this.should raise_exception(RuntimeError, /not a collection/)
    end
  end # matches?

end
