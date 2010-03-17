Feature: Method matcher
  In order to validate the return value of a method
  I want to be able to use the Matcher matcher

  Background:
    Given a class with an 'a_method' attribute
    And using a validation set like
      """
      object.a_method.is.valid

      """

  Scenario: When the method returns true
    When the instance 'a_method' attribute is 'true'
    Then the validation set should pass

  Scenario: When the method returns a true-like value
    When the instance 'a_method' attribute is 'A string'
    Then the validation set should pass

  Scenario: When the method returns false
    When the instance 'a_method' attribute is 'false'
    Then the validation set should fail
      And the error on 'a_method' should be 'A method is invalid'

  Scenario: When the method returns nil
    When the instance 'a_method' attribute is 'nil'
    Then the validation set should fail
      And the error on 'a_method' should be 'A method is invalid'

  Scenario: When the method returns an array whose first member is false
    When the instance 'a_method' attribute is '[false, "Error message"]'
    Then the validation set should fail
      And the error on 'a_method' should be 'Error message'
