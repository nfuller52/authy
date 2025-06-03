# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'local'
ENV.fetch('ENVIRONMENT', nil)

require_relative 'config/initializers/zeitwerk'
require_relative 'application'

run Application::Authy
