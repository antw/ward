require File.expand_path('../../../spec_helper', __FILE__)

describe Ward::DSL::ValidationBuilder do
  subject { Ward::DSL::ValidationBuilder }

  #
  # when setting a matcher
  #

  describe 'when setting a matcher' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new
    end

    it "should set an Acceptance matcher when calling #accepted" do
      validator = @builder.is.accepted.to_validator
      validator.matcher.should be_a(Ward::Matchers::Acceptance)
    end

    it "should set a CloseTo matcher when calling #close_to" do
      validator = @builder.is.close_to(1, 1).to_validator
      validator.matcher.should be_a(Ward::Matchers::CloseTo)
    end

    it "should set an EqualTo matcher when calling #equal_to" do
      validator = @builder.is.equal_to(1).to_validator
      validator.matcher.should be_a(Ward::Matchers::EqualTo)
    end

    it "should set a Has matcher when calling #has" do
      validator = @builder.has.to_validator
      validator.matcher.should be_a(Ward::Matchers::Has)
    end

    it "should set a Has matcher when calling #have" do
      validator = @builder.have(1, 1).to_validator
      validator.matcher.should be_a(Ward::Matchers::Has)
    end

    it "should set an Include matcher when calling #included_in" do
      validator = @builder.is.included_in([]).to_validator
      validator.matcher.should be_a(Ward::Matchers::Include)
    end

    it "should set a Match matcher when calling #matches" do
      validator = @builder.matches(//).to_validator
      validator.matcher.should be_a(Ward::Matchers::Match)
    end

    it "should set a Match matcher when calling #match" do
      validator = @builder.match(//).to_validator
      validator.matcher.should be_a(Ward::Matchers::Match)
    end

    it "should set a Nil matcher when calling #nil" do
      validator = @builder.is.nil.to_validator
      validator.matcher.should be_a(Ward::Matchers::Nil)
    end

    it "should set a Present matcher when calling #present" do
      validator = @builder.is.present.to_validator
      validator.matcher.should be_a(Ward::Matchers::Present)
    end

    it "should set a Satisfy matcher when calling #satisfies" do
      validator = @builder.satisfies.to_validator
      validator.matcher.should be_a(Ward::Matchers::Satisfy)
    end

    it "should set a Satisfy matcher when calling #satisfy" do
      validator = @builder.satisfy.to_validator
      validator.matcher.should be_a(Ward::Matchers::Satisfy)
    end
  end

  #
  # customising a matcher
  #

  describe 'calling a missing method when a matcher is set' do
    it 'should call methods on the matcher' do
      builder = Ward::DSL::ValidationBuilder.new.has
      builder.to_validator.matcher.expected.should == 1 # default
      builder.at_least(5)
      builder.to_validator.matcher.expected.should == 5
    end
  end

  #
  # when setting a context name
  #

  describe '#attribute' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new
    end

    it 'should return the builder' do
      @builder.attribute(:name).should be(@builder)
    end
  end

  #
  # when setting a message
  #

  describe '#message' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new.is.present
    end

    it 'should return the builder' do
      @builder.message('A validation error message').should be(@builder)
    end

    it 'should set the validation message' do
      validator = @builder.message('A validation error message').to_validator
      validator.message.should == 'A validation error message'
    end
  end

  describe 'with no message' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new.is.present
    end

    it 'should set the validation message' do
      validator = @builder.to_validator
      validator.message.should be_nil
    end
  end

  #
  # when setting a scenario
  #

  describe '#scenario' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new.is.present
    end

    it 'should return the builder' do
      @builder.scenario(:scenario).should be(@builder)
    end

    it 'should set the validation scenario' do
      validator = @builder.scenario(:scenario).to_validator
      validator.scenarios.should == [:scenario]
    end
  end

  describe '#scenarios' do
    before(:each) do
      @builder = Ward::DSL::ValidationBuilder.new.is.present
    end

    it 'should return the builder' do
      @builder.scenarios([:scenario]).should be(@builder)
    end

    it 'should set multiple scenarios when given an array' do
      validator = @builder.scenarios([:one, :two]).to_validator
      validator.scenarios.should == [:one, :two]
    end

    it 'should set multiple scenarios when given a multiple arguments' do
      validator = @builder.scenarios(:one, :two).to_validator
      validator.scenarios.should == [:one, :two]
    end
  end

  #
  # to_validator
  #

  it { should have_public_method_defined(:to_validator) }

  describe '#to_validator' do
    describe 'when no matcher is defined' do
      it 'should raise an IncompleteValidator exception' do
        running = lambda { Ward::DSL::ValidationBuilder.new.to_validator }
        running.should raise_exception(Ward::IncompleteValidator)
      end
    end

    describe 'when a matcher is defined' do
      before(:all) do
        builder = Ward::DSL::ValidationBuilder.new.author.name
        builder.is.equal_to(1)
        @validator = builder.to_validator
      end

      it 'should return a Ward::Validator' do
        @validator.should be_a(Ward::Validator)
      end

      it 'should set the matcher' do
        @validator.matcher.should be_a(Ward::Matchers::Matcher)
      end

      it 'should set the matcher expectation' do
        @validator.matcher.expected.should == 1
      end

      it 'should set the context' do
        attributes = @validator.context.to_a.map { |c| c.attribute }
        attributes.should == [:author, :name]
      end
    end
  end

end
