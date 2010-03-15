Feature: Has matcher when initialized with an expected length
  In order allow the has matcher to read more like a natural language
  I want to be able to initialize the matcher with an expectation

  Background:
    Given a class with a 'posts' attribute

  Scenario: Initialized with an exact value and the correct member size
    When using a validation set like
      """
      object.has(2).posts

      """
    When the instance 'posts' attribute is '[1, 2]'
    Then the validation set should pass

  Scenario: Initialized with an exact value and an incorrect member size
    When using a validation set like
      """
      object.has(2).posts

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should fail

  Scenario Outline: Initialized with no value and a member size > 0
    When using a validation set like
      """
      object.has.posts

      """
    When the instance 'posts' attribute is '<posts>'
    Then the validation set should pass

    Examples:
      | posts  |
      | [1]    |
      | [1, 2] |

  Scenario: Initialized with no value and an incorrect member size
    When using a validation set like
      """
      object.has.posts

      """
    When the instance 'posts' attribute is '[]'
    Then the validation set should fail

  Scenario: Initialized with :no and the correct member size
    When using a validation set like
      """
      object.has(:no).posts

      """
    When the instance 'posts' attribute is '[]'
    Then the validation set should pass

  Scenario: Initialized with :no and an incorrect member size
    When using a validation set like
      """
      object.has(:no).posts

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should fail

  Scenario Outline: Initialized with a range and the correct member size
    When using a validation set like
      """
      object.has(2..3).posts

      """
    When the instance 'posts' attribute is '<posts>'
    Then the validation set should pass

    Examples:
      | posts     |
      | [1, 2]    |
      | [1, 2, 3] |

  Scenario Outline: Initialized with a range and an incorrect member size
    When using a validation set like
      """
      object.has(2..3).posts

      """
    When the instance 'posts' attribute is '<posts>'
    Then the validation set should fail

    Examples:
      | posts        |
      | []           |
      | [1]          |
      | [1, 2, 3, 4] |
