$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '/../../lib'))

require 'time' # Used in the CloseTo matcher features.

require 'spec'
require 'spec/expectations'

require 'luggage'
require 'luggage/spec'

# Used in the object definition steps; provides a version of Struct which
# does not respond to length or size.
module Luggage
  module Spec
    class Struct < ::Struct
      undef_method :size
      undef_method :length
    end
  end
end
