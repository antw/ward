Feature: Nil matcher
  In order to validate that an attribute is nil
  I want to be able to use the nil matcher

  Background:
    Given a class with a 'storage' attribute
    And using a validation set like
      """
      object.storage.is.nil

      """

  Scenario: When the attribute value is nil
    When the instance 'storage' attribute is 'nil'
    Then the validation set should pass

  Scenario: When the attribute value is not nil
    When the instance 'storage' attribute is '500'
    Then the validation set should fail
      And the error on 'storage' should be 'Storage should be nil'

  Scenario: When the attribute value is false
    When the instance 'storage' attribute is 'false'
    Then the validation set should fail
      And the error on 'storage' should be 'Storage should be nil'
