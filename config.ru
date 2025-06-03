# frozen_string_literal: true

ENV["ENVIRONMENT"] ||= "local"
env = ENV["ENVIRONMENT"]

require_relative 'config/initializers/zeitwerk'
require_relative 'application'

run Application::Authy
