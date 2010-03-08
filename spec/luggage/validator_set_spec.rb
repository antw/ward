require File.expand_path('../../spec_helper', __FILE__)

# @todo
#   Replace all cases of ValidatorSet.new with the DSL.

describe Luggage::ValidatorSet do
  subject { Luggage::ValidatorSet }

  #
  # .build
  #

  describe '.build' do
    describe 'when no initial set is provided' do
      it 'should add the validators to the set' do
        dsl = Luggage::ValidatorSet.build do |object|
          object.name.matches(/abc/)
          object.name.length.is.equal_to(3)
        end

        # ValidatorSet doesn't have a size method, but does implement Enumerable
        dsl.inject(0) { |c, *| c += 1 }.should == 2
      end
    end # when no initial set is provided

    describe 'when an initial set is provided' do
      before(:all) do
        @initial = Luggage::ValidatorSet.build do |object|
          object.name.matches(/abc/)
          object.name.length.is.equal_to(3)
        end

        @set = Luggage::ValidatorSet.build(@initial) do |object|
          object.name.present
        end
      end

      it 'should add the new validators to a copy of the initial set' do
        # ValidatorSet doesn't have a size method, but does implement Enumerable
        @set.inject(0) { |c, *| c += 1 }.should == 3
      end

      it 'should return a copy of the initial set' do
        @set.should_not == @initial
        @initial.inject(0) { |c, *| c += 1 }.should == 2
      end
    end # when an initial set is provided
  end # .build

  #
  # enumeration
  #

  it 'should be enumerable' do
    Luggage::ValidatorSet.ancestors.should include(Enumerable)
  end

  it { should have_public_method_defined(:each) }
  it { should have_public_method_defined(:to_a) }

  #
  # push
  #

  it { should have_public_method_defined(:push) }
  it { should have_public_method_defined(:<<) }

  describe '#push' do
    it 'should add validator to the set' do
      set = Luggage::ValidatorSet.new
      new_validator = Luggage::Validator.new(nil, nil)
      set.to_a.should be_empty
      set.push(new_validator)
      set.should include(new_validator)
    end
  end

  #
  # valid?
  #

  it { should have_public_method_defined(:valid?) }

  describe '#valid?' do
    describe 'with two validators, both of which pass' do
      it 'should return true' do
        set = Luggage::ValidatorSet.build do |object|
          object.length.is.equal_to(1)
          object.length.is.present
        end

        set.valid?('a').should be_true
      end
    end

    describe 'with two validators, both of which fail' do
      before(:each) do
        @set = Luggage::ValidatorSet.build do |object|
          object.length.is.equal_to(1)
          object.length.is.equal_to(2)
        end
      end

      it 'should return false' do
        @set.valid?('').should be_false
      end

      it 'should run all the validators' do
        @set.each do |validator|
          validator.should_receive(:validate).and_return([false])
        end

        lambda { @set.valid?('') }.should_not raise_exception
      end
    end

    describe 'with two validators, one of which fails' do
      before(:each) do
        @set = Luggage::ValidatorSet.build do |object|
          object.length.is.equal_to(1) # false
          object.length.is.equal_to(2) # true
        end
      end

      it 'should return false' do
        @set.valid?('ab').should be_false
      end

      it 'should run all the validators' do
        @set.to_a[0].should_receive(:validate).and_return([false])
        @set.to_a[1].should_receive(:validate).and_return([true])

        lambda { @set.valid?('ab') }.should_not raise_exception
      end
    end
  end # valid?

  #
  # merge!
  #

  it { should have_public_method_defined(:merge!) }

  describe '#merge!' do
    before(:each) do
      @set = Luggage::ValidatorSet.build do |object|
        object.length.is.equal_to(1)
      end
    end

    it 'should return self' do
      @set.merge!(Luggage::ValidatorSet.new).should == @set
    end

    it "should add the argument's validators to the receiver" do
      other = Luggage::ValidatorSet.new
      other << Luggage::Validator.new(nil, nil)
      running = lambda { @set.merge!(other) }

      # select is used here since ValidatorSet doesn't have a size method, but
      # does implement Enumerable.
      running.should change { @set.select { |*| true }.size }.by(1)
    end

    it 'should not merge validators already contained in the set' do
      pending do
        other = Luggage::ValidatorSet.new
        other << @set.to_a.first.dup
        running = lambda { @set.merge!(other) }

        # select is used here since ValidatorSet doesn't have a size method, but
        # does implement Enumerable.
        running.should_not change { @set.select { |*| true }.size }
      end
    end
  end

end
