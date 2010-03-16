#
# The steps in this file are used to build classes and
# objects which are later validated.
#

def object_builder
  # Returns the ObjectBuilder instance for the current feature.
  @object_builder ||= Ward::Spec::ObjectBuilder.new
end

def defined_object
  # Create an oject with the named attributes and values.
  object_builder.to_instance
end

Transform %r{^'(\w+[!\?]?)' attribute$} do |attribute|
  attribute.to_sym
end

Given %r{^a class with an? ('\w+[!\?]?' attribute)$} do |attribute|
  Given "the class also has a '#{attribute}' attribute"
end

Given %r{^the class also has an? ('\w+[!\?]?' attribute)$} do |attribute|
  object_builder.attributes << attribute
end

Given %r{^the instance ('\w+[!\?]?' attribute) is '(.*)'$} do |attribute, value|
  unless object_builder.attributes.include?(attribute)
    raise "The #{attribute.inspect} attribute was not defined"
  end

  value = "''" if value =~ /^\s*$/ # Empty string.

  # Attempt to evaluate the value. If the evaluation fails we assume that it
  # is a string which should be used literally.
  object_builder.values[attribute] =
    begin eval(value) ; rescue NameError ; value ; end
end

Given %r{^the class has behaviour like$} do |behaviour|
  object_builder.behaviours << behaviour
end
