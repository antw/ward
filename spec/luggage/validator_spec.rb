require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Validator do
  subject { Luggage::Validator }

  #
  # context
  #

  it { should have_public_method_defined(:context) }

  describe '#context' do
    before(:all) do
      @context = Luggage::Validator.new('context', 'matcher').context
    end

    it 'should return the context' do
      @context.should == 'context'
    end
  end

  #
  # matcher
  #

  it { should have_public_method_defined(:matcher) }

  describe '#matcher' do
    before(:all) do
      @matcher = Luggage::Validator.new('context', 'matcher').matcher
    end

    it 'should return the matcher' do
      @matcher.should == 'matcher'
    end
  end

  #
  # valid?
  #

  it { should have_public_method_defined(:valid?) }

  describe '#valid?' do
    before(:all) do
      @validator = Luggage::Validator.new(
        Luggage::Context.new(:name), Luggage::Matchers::Nil.new
      )
    end

    describe 'when the matcher passes' do
      it 'should return true' do
        @validator.valid?(mock(:name => nil)).should be_true
      end
    end

    describe 'when the matcher fails' do
      before(:all) do
        @result = @validator.valid?(mock(:name => ''))
      end

      it 'should return an array' do
        @result.should be_an(Array)
      end

      it 'should use false as the first element' do
        @result.first.should be_false
      end

      # Perhaps this is one for Cucumber?
      it 'should add the error to the record errors'
    end
  end

  #
  # scenarios
  #

  it { should have_public_method_defined(:scenarios) }

  describe '#scenarios' do
    before(:all) do
      @matcher = Luggage::Validator.new('context', 'matcher').scenarios
    end

    it 'should return an array' do
      @matcher.should be_an(Array)
    end
  end

  #
  # scenario?
  #

  it { should have_public_method_defined(:scenario?) }

  describe '#scenario?' do
    it 'should return true when the validator exists in a given scenario' do
      validator = Luggage::Validator.new(nil, nil, [:update])
      validator.scenario?(:update).should be_true
    end

    it 'should return true when the validator does not exist in a given scenario' do
      validator = Luggage::Validator.new(nil, nil)
      validator.scenario?(:update).should be_false
    end
  end

end
