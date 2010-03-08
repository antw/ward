Feature: Predicate matcher
  In order to validate objects with predicate methods
  I want to be able to seem to call the predicate in the validation block

  Background:
    Given a class with a 'important?' attribute
    And using a validation set like
      """
      object.is.important?

      """

  Scenario: When the attribute value is true
    When the instance 'important?' attribute is 'true'
    Then the validation set should pass

  Scenario: When the attribute value is nil
    When the instance 'important?' attribute is 'nil'
    Then the validation set should fail

  Scenario: When the attribute value is false
    When the instance 'important?' attribute is 'false'
    Then the validation set should fail
