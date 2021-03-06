require File.expand_path('../../spec_helper', __FILE__)

describe Ward::ContextChain do
  subject { Ward::ContextChain }

  #
  # attribute
  #

  it { should have_public_method_defined(:attribute) }

  describe '#attribute' do
    before(:all) do
      @chain = Ward::ContextChain.new
      @chain.push(Ward::Context.new(:name))
      @chain.push(Ward::Context.new(:length))
    end

    it 'should return a symbol' do
      @chain.attribute.should be_a(Symbol)
    end

    it "should return the first Context's attribute" do
      @chain.attribute.should == :name
    end

    it 'should return :base when there are no contexts contained' do
      Ward::ContextChain.new.attribute.should == :base
    end
  end

  #
  # to_a
  #

  it { should have_public_method_defined(:to_a) }

  #
  # push
  #

  it { should have_public_method_defined(:push) }
  it { should have_public_method_defined(:<<) }

  describe '#push' do
    it 'should add a context to the end of the chain' do
      chain = Ward::ContextChain.new
      new_context = Ward::Context.new(:length)
      chain.to_a.should be_empty
      chain.push(new_context)
      chain.to_a.should eql([new_context])
    end
  end

  #
  # natural name
  #

  it { should have_public_method_defined(:natural_name) }

  describe '#natural_name' do
    describe 'when the chain contains no contexts' do
      it 'should return a blank string' do
        Ward::ContextChain.new.natural_name.should eql('')
      end
    end

    describe 'when the chain contains a single context' do
      before(:all) do
        @chain =  Ward::ContextChain.new
        @chain << Ward::Context.new(:length)
      end

      it 'should return the context natural name' do
        @chain.natural_name.should eql('length')
      end
    end

    describe 'when the chain contains a two (or more) contexts' do
      before(:all) do
        @chain =  Ward::ContextChain.new
        @chain << Ward::Context.new(:post)
        @chain << Ward::Context.new(:name)
      end

      it 'should join the natural names of each context' do
        @chain.natural_name.should eql('post name')
      end
    end
  end

  #
  # value
  #

  it { should have_public_method_defined(:value) }

  describe '#value' do
    describe 'when the chain contains no context' do
      before(:all) do
        @chain = Ward::ContextChain.new
      end

      it 'should return the given object' do
        @chain.value('this').should == 'this'
      end
    end

    describe 'when the chain contains a single context' do
      before(:all) do
        @chain =  Ward::ContextChain.new
        @chain << Ward::Context.new(:length)
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
        @chain =  Ward::ContextChain.new
        @chain << Ward::Context.new(:post)
        @chain << Ward::Context.new(:name)
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
        @chain =  Ward::ContextChain.new
        @chain << Ward::Context.new(:post)
        @chain << Ward::Context.new(:name)
        @chain << Ward::Context.new(:length)
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
