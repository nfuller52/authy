# frozen_string_literal: true

module Support
  module Serializers
    module Validators
      class Presence < Support::Serializers::Validators::BaseValidator
        # ! feat:18nl
        DEFAULT_MESSAGE = {
          blank: 'can not be blank',
          null: 'must be present',
          in: 'is not one of %<values>s',
          not_in: 'can not be one of %<values>s'
        }.freeze

        def validate_blank(value, message)
          return unless input_value.is_a?(String)
          return if input_value.strip.empty? == value

          add_error(message || DEFAULT_MESSAGE[:blank])
        end

        def validate_null(value, message)
          return if input_value.nil? == value

          add_error(message || DEFAULT_MESSAGE[:null])
        end

        def validate_in(value, message)
          return if value.include?(input_value)

          add_error(message || format(DEFAULT_MESSAGE[:in],
                                      { values: value.join(', ') }))
        end

        def validate_not_in(value, message)
          return unless value.include?(input_value)

          add_error(message || format(DEFAULT_MESSAGE[:not_in],
                                      { values: value.join(', ') }))
        end
      end
    end
  end
end
