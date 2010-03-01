@pending
Feature: Validating values which require an argument or block
  In order to allow a user to alter the validators for an object
  I want to be able to define validators to run only at certain times

  Scenario: Supplying an argument to a context
    Given a class like
      """
      def name(yes = false)
        if yes then "True" else "False" end
      end

      validate do |object|
        object.name(true).equal_to("True")
      end

      """
    Then the validations should pass

  Scenario: Supplying an argument to a context when using scenarios
    Given a class like
      """
      def name(yes = false)
        if yes then "True" else "False" end
      end

      validate do |object|
        object.name(true).equal_to("True")
        object.name(false).equal_to("False").scenario(:negative)
      end

      """
    Then the validations should pass in the 'negative' scenario

  Scenario: Supplying a block to a context
    Given a class like
      """
      def name(&block)
        block.call.reverse
      end

      validate do |object|
        object.name { "My value" }.equal_to("eulav yM")
      end

      """
    Then the validations should pass
