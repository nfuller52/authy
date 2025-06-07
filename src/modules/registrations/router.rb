# frozen_string_literal: true

module Registrations
  class Router < Support::Http::Router
    get '/registrations' do
      render({ data: 'registrations' })
    end
  end
end
