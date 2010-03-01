#
# Generic Validators =========================================================
#
# These steps allow us to write less specific scenarios which simply state
# that an attribute should or should not be valid, without having to worry
# what a valid or invalid value actually is.
#
# They are used in conjunction with the "the instance '<attribute>' attribute
# is (in)?valid" steps.
#
# We accomplish this by testing that an attribute is equal to the string
# "valid" -- any other value causes a failure.
#

When %r{^validating the ('\w+' attribute)$} do |attribute|
  @validator_set_definition ||= []
  @validator_set_definition << "object.#{attribute}.equal_to('valid')"
end

When %r{^validating the ('\w+' attribute) in the ('\w+' scenario)$} do |attribute, scenario|
  @validator_set_definition ||= []
  @validator_set_definition <<
    "object.#{attribute}.equal_to('valid').scenario(:#{scenario})"
end

Given %r{^the instance ('\w+' attribute) is valid$} do |attribute|
  When %{the instance '#{attribute}' attribute is '"valid"'}
end

Given %r{^the instance ('\w+' attribute) is invalid$} do |attribute|
  When %{the instance '#{attribute}' attribute is '"invalid"'}
end

