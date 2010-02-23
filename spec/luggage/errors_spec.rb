require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::Errors do
  subject { Luggage::Errors }

  it 'should be enumerable' do
    Luggage::Errors.ancestors.should include(Enumerable)
  end

  it { should have_public_method_defined(:each) }

  describe '#each' do
    it 'should yield each invalid attribute' do
      errors = Luggage::Errors.new
      errors.add(:one, 'Whoops')
      errors.add(:two, 'Whoops')

      attributes = errors.map { |attribute, _| attribute }
      attributes.should include(:one)
      attributes.should include(:two)
    end
  end

  #
  # add
  #

  describe '#add' do
    it 'should return the message which was set' do
      Luggage::Errors.new.add(:name, 'Whoops').should == 'Whoops'
    end
  end

  #
  # on
  #

  it { should have_public_method_defined(:on) }

  describe '#on' do

    describe 'when there is one error keyed on an attribute name' do
      before(:all) do
        @errors = Luggage::Errors.new
        @errors.add(:name, 'Name should not fail')
      end

      it 'should return nil when no error is present on the attribute' do
        @errors.on(:__invalid__).should be_nil
      end

      it 'return a string when an error is present on the attribute' do
        @errors.on(:name).should == ['Name should not fail']
      end
    end # when there is one error keyed on an attribute name

    describe 'when there is one error keyed on a single context' do
      before(:all) do
        @errors = Luggage::Errors.new
        @errors.add(Luggage::Context.new(:name), 'Name should not fail')
      end

      it 'should return nil when no error is present on the attribute' do
        @errors.on(:__invalid__).should be_nil
      end

      it 'return a string when an error is present on the attribute' do
        @errors.on(:name).should == ['Name should not fail']
      end
    end # when there is one error keyed on a single context

    describe 'when there is one error keyed on a context chain' do
      before(:all) do
        chain = Luggage::ContextChain.new
        chain.push(Luggage::Context.new(:name))
        chain.push(Luggage::Context.new(:length))

        @errors = Luggage::Errors.new
        @errors.add(chain, 'Name should not fail')
      end

      it 'should return nil when no error is present on the attribute' do
        @errors.on(:__invalid__).should be_nil
      end

      it 'return a string when an error is present on the attribute' do
        @errors.on(:name).should == ['Name should not fail']
      end
    end # when there is one error keyed on a context chain

  end # on
end
