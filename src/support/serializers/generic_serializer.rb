# frozen_string_literal: true

module Support
  module Serializers
    class GenericSerializer
      class << self
        attr_reader :input_schema, :output_schema

        def input_fields(fields)
          @input_schema = fields
        end

        def output_fields(fields)
          @output_schema = fields
        end
      end

      attr_reader :errors, :inputs, :result

      def initialize(inputs, many: false)
        raise 'TODO: Handle array of serializers' if many

        # Filter out any fields not declared as input fields in serializer class
        # TODO: Handle nested attributes?
        @inputs = inputs.slice(*self.class.input_schema.keys)
        @validator = Support::Serializers::Validator.new(self.class.input_schema)
        @errors = {}
        @result = nil
      end

      def valid?
        @validator.validate(errors, inputs)

        errors.empty?
      end

      def save
        valid?
      end

      private

      attr_reader :validator
    end
  end
end
