# frozen_string_literal: true

module Registrations
  class Routes < Support::HTTP::Router
    # remove this garbage.
    get '/registrations' do
      render_json(OAuth::Services::RefreshToken.generate)
    end

    post '/registrations' do
      # query for data, if any

      # load the serializer
      serializer = Registrations::Serializers::RegistrationSerializer.new(
        JSON.parse(request.body.read)
      )

      # "save" the serializer
      if serializer.save
        render_json(serializer.data)
      else
        render_json(serializer.errors, :bad_request)
      end
    end
  end
end
