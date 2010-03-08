require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Satisfy do

  it 'should be registered with :satisfies' do
    matcher = Luggage::Matchers.matchers[:satisfies]
    matcher.should == Luggage::Matchers::Satisfy
  end

  it 'should be registered with :satisfy' do
    matcher = Luggage::Matchers.matchers[:satisfy]
    matcher.should == Luggage::Matchers::Satisfy
  end

  #
  # block arguments
  #

  describe 'when the given block accepts no arguments' do
    it 'should supply nothing to to the block' do
      running = lambda { Luggage::Matchers::Satisfy.new {}.matches?('nil') }
      running.should_not raise_error
    end
  end

  describe 'when the given block accepts one argument' do
    it 'should supply the attribute value to to the block' do
      Luggage::Matchers::Satisfy.new do |value|
        value.should == 'Rincewind'
      end.matches?('Rincewind')
    end
  end

  describe 'when the given block accepts two arguments' do
    it 'should supply the attribute value to to the block' do
      Luggage::Matchers::Satisfy.new do |value, record|
        value.should == 'Rincewind'
      end.matches?('Rincewind')
    end

    it 'should supply the record instance to to the block' do
      Luggage::Matchers::Satisfy.new do |value, record|
        record.should == 'Discworld'
      end.matches?('Rincewind', 'Discworld')
    end
  end

  describe 'when the given block accepts a splat argument' do
    it 'should supply the attribute value to the block' do
      Luggage::Matchers::Satisfy.new do |*args|
        args.first.should == 'Rincewind'
      end.matches?('Rincewind', 'Discworld')
    end

    it 'should supply the record instance to the block' do
      Luggage::Matchers::Satisfy.new do |*args|
        args.last.should == 'Discworld'
      end.matches?('Rincewind', 'Discworld')
    end
  end

  #
  # matches?
  #

  # #matches? tests can be found in features/satisfy_matcher.feature

end
