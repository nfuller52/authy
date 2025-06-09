# frozen_string_literal: true

module Application
  module Config
    class << self
      attr_accessor :oauth_refresh_token_ttyl,
                    :oauth_access_token_secret

      def configure
        yield self
      end
    end
  end

  class << self
    def settings
      Config
    end
  end
end
