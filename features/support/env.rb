$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '/../../lib'))

require 'time' # Used in the CloseTo matcher features.

require 'spec'
require 'spec/expectations'

require 'luggage'
require 'luggage/spec'

# Used in the object definition steps; provides a version of Struct which
# does not respond to length or size, and allows the use of predicate and
# bang methods.
module Luggage
  module Spec
    class Struct < ::Struct

      undef_method :length
      undef_method :size

      def self.new(*orig_attributes)
        attributes, aliases = [], {}

        orig_attributes.each do |attribute|
          case attribute.to_s
            when /^(.+)!$/
              attributes << "#{$1}_bang".to_sym
              aliases["#{$1}_bang"] = attribute
            when /^(.+)\?$/
              attributes << "#{$1}_predicate".to_sym
              aliases["#{$1}_predicate"] = attribute
            else
              attributes << attribute
          end
        end

        struct_class = super(*attributes)

        struct_class.class_eval(aliases.map do |plain, pretty|
          "alias_method(:#{pretty}, :#{plain}) ; private(:#{plain})"
        end.join("\n"))

        struct_class
      end

    end
  end
end
