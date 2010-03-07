Feature: Present matcher
  In order to validate that an attribute has a value
  I want to be able to use the present matcher

  Background:
    Given a class with a 'charisma' attribute
    And using a validation set like
      """
      object.charisma.is.present

      """

  Scenario: When the attribute value is nil
    When the instance 'charisma' attribute is 'nil'
    Then the validation set should fail

  Scenario: When the attribute value is true
    When the instance 'charisma' attribute is 'true'
    Then the validation set should pass

  Scenario: When the attribute value is false
    When the instance 'charisma' attribute is 'false'
    Then the validation set should fail

  Scenario: When the attribute value is a Symbol
    When the instance 'charisma' attribute is ':yes'
    Then the validation set should pass

  Scenario: When the attribute value is a zero
    When the instance 'charisma' attribute is '0'
    Then the validation set should pass

  Scenario: When the attribute value is a positive number
    When the instance 'charisma' attribute is '1'
    Then the validation set should pass

  Scenario: When the attribute value is a negative number
    When the instance 'charisma' attribute is '-1'
    Then the validation set should pass

  Scenario: When the attribute value is a non-empty string
    When the instance 'charisma' attribute is 'Amazing'
    Then the validation set should pass

  Scenario: When the attribute value is a whitespace-only string
    When the instance 'charisma' attribute is '" \t\r\n"'
    Then the validation set should fail

  Scenario: When the attribute value is an empty string
    When the instance 'charisma' attribute is ''
    Then the validation set should fail

  Scenario: When the attribute value responds to #empty and is not empty
    When the instance 'charisma' attribute is '[1]'
    Then the validation set should pass

  Scenario: When the attribute value responds to #empty and is empty
    When the instance 'charisma' attribute is '[]'
    Then the validation set should fail
