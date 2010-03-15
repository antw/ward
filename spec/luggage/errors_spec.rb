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

  # Class methods ============================================================

  describe '.message' do
    it 'should return the message specified' do
      message = Luggage::Errors.message('has.eql.positive')
      message.should == '%{context} should have %{expected} %{collection}'
    end

    it 'should return the first matching message key' do
      message = Luggage::Errors.message(
        'does.not.exist', 'has.eql.negative', 'has.eql.positive')

      message.should == '%{context} should not have %{expected} %{collection}'
    end

    it 'should return nil when no matching message is found' do
      Luggage::Errors.message('does.not.exist').should be_nil
    end
  end

  describe '.format_exclusive_list' do
    it 'should return an empty string when given an empty Array' do
      Luggage::Errors.format_exclusive_list([]).should == ''
    end

    it 'should return "1" when given [1]' do
      Luggage::Errors.format_exclusive_list([1]).should == '1'
    end

    it 'should return "1 or 2" when given [1, 2]' do
      Luggage::Errors.format_exclusive_list([1, 2]).should == '1 or 2'
    end

    it 'should return "1, 2, or 3" when given [1, 2, 3]' do
      Luggage::Errors.format_exclusive_list([1, 2, 3]).should == '1, 2, or 3'
    end
  end

  describe '.format_inclusive_list' do
    it 'should return an empty string when given an empty Array' do
      Luggage::Errors.format_inclusive_list([]).should == ''
    end

    it 'should return "1" when given [1]' do
      Luggage::Errors.format_inclusive_list([1]).should == '1'
    end

    it 'should return "1 or 2" when given [1, 2]' do
      Luggage::Errors.format_inclusive_list([1, 2]).should == '1 and 2'
    end

    it 'should return "1, 2, or 3" when given [1, 2, 3]' do
      Luggage::Errors.format_inclusive_list([1, 2, 3]).should == '1, 2, and 3'
    end
  end

end
