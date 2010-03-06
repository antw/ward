Feature: Error messages when a validation fails
  In order to provide useful information when a validation fails
  I want to be able to retrieve a list of nicely worded error messages
  So that descriptive messages which describe the errors can be displayed

  Background:
    Given a class with a 'name' attribute

  Scenario: When validating an attribute of the object
    When using a validation set like
      """
      object.name.is.present

      """
    When the instance 'name' attribute is ''
    Then the error on 'name' should be 'Name should be present'

  Scenario: When validating the object itself
    When using a validation set like
      """
      object.is_not.present

      """
    Then the error on 'base' should be 'Should not be present'

  Scenario: Interpolating extra values from the matcher
    When using a validation set like
      """
      object.name.has(1).character

      """
    When the instance 'name' attribute is ''
    Then the error on 'name' should be 'Name should have 1 character'

  Scenario: When the matcher indicates a specific error key
    When using a validation set like
      """
      object.name.has.between(1..5).characters

      """
    When the instance 'name' attribute is ''
    Then the error on 'name' should be 'Name should have between 1 and 5 characters'

  Scenario: Providing a custom error when the validation is defined
    When using a validation set like
      """
      object.name.is.present.message('Whoops!')

      """
    When the instance 'name' attribute is ''
    Then the error on 'name' should be 'Whoops!'

  Scenario: Providing a custom error with interpolation
    When using a validation set like
      """
      object.name.is.present.message('%{context} had a whoopsie')

      """
    When the instance 'name' attribute is ''
    Then the error on 'name' should be 'Name had a whoopsie'
