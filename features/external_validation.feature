Feature: Validating objects without "include"ing any modules
  In order to reduce the impact on a user's environment
  I want to be able to validate an object which knows nothing about Luggage

  Background:
    Given a class with a 'name' attribute
    When validating the 'name' attribute

  Scenario: Passing validation
    When the instance 'name' attribute is valid
    Then the validation set should pass

  Scenario: Failing validation
    When the instance 'name' attribute is invalid
    Then the validation set should fail
