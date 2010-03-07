Feature: EqualTo matcher
  In order to validate that an exact value
  I want to be able to use the equal_to matcher to set the expected value

  #
  # The equal_to keyword can often be removed in favour of using +is+ with a
  # value. See is_keyword.feature for examples.
  #

  Background:
    Given a class with an 'name' attribute
    And using a validation set like
      """
      object.name.is.equal_to('Michael Scarn')

      """

  Scenario: When the attribute value matches the expected value
    When the instance 'name' attribute is 'Michael Scarn'
    Then the validation set should pass

  Scenario: When the attribute value does not match the expected value
    When the instance 'name' attribute is 'Michael Scott'
    Then the validation set should fail
      And the error on 'name' should be 'Name should be Michael Scarn'
