#
# The steps in this file are used to build classes and
# objects which are later validated.
#

def defined_object
  # Create an oject with the named attributes and values.
  Luggage::Spec::Struct.new(*@class_attributes).new(
    *@class_attributes.map { |attribute| @instance_attributes[attribute] })
end

Transform %r{^'(\w+)' attribute$} do |attribute|
  attribute.to_sym
end

Given %r{^a class with a ('\w+' attribute)$} do |attribute|
  @class_attributes, @instance_attributes = [], {}
  Given "the class also has a '#{attribute}' attribute"
end

Given %r{^the class also has a ('\w+' attribute)$} do |attribute|
  @class_attributes << attribute
end

Given %r{^the instance ('\w+' attribute) is '(.*)'$} do |attribute, value|
  unless @class_attributes.include?(attribute)
    raise "The #{attribute.inspect} attribute was not defined"
  end

  value = "''" if value =~ /^\s*$/ # Empty string.

  # Attempt to evaluate the value. If the evaluation fails we assume that it
  # is a string which should be used literally.
  @instance_attributes[attribute] =
    begin eval(value) ; rescue NameError ; value ; end
end
