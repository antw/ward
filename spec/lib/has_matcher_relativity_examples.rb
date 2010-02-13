share_examples_for 'Has matcher relativity method' do
  before(:all) do
    @expectation ||= [5]
    @matcher = Luggage::Matchers::Has.new
    @return = @matcher.__send__(@method, *@expectation)
  end

  it 'should return the matcher' do
    @return.should == @matcher
  end

  it "should set the matcher relativity" do
    @matcher.relativity.should == @relativity
  end
end
