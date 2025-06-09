# frozen_string_literal: true

require 'securerandom'

module OAuth
  module Services
    class RefreshToken
      def self.generate
        OAuth::Services::RefreshTokens::Generate.call
      end

      def self.verify(token:, token_hash:, token_salt:, expires_at:)
        OAuth::Services::RefreshTokens::Verify.call(
          token:,
          token_hash:,
          token_salt:,
          expires_at:
        )
      end
    end
  end
end
