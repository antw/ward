Feature: CloseTo matcher
  In order to validate values which may vary slightly at runtime
  I want to be able to use the close_to matcher to set an acceptable range of values

  Background:
    Given a class with an 'estimate' attribute

  Scenario Outline: When the attribute value is within the specified integer delta
    When using a validation set like
      """
      object.estimate.is.close_to(50, 10)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value |
      | 40    |
      | 50    |
      | 55.0  |
      | 60    |

  Scenario Outline: When the attribute value is outside the specified integer delta
    When using a validation set like
      """
      object.estimate.is.close_to(50, 10)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should fail
      And the error on 'estimate' should be 'Estimate should be within 10 of 50'

    Examples:
      | value |
      | 0     |
      | 39    |
      | 61    |

  Scenario Outline: When the attribute value is within the specified float delta
    When using a validation set like
      """
      object.estimate.is.close_to(2, 0.5)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value |
      | 1.5   |
      | 2     |
      | 2.0   |
      | 2.5   |

  Scenario Outline: When the attribute value is outside the specified float delta
    When using a validation set like
      """
      object.estimate.is.close_to(2, 0.5)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should fail
      And the error on 'estimate' should be 'Estimate should be within 0.5 of 2'

    Examples:
      | value |
      | 0     |
      | 1.49  |
      | 2.51  |

  Scenario Outline: When the attribute value is a date inside the delta
    When using a validation set like
      """
      object.estimate.is.close_to(Date.civil(2010, 3, 1), 1)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should pass

    Examples:
      | value |
      | Date.civil(2010, 3, 1) - 1 |
      | Date.civil(2010, 3, 1)     |
      | Date.civil(2010, 3, 1) + 1 |

  Scenario Outline: When the attribute value is a date outside the delta
    When using a validation set like
      """
      object.estimate.is.close_to(Date.civil(2010, 3, 1), 1)

      """
    And the instance 'estimate' attribute is '<value>'
    Then the validation set should fail
      And the error on 'estimate' should be 'Estimate should be within 1 of 2010-03-01'

    Examples:
      | value |
      | Date.civil(2010, 3, 1) - 2 |
      | Date.civil(2010, 3, 1) + 2 |

    Scenario Outline: When the attribute value is a date inside the delta
      When using a validation set like
        """
        object.estimate.is.close_to(Time.parse('2010-03-01 12:00'), 30)

        """
      And the instance 'estimate' attribute is '<value>'
      Then the validation set should pass

      Examples:
        | value |
        | Time.parse('2010-03-01 12:00') - 30 |
        | Time.parse('2010-03-01 12:00')      |
        | Time.parse('2010-03-01 12:00') + 30 |

    Scenario Outline: When the attribute value is a date outside the delta
      When using a validation set like
        """
        object.estimate.is.close_to(Time.parse('2010-03-01 12:00'), 30)

        """
      And the instance 'estimate' attribute is '<value>'
      Then the validation set should fail
        And the error on 'estimate' should be '/^Estimate should be within 30 of/'

      Examples:
        | value |
        | Time.parse('2010-03-01 12:00') - 31 |
        | Time.parse('2010-03-01 12:00') + 31 |
