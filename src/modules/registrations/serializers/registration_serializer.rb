# frozen_string_literal: true

module Registrations
  module Serializers
    class RegistrationSerializer < Support::Serializers::GenericSerializer
      input_fields 'email' => {
                     type: :string,
                     length: { min: 6, max: 255 },
                     presence: { blank: false, null: false },
                     format: { matches: :email }
                   },

                   'password' => {
                     type: :string,
                     length: { min: 10, max: 255 },
                     presence: { blank: false, null: false },
                     format: { matches: /[a-zA-z0-9]/ }
                   },

                   'password_confirmation' => {
                     type: :string,
                     presence: { blank: false, null: false },
                     format: { matches_field: 'password' }
                   }

      output_fields 'id' => { type: :uuid },
                    'email' => { type: :string },
                    'created_at' => { type: :datetime },
                    'updated_at' => { type: :datetime }

      def data
        {
          id: SecureRandom.uuid,
          created_at: Time.now.utc,
          updated_at: Time.now.utc,
          password: 'fjkdslafjdklsafjldasf',
          email_verified_at: Time.now.utc
        }
      end
    end
  end
end
