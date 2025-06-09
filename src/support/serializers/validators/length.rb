# frozen_string_literal: true

module Support
  module Serializers
    module Validators
      class Length < Support::Serializers::Validators::BaseValidator
        # ! feat:18nl
        DEFAULT_MESSAGE = {
          min: 'must be longer than %<count>s characters',
          max: 'must be shorter than %<count>s characters',
          in: 'must be between %<min>s and %<max>s characters'
        }.freeze

        def validate_min(value, message)
          return if input_value&.length&.>= value

          add_error(message || format(DEFAULT_MESSAGE[:min], count: value))
        end

        def validate_max(value, message)
          return if input_value&.length&.<= value

          add_error(message || format(DEFAULT_MESSAGE[:max], count: value))
        end

        def validate_in(value, message)
          return if value&.include?(input_value.length)

          add_error(message || format(DEFAULT_MESSAGE[:in],
                                      min: value.first,
                                      max: value.last))
        end
      end
    end
  end
end
