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

    it "should return an Acceptance matcher when calling #accepted" do
      @builder.accepted.should be_a(Luggage::Matchers::Acceptance)
    end

    it "should return a CloseTo matcher when calling #close_to" do
      @builder.close_to(1, 1).should be_a(Luggage::Matchers::CloseTo)
    end

    it "should return an EqualTo matcher when calling #equal_to" do
      @builder.equal_to(1).should be_a(Luggage::Matchers::EqualTo)
    end

    it "should return an Exclude matcher when calling #excluded_from" do
      @builder.excluded_from([]).should be_a(Luggage::Matchers::Exclude)
    end

    it "should return a Has matcher when calling #has" do
      @builder.has.should be_a(Luggage::Matchers::Has)
    end

    it "should return a Has matcher when calling #have" do
      @builder.have(1, 1).should be_a(Luggage::Matchers::Has)
    end

    it "should return an Include matcher when calling #included_in" do
      @builder.included_in([]).should be_a(Luggage::Matchers::Include)
    end

    it "should return a Match matcher when calling #matches" do
      @builder.matches(//).should be_a(Luggage::Matchers::Match)
    end

    it "should return a Match matcher when calling #match" do
      @builder.match(//).should be_a(Luggage::Matchers::Match)
    end

    it "should return a Nil matcher when calling #nil" do
      @builder.nil.should be_a(Luggage::Matchers::Nil)
    end

    it "should return a Present matcher when calling #present" do
      @builder.present.should be_a(Luggage::Matchers::Present)
    end

    it "should return an Satisfy matcher when calling #satisfies" do
      @builder.satisfies.should be_a(Luggage::Matchers::Satisfy)
    end

    it "should return an Satisfy matcher when calling #satisfy" do
      @builder.satisfy.should be_a(Luggage::Matchers::Satisfy)
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
