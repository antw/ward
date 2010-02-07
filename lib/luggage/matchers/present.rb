module Luggage
  module Matchers
    # Tests whether the validation value is present.
    #
    class Present < Matcher

      # Returns whether the given value is "present".
      #
      # A "present" value is one which:
      #
      #   * is a non-blank string, containing more than just whitespace
      #   * responds to #empty? and returns false
      #   * does not evaluate to false (i.e. not nil or false)
      #
      # @param [Object] actual
      #   The validation value.
      #
      # @return [Boolean]
      #
      def matches?(actual)
        if actual.kind_of?(String)
          actual =~ /\S/
        elsif actual.respond_to?(:empty?)
          not actual.empty?
        else
          !! actual
        end
      end

    end # Present
  end # Matchers
end # Luggage
