require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::Matchers::Satisfy do

  it 'should supply the attribute value to to the block' do
    Luggage::Matchers::Satisfy.new do |value, record|
      value.should == 'Rincewind'
    end.matches?('Rincewind')
  end

  it 'should supply the record instance to the block' do
    pending "Awaiting validation DSL"
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

      it 'should return true if the block returns true' do
        @matcher.matches?('Rincewind').should == true
      end

      it 'should return true if the block returns nil' do
        @matcher.matches?('nil').should == true
      end

      it 'should return false if the block returns false' do
        @matcher.matches?('__no_match__').should == false
      end
    end

    describe 'when initialized given a Symbol' do
      before(:all) do
        @matcher = Luggage::Matchers::Satisfy.new(:validator_method)
      end

      it 'should return true if the method whose name matches the Symbol ' \
         'returns true' do
        pending "Awaiting validation DSL" do
          @matcher.matches?('Rincewind').should == true
        end
      end

      it 'should return true if the method whose name matches the Symbol ' \
         'returns nil' do
        pending "Awaiting validation DSL" do
          @matcher.matches?('nil').should == true
        end
      end

      it 'should return false if the method whose name matches the Symbol ' \
         'returns false' do
        pending "Awaiting validation DSL" do
          @matcher.matches?('__no_match__').should == false
        end
      end
    end
  end # matches?

end
