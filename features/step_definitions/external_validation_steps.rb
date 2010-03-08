#
# The steps in this file are used to test objects
# which don't include the Validation module.
#

def validator_set
  if @validator_set.nil?
    if @validator_set_definition.nil?
      raise 'No validator set defined'
    else
      @validator_set = Luggage::ValidatorSet.build do |object|
        eval(Array(@validator_set_definition).join("\n"))
      end
    end
  end

  @validator_set
end

Transform %r{^'(\w+)' scenario$} do |scenario|
  scenario.to_sym
end

Given %r{(?:using )?a validation set like} do |definition|
  @validator_set_definition = definition
end

Then %r{^the validation set should pass$} do
  validator_set.valid?(defined_object).should be_true
  validator_set.validate(defined_object).should be_pass
end

Then %r{^the validation set should fail$} do
  validator_set.valid?(defined_object).should be_false
  validator_set.validate(defined_object).should be_fail
end

Then %r{^the validation set should pass when using the ('\w+' scenario)$} do |scenario|
  validator_set.valid?(defined_object, scenario).should be_true
  validator_set.validate(defined_object, scenario).should be_pass
end

Then %r{^the validation set should fail when using the ('\w+' scenario)$} do |scenario|
  validator_set.valid?(defined_object, scenario).should be_false
  validator_set.validate(defined_object, scenario).should be_fail
end

Then %r{^there should be no validation errors$} do
  validator_set.validate(defined_object).errors.should be_empty
end

Then %r{^the error on '([^']+)' should be '([^']+)'$} do |attribute, msg|
  result = validator_set.validate(defined_object)

  if msg[0].chr == '/' and msg[-1].chr == '/'
    # Regexp.
    result.errors.on(attribute.to_sym).length.should == 1
    result.errors.on(attribute.to_sym).first.should =~ eval(msg)
  else
    # Exact string match.
    result.errors.on(attribute.to_sym).should == [msg]
  end
end
