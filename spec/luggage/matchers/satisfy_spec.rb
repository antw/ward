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

  #
  # matches?
  #

  describe '#matches?' do
    describe 'when initialized with a block' do
      before(:all) do
        @matcher = Luggage::Matchers::Satisfy.new do |value, record|
          case value
            when 'Rincewind' then true
            when 'nil'       then nil
            else                  false
          end
        end
      end

      it 'should pass if the block returns true' do
        @matcher.should pass_matcher_with('Rincewind')
      end

      it 'should pass if the block returns nil' do
        @matcher.should pass_matcher_with('nil')
      end

      it 'should fail if the block returns false' do
        @matcher.should fail_matcher_with('__no_match__')
      end
    end

    describe 'when initialized given a Symbol' do
      before(:all) do
        @matcher = Luggage::Matchers::Satisfy.new(:validator_method)
      end

      it 'should pass if the method whose name matches the Symbol ' \
         'returns true' do
        pending "Awaiting validation DSL" do
          @matcher.should pass_matcher_with('Rincewind')
        end
      end

      it 'should pass if the method whose name matches the Symbol ' \
         'returns nil' do
        pending "Awaiting validation DSL" do
          @matcher.should pass_matcher_with('nil')
        end
      end

      it 'should fail if the method whose name matches the Symbol ' \
         'returns false' do
        pending "Awaiting validation DSL" do
          @matcher.should fail_matcher_with('__no_match__')
        end
      end
    end
  end # matches?

end
