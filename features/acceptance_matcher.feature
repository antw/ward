Feature: Acceptance matcher
  In order to validate that a user has accepted an attribute
  I want to be able to ensure collections have a certain number of members

  Background:
    Given a class with a 'terms' attribute

  Scenario Outline: When the attribute value is accepted
    When using a validation set like
      """
      object.terms.is.accepted

      """
    And the instance 'terms' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value  |
      | true   |
      | "true" |
      | "t"    |
      | "yes"  |
      | "y"    |
      | 1      |
      | "1"    |

  Scenario Outline: When the attribute value is not accepted
    When using a validation set like
      """
      object.terms.is.accepted

      """
    And the instance 'terms' attribute is '<value>'
    Then the validation set should fail

    Examples:
      | value   |
      | false   |
      | nil     |
      | ""      |
      | "false" |
      | "f"     |
      | "no"    |
      | "n"     |
      | 0       |
      | "0"     |

  Scenario: When setting a single custom expectation value
    When using a validation set like
      """
      object.terms.is.accepted("absolutely")

      """
    And the instance 'terms' attribute is 'absolutely'
    Then the validation set should pass

  Scenario: When setting a single custom expectation value and the attribute is not accepted
    When using a validation set like
      """
      object.terms.is.accepted("absolutely")

      """
    And the instance 'terms' attribute is 'yes'
    Then the validation set should fail

  Scenario Outline: When setting several custom expectation values
    When using a validation set like
      """
      object.terms.is.accepted(%w( absolutely certainly ))

      """
    And the instance 'terms' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value      |
      | absolutely |
      | certainly  |
