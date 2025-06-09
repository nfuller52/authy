# frozen_string_literal: true

module OAuth
  module Services
    module RefreshTokens
      class Hasher
        def self.call(token:, salt:)
          Digest::SHA256.hexdigest("#{token}:#{salt}")
        end
      end
    end
  end
end
