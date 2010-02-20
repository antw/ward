# Load the ActiveSupport inflector without the String extensions methods.
require 'active_support/inflector/inflections'
require 'active_support/inflector/transliterate'
require 'active_support/inflector/methods'
require 'active_support/inflections'

# On with the library...
require 'luggage/context'
require 'luggage/context_chain'
require 'luggage/dsl'
require 'luggage/errors'
require 'luggage/matchers'
require 'luggage/validator'
require 'luggage/validator_set'

module Luggage
  # Raise when a validator couldn't be built as something was missing.
  class IncompleteValidator < StandardError; end
end
