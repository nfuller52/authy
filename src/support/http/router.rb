# frozen_string_literal: true

module Support
  module HTTP
    class Router < Sinatra::Base
      class RouterError < StandardError; end

      set :show_exceptions, false
      set :raise_errors, true

      error do
        err = env['sinatra.error']
        status 500
        { error: 'Internal Server Error', detail: err.message }.to_json
      end

      def render_json(data, status = :ok)
        content_type :json
        status resolve_status_code(status)

        # Renderers::Json.transform({ data: data }).to_json

        data.to_json
      end

      private

      def resolve_status_code(status)
        if status.is_a?(Symbol)
          return Rack::Utils::SYMBOL_TO_STATUS_CODE[status.downcase]
        end

        return status if status.is_a?(Integer)

        raise RouterError('Invalid status code')
      end
    end
  end
end
