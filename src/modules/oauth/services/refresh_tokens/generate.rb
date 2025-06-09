# frozen_string_literal: true

require 'securerandom'

module OAuth
  module Services
    module RefreshTokens
      class Generate
        TOKEN_EXPIRATION_IN_SECONDS = 30 * 24 * 60 * 60
        TOKEN_BYTE_LENGTH = 96
        SALT_TOKEN_BYTE_LENGTH = 24

        def self.call
          issued_at = Time.now.utc
          expires_at = issued_at + TOKEN_EXPIRATION_IN_SECONDS
          refresh_token = SecureRandom.urlsafe_base64(TOKEN_BYTE_LENGTH)
          token_salt = SecureRandom.urlsafe_base64(SALT_TOKEN_BYTE_LENGTH)
          token_hash = OAuth::Services::RefreshTokens::Hasher.call(token: refresh_token, salt: token_salt)

          { token_hash:, token_salt:, issued_at:, expires_at:, refresh_token: }
        end
      end
    end
  end
end
