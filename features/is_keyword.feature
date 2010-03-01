@pending
Feature: Validating objects with an "is" keyword
  In order provide a more natural DSL
  I want to be able to use the is keyword

  Background:
    Given a class with a 'name' attribute

  Scenario: With no arguments, a matcher, and a valid value
    When using a validation set like
      """
      object.name.is.equal_to('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Samuel L. Chang'
    Then the validation set should pass

  Scenario: With no arguments, a matcher, and an invalid value
    When using a validation set like
      """
      object.name.is.equal_to('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should fail

  Scenario: With an argument and a valid value
    When using a validation set like
      """
      object.name.is('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Samuel L. Chang'
    Then the validation set should pass

  Scenario: With an argument and an invalid value
    When using a validation set like
      """
      object.name.is('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should fail
