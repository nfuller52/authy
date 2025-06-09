# frozen_string_literal: true

module Support
  module Serializers
    class Validator
      attr_reader :input_schema, :validators

      def initialize(input_schema, validators = nil)
        @input_schema = input_schema
        @validators = validators || {
          length: Support::Serializers::Validators::Length,
          format: Support::Serializers::Validators::Format,
          presence: Support::Serializers::Validators::Presence
        }
      end

      def register_validator(validator_name, validator_class)
        validators[validator_name.to_sym] = validator_class
      end

      def validate(errors, inputs)
        input_schema.each do |field, rules|
          value = inputs[field]
          type = rules.fetch(:type)
          context = { errors:, inputs:, type: }

          run_validations(field, rules, value, context)
        end
      end

      def run_validations(field, rules, value, context)
        rules.except(:type).each do |validator_type, validator_rules|
          next unless validators.key?(validator_type)

          validators[validator_type].new(
            field, value, validator_rules, context
          ).validate
        end
      end
    end
  end
end
