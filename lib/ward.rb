require 'yaml'

# Add Ruby 1.9-style string interpolation.
require 'active_support/core_ext/string/interpolation'

# Load the ActiveSupport inflector without the String extensions methods.
require 'active_support/inflector/inflections'
require 'active_support/inflector/transliterate'
require 'active_support/inflector/methods'
require 'active_support/inflections'

# On with the library...
require 'ward/support'
require 'ward/context'
require 'ward/context_chain'
require 'ward/dsl'
require 'ward/errors'
require 'ward/matchers'
require 'ward/validator'
require 'ward/validator_set'
require 'ward/version'

module Ward
  # Raise when a validator couldn't be built as something was missing.
  class IncompleteValidator < StandardError; end
end
