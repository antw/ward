@pending
Feature: Validating objects with an "is_not" or "does_not" keyword
  In order to give users greater control over their validators
  I want be able to use the is_not and does_not keyword to negate what follows

  Background:
    Given a class with a 'name' attribute

  Scenario Outline: With no arguments, a matcher, and a valid value
    When using a validation set like
      """
      object.name.<keyword>.equal_to('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Samuel L. Chang'
    Then the validation set should fail

    Examples:
      | keyword  |
      | is_not   |
      | does_not |

  Scenario Outline: With no arguments, a matcher, and an invalid value
    When using a validation set like
      """
      object.name.<keyword>.equal_to('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass

    Examples:
      | keyword  |
      | is_not   |
      | does_not |

  Scenario Outline: With an argument and a valid value
    When using a validation set like
      """
      object.name.<keyword>('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Samuel L. Chang'
    Then the validation set should fail

    Examples:
      | keyword  |
      | is_not   |
      | does_not |

  Scenario Outline: With an argument and an invalid value
    When using a validation set like
      """
      object.name.<keyword>('Samuel L. Chang')

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass

    Examples:
      | keyword  |
      | is_not   |
      | does_not |
