Feature: Has matcher relativities
  In order something

  Background:
    Given a class with a 'name' attribute

  #
  # 'exactly' is aliased as 'eql' and can also be omitted completely. See
  # has_matcher_with_initialized_expectation feature for examples.
  #

  Scenario: Passing validation with exactly
    When using a validation set like
      """
      object.name.has.exactly(5).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with exactly
    When using a validation set like
      """
      object.name.has.exactly(5).characters

      """
    When the instance 'name' attribute is ''
    Then the validation set should fail
      And the error on 'name' should be 'Name should have 5 characters'

  #
  # 'fewer_than' is aliased as 'lt' and 'less_than'
  #

  Scenario: Passing validation with lte
    When using a validation set like
      """
      object.name.has.fewer_than(6).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with lte
    When using a validation set like
      """
      object.name.has.fewer_than(6).characters

      """
    When the instance 'name' attribute is 'abcdef'
    Then the validation set should fail
      And the error on 'name' should be 'Name should have at most 5 characters'

  #
  # 'at_most' is aliased as 'lte'
  #

  Scenario: Passing validation with lte
    When using a validation set like
      """
      object.name.has.at_most(5).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with lte
    When using a validation set like
      """
      object.name.has.at_most(5).characters

      """
    When the instance 'name' attribute is 'abcdef'
    Then the validation set should fail
      And the error on 'name' should be 'Name should have at most 5 characters'

  #
  # 'at_least' is aliased as 'gte'
  #

  Scenario: Passing validation with gte
    When using a validation set like
      """
      object.name.has.at_least(5).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with gte
    When using a validation set like
      """
      object.name.has.at_least(5).characters

      """
    When the instance 'name' attribute is ''
    Then the validation set should fail
      And the error on 'name' should be 'Name should have at least 5 characters'

  #
  # 'greater_than' is aliased as 'gt' and 'more_than'
  #

  Scenario: Passing validation with gte
    When using a validation set like
      """
      object.name.has.greater_than(4).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with gte
    When using a validation set like
      """
      object.name.has.greater_than(4).characters

      """
    When the instance 'name' attribute is 'abcd'
    Then the validation set should fail
      And the error on 'name' should be 'Name should have at least 5 characters'

  #
  # between
  #

  Scenario: Passing validation with between and a range
    When using a validation set like
      """
      object.name.has.between(2..5).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with between two values and a range
    When using a validation set like
      """
      object.name.has.between(2..5).characters

      """
    When the instance 'name' attribute is ''
    Then the validation set should fail
      And the error on 'name' should be 'Name should have between 2 and 5 characters'

  Scenario: Passing validation with between and two values
    When using a validation set like
      """
      object.name.has.between(2, 5).characters

      """
    When the instance 'name' attribute is 'Dwigt'
    Then the validation set should pass
      And there should be no validation errors

  Scenario: Failing validation with between and two values
    When using a validation set like
      """
      object.name.has.between(2, 5).characters

      """
    When the instance 'name' attribute is ''
    Then the validation set should fail
      And the error on 'name' should be 'Name should have between 2 and 5 characters'
