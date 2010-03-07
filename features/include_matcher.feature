Feature: Include matcher
  In order to validate that a value is one of several permitted
  I want to be able to use the include matcher to set the permitted values

  # +one_of+ is also available as +included_in+

  Background:
    Given a class with a 'level' attribute
    And using a validation set like
      """
      object.level.is.one_of([60, 70, 80])

      """

  Scenario Outline: When the attribute value matches the expected value
    When the instance 'level' attribute is '<level>'
    Then the validation set should pass

    Examples:
      | level |
      | 60    |
      | 70    |
      | 80    |

  Scenario: When the attribute value does not match the expected value
    When the instance 'level' attribute is '61'
    Then the validation set should fail
      And the error on 'level' should be 'Level should be 60, 70, or 80'
