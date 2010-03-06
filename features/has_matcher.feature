Feature: Has matcher
  In order to validate the length of a collection
  I want to be able to ensure collections have a certain number of members

  Background:
    Given a class with a 'posts' attribute

  Scenario: When validating with a collection name and the correct member size
    When using a validation set like
      """
      object.has(2).posts

      """
    When the instance 'posts' attribute is '[1, 2]'
    Then the validation set should pass

  Scenario: When validating with a collection name and an incorrect member size
    When using a validation set like
      """
      object.has(2).posts

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should fail
      And the error on 'base' should be 'Should have 2 posts'

  Scenario: When validating without a collection name and the correct member size
    When using a validation set like
      """
      object.posts.has(2)

      """
    When the instance 'posts' attribute is '[1, 2]'
    Then the validation set should pass

  Scenario: When validating without a collection name and an incorrect member size
    When using a validation set like
      """
      object.posts.has(2)

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should fail
      And the error on 'posts' should be 'Posts should have 2 items'

  Scenario: When validating without a non-responding collection name and the correct member size
    When using a validation set like
      """
      object.posts.has(2).members

      """
    When the instance 'posts' attribute is '[1, 2]'
    Then the validation set should pass

  Scenario: When validating without a non-responding collection name and an incorrect member size
    When using a validation set like
      """
      object.posts.has(2).members

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should fail
      And the error on 'posts' should be 'Posts should have 2 members'

  @pending
  Scenario: When using a singular collection name and the value responds to the plural
    When using a validation set like
      """
      object.has(1).post

      """
    When the instance 'posts' attribute is '[1]'
    Then the validation set should pass
