require 'ward/matchers/matcher'
require 'ward/matchers/acceptance'
require 'ward/matchers/close_to'
require 'ward/matchers/equal_to'
require 'ward/matchers/has'
require 'ward/matchers/include'
require 'ward/matchers/match'
require 'ward/matchers/nil'
require 'ward/matchers/predicate'
require 'ward/matchers/present'
require 'ward/matchers/satisfy'

module Ward
  module Matchers

    # Registers a matcher and it's slug.
    #
    # A matcher can be registered with as many slugs as desired.
    #
    # @param [Symbol, #to_sym] slug
    #   A slug which will be used by the DSL in order to assign a context to
    #   a matcher.
    # @param [Ward::Matchers::Matcher] matcher
    #   The matcher to be registered.
    #
    # @example Registering the Acceptance handler to be used with :accepted
    #
    #   Matchers.register(:accepted, Matchers::Acceptance)
    #
    #   # The Acceptance matcher can now be used like so...
    #
    #   validate do |form|
    #     form.acceptable_use_policy.is.accepted
    #     form.acceptable_use_policy.is_not.accepted
    #   end
    #
    # @example Registering the Has matcher twice.
    #
    #   Matchers.register(:has, Matchers::Acceptance)
    #
    #   validate do |post|
    #     post.has(1).author
    #   end
    #
    #   # This provides access to the Has matcher, but "does_not.has" doesn't
    #   # make much sense. So, we register the Has matcher a second time with
    #   # a slug which make sense when used in the negative.
    #
    #   Matchers.register(:have, Matchers::Acceptance)
    #
    #   validate do |post|
    #     form.does_not.have(1).author
    #   end
    #
    #   # Much better.
    #
    def self.register(slug, matcher)
      matchers[slug.to_sym] = matcher
    end

    # Returns the registered matchers.
    #
    # @return [Hash{Symbol => Ward::Matchers::Matcher}]
    #
    def self.matchers
      @matchers ||= {}
    end

    # Register the built-in matchers.

    register :accepted,      Acceptance
    register :close_to,      CloseTo
    register :equal_to,      EqualTo
    register :has,           Has
    register :have,          Has
    register :included_in,   Include
    register :matches,       Match
    register :match,         Match
    register :nil,           Nil
    register :one_of,        Include
    register :present,       Present
    register :satisfies,     Satisfy
    register :satisfy,       Satisfy

  end
end # Ward
