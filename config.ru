# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'local'

require_relative 'config/initializers/zeitwerk'
require_relative 'config/environment'
require_relative 'config/router'

# Autoloaded by zeitwerk
run Authy::Router
