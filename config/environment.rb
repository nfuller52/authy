# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, ENV['ENVIRONMENT'].to_sym)

require_relative 'application'

environment = ENV.fetch('ENVIRONMENT', 'local')
env_file = File.expand_path("environments/#{environment}.rb", __dir__)

raise "Unknown environment config: #{env_file}" unless File.exist?(env_file)

require env_file
