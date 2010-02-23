require File.expand_path('../../../spec_helper', __FILE__)

describe Luggage::DSL::ValidationBuilder do
  subject { Luggage::DSL::ValidationBuilder }

  #
  # when setting a matcher
  #

  describe 'when setting a matcher' do
    before(:each) do
      @builder = Luggage::DSL::ValidationBuilder.new
    end

    it "should set an Acceptance matcher when calling #accepted" do
      validator = @builder.accepted.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Acceptance)
    end

    it "should set a CloseTo matcher when calling #close_to" do
      validator = @builder.close_to(1, 1).to_validator
      validator.matcher.should be_a(Luggage::Matchers::CloseTo)
    end

    it "should set an EqualTo matcher when calling #equal_to" do
      validator = @builder.equal_to(1).to_validator
      validator.matcher.should be_a(Luggage::Matchers::EqualTo)
    end

    it "should set an Exclude matcher when calling #excluded_from" do
      validator = @builder.excluded_from([]).to_validator
      validator.matcher.should be_a(Luggage::Matchers::Exclude)
    end

    it "should set a Has matcher when calling #has" do
      validator = @builder.has.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Has)
    end

    it "should set a Has matcher when calling #have" do
      validator = @builder.have(1, 1).to_validator
      validator.matcher.should be_a(Luggage::Matchers::Has)
    end

    it "should set an Include matcher when calling #included_in" do
      validator = @builder.included_in([]).to_validator
      validator.matcher.should be_a(Luggage::Matchers::Include)
    end

    it "should set a Match matcher when calling #matches" do
      validator = @builder.matches(//).to_validator
      validator.matcher.should be_a(Luggage::Matchers::Match)
    end

    it "should set a Match matcher when calling #match" do
      validator = @builder.match(//).to_validator
      validator.matcher.should be_a(Luggage::Matchers::Match)
    end

    it "should set a Nil matcher when calling #nil" do
      validator = @builder.nil.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Nil)
    end

    it "should set a Present matcher when calling #present" do
      validator = @builder.present.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Present)
    end

    it "should set a Satisfy matcher when calling #satisfies" do
      validator = @builder.satisfies.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Satisfy)
    end

    it "should set a Satisfy matcher when calling #satisfy" do
      validator = @builder.satisfy.to_validator
      validator.matcher.should be_a(Luggage::Matchers::Satisfy)
    end
  end

  #
  # customising a matcher
  #

  describe 'calling a missing method when a matcher is set' do
    it 'should call methods on the matcher' do
      builder = Luggage::DSL::ValidationBuilder.new.has
      builder.to_validator.matcher.expected.should == 1 # default
      builder.at_least(5)
      builder.to_validator.matcher.expected.should == 5
    end
  end

  #
  # when setting a messages
  #

  describe '#message' do
    before(:each) do
      @builder = Luggage::DSL::ValidationBuilder.new.present
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
      @builder = Luggage::DSL::ValidationBuilder.new.present
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
      @builder = Luggage::DSL::ValidationBuilder.new.present
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
      @builder = Luggage::DSL::ValidationBuilder.new.present
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
        running = lambda { Luggage::DSL::ValidationBuilder.new.to_validator }
        running.should raise_exception(Luggage::IncompleteValidator)
      end
    end

    describe 'when a matcher is defined' do
      before(:all) do
        builder = Luggage::DSL::ValidationBuilder.new.author.name
        builder.equal_to(1)
        @validator = builder.to_validator
      end

      it 'should return a Luggage::Validator' do
        @validator.should be_a(Luggage::Validator)
      end

      it 'should set the matcher' do
        @validator.matcher.should be_a(Luggage::Matchers::Matcher)
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
