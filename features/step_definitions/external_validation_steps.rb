#
# The steps in this file are used to test objects
# which don't include the Validation module.
#

def validator_set
  if @validator_set.nil?
    unless @validator_set_definition.nil?
      # We're using "implicit validators" (see below). Build the set.
      @validator_set = Luggage::DSL::ValidationBlock.build do |object|
        eval(@validator_set_definition.join("\n"))
      end
    else
      raise 'No validator set defined'
    end
  end

  @validator_set
end

Transform %r{^'(\w+)' scenario$} do |scenario|
  scenario.to_sym
end

Given %r{(?:using )?a validation set like} do |definition|
  @validator_set = Luggage::DSL::ValidationBlock.build do |object|
    eval(definition)
  end
end

Then %r{^the validation set should pass$} do
  validator_set.valid?(defined_object).should be_true
end

Then %r{^the validation set should fail$} do
  validator_set.valid?(defined_object).should be_false
end

Then %r{^the validation set should pass when using the ('\w+' scenario)$} do |scenario|
  validator_set.valid?(defined_object, scenario).should be_true
end

Then %r{^the validation set should fail when using the ('\w+' scenario)$} do |scenario|
  validator_set.valid?(defined_object, scenario).should be_false
end
