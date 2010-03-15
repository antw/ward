Feature: Validating values which require an argument or block

  Scenario: Supplying an argument to a context
    Given the class has behaviour like
      """
      def name(yes = false)
        if yes then "True" else "False" end
      end

      """
    And using a validation set like
      """
      object.name(true).equal_to("True")

      """
    Then the validation set should pass

  Scenario: Supplying an argument to a context when using scenarios
    Given the class has behaviour like
      """
      def name(yes = false)
        if yes then "True" else "False" end
      end

      """
    And using a validation set like
      """
      object.name(true).equal_to("True")
      object.name(false).equal_to("False").scenario(:negative)

      """
    Then the validation set should pass when using the 'negative' scenario

  Scenario: Supplying a block to a context
    Given the class has behaviour like
      """
      def name(&block)
        block.call.reverse
      end

      """
    And using a validation set like
      """
      object.name { "My value" }.equal_to("eulav yM")

      """
    Then the validation set should pass
