# frozen_string_literal: true

module Support
  module Serializers
    module Validators
      class BaseValidator
        attr_reader :field, :input_value, :rules, :context

        def initialize(field, input_value, rules, context)
          @field = field
          @input_value = input_value
          @rules = rules
          @context = context
        end

        def validate
          message = rules[:message]

          rules.except(:message).each do |rule_key, rule_value|
            public_send("validate_#{rule_key}", rule_value, message)
          end
        end

        protected

        def add_error(message)
          (context[:errors][field] ||= []).append(message)
        end
      end
    end
  end
end
