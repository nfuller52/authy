# frozen_string_literal: true

module Support
  module Serializers
    module Validators
      class Format < Support::Serializers::Validators::BaseValidator
        # ! feat:18nl
        DEFAULT_MESSAGE = {
          matches: 'is not a valid format',
          matches_field: 'does not match %<field>s'
        }.freeze

        REGEX_MAP = {
          email: %r{\A[a-z0-9!#$%&'*+/=?^_`{|}~.-]+@[a-z0-9-]+(?:\.[a-z0-9-]+)*\z}i
        }.freeze

        def validate_matches(value, message)
          regex = value.is_a?(Symbol) ? REGEX_MAP[value] : value

          return if input_value&.match(regex)

          add_error(message || DEFAULT_MESSAGE[:matches])
        end

        def validate_matches_field(value, message)
          return if input_value == context[:inputs][value]

          add_error(message || format(DEFAULT_MESSAGE[:matches_field],
                                      field: value))
        end
      end
    end
  end
end
