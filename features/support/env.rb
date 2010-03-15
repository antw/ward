$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '/../../lib'))

require 'time' # Used in the CloseTo matcher features.

require 'spec'
require 'spec/expectations'

require 'luggage'
require 'luggage/spec'

require File.join(File.dirname(__FILE__), '/object_builder')
require File.join(File.dirname(__FILE__), '/struct')
