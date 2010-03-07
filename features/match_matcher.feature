Feature: Match matcher
  In order to ensure that a attribute conforms to a certain format
  I want be able to validate attributes against a regular expression

  Background:
    Given a class with a 'name' attribute

  Scenario Outline: When the expected value is a regexp and the actual value matches
    When using a validation set like
      """
      object.name.matches(/Michael/)

      """
    And the instance 'name' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value         |
      | Michael       |
      | Michael Scarn |

  Scenario: When the expected value is a regexp and the actual value does not match
    When using a validation set like
      """
      object.name.matches(/Michael/)

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should fail
      And the error on 'name' should be 'Name format was invalid'

  Scenario: When the expected value is a String and the actual value matches
    When using a validation set like
      """
      object.name.matches('Michael')

      """
    And the instance 'name' attribute is 'Michael'
    Then the validation set should pass

  Scenario: When the expected value is a String and the actual value does not match
    When using a validation set like
      """
      object.name.matches('Michael')

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should fail
      And the error on 'name' should be 'Name format was invalid'
