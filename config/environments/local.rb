# frozen_string_literal: true

Application::Config.configure do |config|
  config.oauth_access_token_secret = ENV.fetch('JWT_SECRET')
  config.oauth_refresh_token_ttyl = 30 * 24 * 60 * 60
end
