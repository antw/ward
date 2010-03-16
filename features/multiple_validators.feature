Feature: Objects which have multiple validators in the same scenario
  In order to allow users to thoroughly test their objects
  I want be able to have multiple validators in the same scenario

  Background:
    Given a class with a 'name' attribute
      And the class also has a 'job' attribute
    When validating the 'name' attribute
      And validating the 'job' attribute

  Scenario: When all attributes are valid
    When the instance 'name' attribute is valid
      And  the instance 'job' attribute is valid
    Then the validation set should pass
      And there should be no validation errors

  Scenario: When one attribute is invalid
    When the instance 'name' attribute is invalid
      And the instance 'job' attribute is valid
    Then the validation set should fail
      And there should be 1 validation error on 'name'
      And there should be no validation errors on 'job'

  Scenario: When both attributes are invalid
    When the instance 'name' attribute is invalid
      And the instance 'job' attribute is invalid
    Then the validation set should fail
      And there should be 1 validation error on 'name'
      And there should be 1 validation error on 'job'
