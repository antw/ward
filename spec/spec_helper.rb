$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'date' # Used in the CloseTo matcher spec.

require 'rubygems'
require 'spec'
require 'spec/autorun'

require 'luggage'
require 'luggage/spec'

# Spec libraries.
spec_libs = Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/lib/**/*.rb')
spec_libs.each { |file| require file }

Spec::Runner.configure do |config|

end
