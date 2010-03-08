Feature: Satisfy matcher
  In order run arbitrary validations on the object
  I want to be able validate that an attribute satisfies a given expression

  Background:
    Given a class with a 'name' attribute

  Scenario: Matching with just the attribute value
    When using a validation set like
      """
      object.name.satisfies { |name| name.reverse == 'nracS leahciM' }
      # better: object.name.reverse.is('nracS leahciM')

      """
    And the instance 'name' attribute is 'Michael Scarn'
    Then the validation set should pass

  Scenario: Negatively matching with just the attribute value
    When using a validation set like
      """
      object.name.does_not.satisfy { |name| name.reverse == 'nracS leahciM' }

      """
    And the instance 'name' attribute is 'Michael Scott'
    Then the validation set should pass

  Scenario: Failing to match with just the attribute value
    When using a validation set like
      """
      object.name.satisfies { |name| name.reverse == 'nracS leahciM' }

      """
    And the instance 'name' attribute is 'Michael Scott'
    Then the validation set should fail
      And the error on 'name' should be 'Name is invalid'

  Scenario: Failing to match and returning a specific error message
    When using a validation set like
      """
      object.name.satisfies do |name|
        [false, "An error"]
      end

      """
    Then the validation set should fail
      And the error on 'name' should be 'An error'

  Scenario: Matching with the attribute value and record
    When using a validation set like
      """
      object.name.satisfies do |name, record|
        record.name.reverse == 'nracS leahciM'
      end

      """
    And the instance 'name' attribute is 'Michael Scarn'
    Then the validation set should pass

  Scenario: Failing to match with the attribute value and record
    When using a validation set like
      """
      object.name.satisfies do |name, record|
        record.name.reverse == 'nracS leahciM'
      end

      """
    And the instance 'name' attribute is 'Dwigt'
    Then the validation set should fail
      And the error on 'name' should be 'Name is invalid'
