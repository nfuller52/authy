# frozen_string_literal: true

module Support
  module Http
    class Router < Sinatra::Base
      set :show_exceptions, false
      set :raise_errors, true

      error do
        err = env['sinatra.error']
        status 500
        { error: 'Internal Server Error', detail: err.message }.to_json
      end

      def render_json(data)
        content_type :json

        # Renderers::Json.transform({ data: data }).to_json

        data.to_json
      end
    end
  end
end
