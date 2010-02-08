$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'date' # Used in the CloseTo matcher spec.

require 'rubygems'
require 'spec'
require 'spec/autorun'

require 'luggage'
require 'luggage/spec'

Spec::Runner.configure do |config|

end
