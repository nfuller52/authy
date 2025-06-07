# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, ENV['ENVIRONMENT'].to_sym)

require 'sinatra/base'

module Application
  class Authy < Sinatra::Base
    use Registrations::Router
    use WellKnown::Router
  end
end
