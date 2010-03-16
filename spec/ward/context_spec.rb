require File.expand_path('../../spec_helper', __FILE__)

describe Ward::Context do
  subject { Ward::Context }

  #
  # attribute
  #

  it { should have_public_method_defined(:attribute) }

  describe '#attribute' do
    subject do
      @attribute = Ward::Context.new('full_name').attribute
    end

    it { should be_a(Symbol) }
    it { should eql(:full_name) }
  end

  #
  # natural name
  #

  it { should have_public_method_defined(:natural_name) }

  describe '#natural_name' do
    subject do
      @attribute = Ward::Context.new('full_name').natural_name
    end

    it { should be_a(String) }
    it { should eql('full name') }
  end

  #
  # value
  #

  it { should have_public_method_defined(:value) }

  describe '#value' do
    before(:all) do
      @matcher = Ward::Context.new(:length)
    end

    it 'should retrieve the target value' do
      @matcher.value('abc').should == 3
    end

    it 'should raise an error when the target does not respond to the ' \
       'target method' do
      lambda { @matcher.value(nil) }.should raise_exception(NoMethodError)
    end
  end # value

end # Ward::Context
