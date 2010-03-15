Feature: Validating objects with an "attribute" keyword
  In order validate attributes whose name conflicts with DSL methods
  I want to be able to use the attribute keyword

  Scenario: With no arguments, a matcher, and a valid value
    Given a class with a 'message' attribute
    When using a validation set like
      """
      object.attribute(:message).is.equal_to('Wow! Signal')

      """
    And the instance 'message' attribute is 'Wow! Signal'
    Then the validation set should pass
