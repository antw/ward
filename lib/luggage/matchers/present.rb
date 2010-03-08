module Luggage
  module Matchers
    # Tests whether the validation value is present.
    #
    # A "present" value is one which:
    #
    #   * is a non-blank string, containing more than just whitespace
    #   * responds to #empty? and returns false
    #   * does not evaluate to false (i.e. not nil or false)
    #
    # This is equivalent to ActiveSupport's +blank?+ extension methods but
    # note that +blank?+ is not actually used; if you define +blank?+ on a
    # class which is provided to the matcher it will not be called.
    #
    # @todo
    #   Once the predicate matcher is available, amend the class documentation
    #   to provide an example of how to call +blank?+ explicitly.
    #
    # @example Validating that the name attribute is present
    #
    #   class Person
    #     validate do |person|
    #       person.name.is.present
    #     end
    #   end
    #
    # @example Validating that the job attribute is not present :(
    #
    #   class Person
    #     validate do |person|
    #       person.job.is_not.present
    #     end
    #   end
    #
    class Present < Matcher

      # Returns whether the given value is present.
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        if actual.kind_of?(String)
          actual.match(/\S/)
        elsif actual.respond_to?(:empty?)
          not actual.empty?
        else
          actual
        end
      end

    end # Present
  end # Matchers
end # Luggage
