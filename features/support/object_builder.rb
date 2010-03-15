module Luggage
  module Spec
    # An object which allows new attributes and behaviour to be easily
    # declared, and for validations to be added one at a time.
    class ObjectBuilder

      attr_reader :attributes, :values, :behaviours

      def initialize
        @attributes, @values, @behaviours = [], {}, []
      end

      # Create an oject with the named attributes and values.
      #
      # @return [Luggage::Spec::Struct]
      #
      def to_instance
        @attributes = [:__placeholder__] if @attributes.empty?

        instance = Luggage::Spec::Struct.new(*@attributes).new(
          *@attributes.map { |attribute| @values[attribute] })

        unless @behaviours.empty?
          metaclass = (class << instance; self; end)
          @behaviours.each { |behaviour| metaclass.class_eval(behaviour) }
        end

        instance
      end

    end # ObjectBuilder
  end # Spec
end # Luggage
