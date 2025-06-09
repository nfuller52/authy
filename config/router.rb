# frozen_string_literal: true

module Authy
  class Router < Sinatra::Base
    use Registrations::Routes
    use WellKnown::Router
  end
end
