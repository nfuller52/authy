# frozen_string_literal: true

module WellKnown
  class Router < Support::Http::Router
    get '/.well-known/jwks.json' do
      puts(Queries::VersionQuery.call)

      render_json({
                    kty: 'EC',
                    crv: 'P-256',
                    x: 'f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU',
                    y: 'x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0',
                    kid: 'HMAC key used in JWS spec'
                  })
    end

    get '/.well-known/openid-configuration' do
      render_json({
                    todo: 'some data'
                  })
    end
  end
end
