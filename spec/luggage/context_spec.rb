require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Context do

  #
  # attribute
  #

  it 'should respond to #attribute' do
    Luggage::Context.new(:full_name).should respond_to(:attribute)
  end

  describe '#attribute' do
    subject do
      @attribute = Luggage::Context.new('full_name').attribute
    end

    it { should be_a(Symbol) }
    it { should eql(:full_name) }
  end

  #
  # natural name
  #

  it 'should respond to #natural_name' do
    Luggage::Context.new(:full_name).should respond_to(:natural_name)
  end

  describe '#natural_name' do
    subject do
      @attribute = Luggage::Context.new('full_name').natural_name
    end

    it { should be_a(String) }
    it { should eql('Full name') }
  end

  #
  # value
  #

  describe '#value' do
    describe 'when the matcher has a custom value fetcher' do
      before(:all) do
        @matcher = Luggage::Context.new(:length) do |target|
          target.length.to_s
        end
      end

      it 'should retrieve the target value' do
        @matcher.value('abc').should == '3'
      end

      it 'should raise an error when the target does not respond to the ' \
         'target block' do
        lambda { @matcher.value(nil) }.should raise_exception(NoMethodError)
      end
    end

    describe 'when the matcher does not have a custom value fetcher' do
      before(:all) do
        @matcher = Luggage::Context.new(:length)
      end

      it 'should retrieve the target value' do
        @matcher.value('abc').should == 3
      end

      it 'should raise an error when the target does not respond to the ' \
         'target method' do
        lambda { @matcher.value(nil) }.should raise_exception(NoMethodError)
      end
    end
  end # value

end # Luggage::Context
