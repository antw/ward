Feature: Validating objects in different scenarios
  In order to allow a user to alter the validators for an object
  I want to be able to define validators to run only at certain times

  Background:
    Given a class with a 'given_name' attribute
      And the class also has a 'family_name' attribute
    When validating the 'given_name' attribute
      And validating the 'family_name' attribute in the 'family' scenario

  #
  # With no explicit scenario when validating.
  #

  Scenario: Passing with no explicit scenario when all values are valid
    When the instance 'given_name' attribute is valid
    When the instance 'family_name' attribute is valid
    Then the validation set should pass

  Scenario: Passing with no explicit scenario when :family scenario values are invalid
    When the instance 'given_name' attribute is valid
    When the instance 'family_name' attribute is invalid
    Then the validation set should pass

  Scenario: Failing with no explicit scenario when all values are invalid
    When the instance 'given_name' attribute is invalid
    When the instance 'family_name' attribute is invalid
    Then the validation set should fail

  Scenario: Failing with no explicit scenario when :family scenario values are valid
    When the instance 'given_name' attribute is invalid
    When the instance 'family_name' attribute is valid
    Then the validation set should fail

  #
  # With an explicit :default scenario when validating.
  #

  Scenario: Passing when using the :default scenario when all values are valid
  When the instance 'given_name' attribute is valid
  When the instance 'family_name' attribute is valid
    Then the validation set should pass when using the 'default' scenario

  Scenario: Passing when using :default scenario when :family scenario values are invalid
  When the instance 'given_name' attribute is valid
  When the instance 'family_name' attribute is invalid
    Then the validation set should pass when using the 'default' scenario

  Scenario: Failing when using :default scenario when all values are invalid
    When the instance 'given_name' attribute is invalid
    When the instance 'family_name' attribute is invalid
    Then the validation set should fail when using the 'default' scenario

  Scenario: Failing when using :default scenario when :family scenario values are valid
    When the instance 'given_name' attribute is invalid
    When the instance 'family_name' attribute is valid
    Then the validation set should fail when using the 'default' scenario

  #
  # With an explicit :family scenario when validating.
  #

  Scenario: Passing when using :family scenario when all values are valid
  When the instance 'given_name' attribute is valid
  When the instance 'family_name' attribute is valid
    Then the validation set should pass when using the 'family' scenario

  Scenario: Passing when using :family scenario when :default scenario values are invalid
  When the instance 'given_name' attribute is invalid
  When the instance 'family_name' attribute is valid
    Then the validation set should pass when using the 'family' scenario

  Scenario: Failing when using :family scenario when all values are invalid
    When the instance 'given_name' attribute is invalid
    When the instance 'family_name' attribute is invalid
    Then the validation set should fail when using the 'family' scenario

  Scenario: Failing when using :family scenario when :default scenario values are valid
    When the instance 'given_name' attribute is valid
    When the instance 'family_name' attribute is invalid
    Then the validation set should fail when using the 'family' scenario
