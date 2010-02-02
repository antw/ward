require File.expand_path('../../spec_helper', __FILE__)

describe Luggage::ContextChain do

  #
  # contexts
  #

  it 'should respond to #to_a' do
    Luggage::ContextChain.new.should respond_to(:to_a)
  end

  #
  # push
  #

  it 'should respond to #push' do
    Luggage::ContextChain.new.should respond_to(:push)
  end

  it 'should respond to #<<' do
    Luggage::ContextChain.new.should respond_to(:<<)
  end

  describe '#push' do
    it 'should add a context to the end of the chain' do
      chain = Luggage::ContextChain.new
      new_context = Luggage::Context.new(:length)

      chain.contexts.should be_empty
      chain.push(new_context)
      chain.contexts.should eql([new_context])
    end
  end

  #
  # natural name
  #

  it 'should respond to #natural_name' do
    Luggage::ContextChain.new.should respond_to(:natural_name)
  end

  describe '#natural_name' do
    describe 'when the chain contains a single context' do
      before(:all) do
        @chain =  Luggage::ContextChain.new
        @chain << Luggage::Context.new(:length)
      end

      it 'should return the context natural name' do
        @chain.natural_name.should eql('Length')
      end
    end

    describe 'when the chain contains a two (or more) contexts' do
      before(:all) do
        @chain =  Luggage::ContextChain.new
        @chain << Luggage::Context.new(:post)
        @chain << Luggage::Context.new(:name)
      end

      it 'should join the natural names of each context' do
        @chain.natural_name.should eql('Post name')
      end
    end
  end

  #
  # value
  #

  it 'should respond to #value' do
    Luggage::ContextChain.new.should respond_to(:value)
  end

  describe '#value' do
    describe 'when the chain contains a single context' do
      before(:all) do
        @chain =  Luggage::ContextChain.new
        @chain << Luggage::Context.new(:length)
      end

      it 'should retrieve the value when set' do
        @chain.value('abc').should eql(3)
      end

      it 'should retrieve a nil value without an error' do
        @chain.value(Struct.new(:length).new(nil)).should be_nil
      end
    end # when the chain contains a single context

    describe 'when the chain contains two contexts' do
      before(:all) do
        @chain =  Luggage::ContextChain.new
        @chain << Luggage::Context.new(:post)
        @chain << Luggage::Context.new(:name)
      end

      it 'should retrieve the value when set' do
        target = Struct.new(:post).new(Struct.new(:name).new('Hello!'))
        @chain.value(target).should eql('Hello!')
      end

      it 'should raise an error if the first context value is nil' do
        lambda { @chain.value(nil) }.should raise_error
      end

      it 'should not raise an error if the second context value is nil' do
        target = Struct.new(:post).new(Struct.new(:name).new(nil))
        @chain.value(target).should be_nil
      end
    end # when the chain contains two contexts

    describe 'when the chain contains three (or more) contexts' do
      before(:all) do
        @chain =  Luggage::ContextChain.new
        @chain << Luggage::Context.new(:post)
        @chain << Luggage::Context.new(:name)
        @chain << Luggage::Context.new(:length)
      end

      it 'should retrieve the value when set' do
        target = Struct.new(:post).new(Struct.new(:name).new('abc'))
        @chain.value(target).should eql(3)
      end

      it 'should raise an error if the first context value is nil' do
        lambda { @chain.value(nil) }.should raise_error
      end

      it 'should raise an error if the second context value is nil' do
        target = Struct.new(:post).new(Struct.new(:name).new(nil))
        lambda { @chain.value(target) }.should raise_error
      end

      it 'should not raise an error if the second context value is nil' do
        target = Struct.new(:post).new(
          Struct.new(:name).new(Struct.new(:length).new(nil))
        )

        @chain.value(target).should be_nil
      end
    end # when the chain contains three (or more) contexts
  end # value

end
