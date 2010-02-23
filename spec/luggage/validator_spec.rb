require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Validator do
  subject { Luggage::Validator }

  #
  # initialize
  #

  describe '#initialize' do
    describe 'scenarios' do
      it 'should be [:default] when no scenarios option is given' do
        Luggage::Validator.new(nil, nil).scenarios.should == [:default]
      end

      it 'should be [:scenario] when the scenarios option is [:scenario]' do
        validator = Luggage::Validator.new(nil, nil, :scenarios => [:scenario])
        validator.scenarios.should == [:scenario]
      end

      it 'should be [:scenario] when the scenarios option is :scenario' do
        validator = Luggage::Validator.new(nil, nil, :scenarios => :scenario)
        validator.scenarios.should == [:scenario]
      end
    end
  end

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

      it 'should return false' do
        @result.should be_false
      end

      # Perhaps this is one for Cucumber?
      it 'should add the error to the record errors'
    end

    describe 'when the matcher fails and return an error' do
      before(:all) do
        @validator.matcher.stub(:matches?).and_return([false, :error])
        @result = @validator.valid?(mock(:name => ''))
      end

      it 'should return false' do
        @result.should be_false
      end

      # Perhaps this is one for Cucumber?
      it 'should add the error to the record errors'
    end

    #
    # argument counts
    #

    describe 'when matcher #matches? accepts' do
      describe 'one argument' do
        it 'should supply the record' do
          value  = ''

          Luggage::Validator.new(Luggage::Context.new(:name),
            Class.new do
              include Spec::Matchers
              define_method :matches? do |arg1|
                arg1.should equal(value)
              end
            end.new
          ).valid?(mock(:name => value))
        end
      end

      describe 'two arguments' do
        it 'should supply the attribute and record' do
          value  = ''
          record = mock(:name => value)

          Luggage::Validator.new(Luggage::Context.new(:name),
            Class.new do
              include Spec::Matchers
              define_method :matches? do |arg1, arg2|
                arg1.should equal(value)
                arg2.should equal(record)
              end
            end.new
          ).valid?(record)
        end
      end
    end # when matcher #matches? accepts (one|two) arguments?

  end # valid?

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
      validator = Luggage::Validator.new(nil, nil, :scenarios => [:update])
      validator.scenario?(:update).should be_true
    end

    it 'should return true when the validator does not exist in a given scenario' do
      validator = Luggage::Validator.new(nil, nil)
      validator.scenario?(:update).should be_false
    end
  end

end
