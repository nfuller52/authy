# frozen_string_literal: true

module Migration202506071525CreateOauthAccessTokens
  TABLE_NAME = 'oauth_access_tokens'

  def self.up(session)
    session.call(<<~SQL)
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        user_id UUID REFERENCES users(id) ON DELETE CASCADE,
        oauth_client_id UUID REFERENCES oauth_clients(id) ON DELETE CASCADE,
        scopes TEXT[],
        issued_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        expires_at TIMESTAMPTZ NOT NULL
      );
    SQL

    session.call(<<~SQL)
      CREATE TRIGGER set_#{TABLE_NAME}_updated_at
      BEFORE UPDATE ON #{TABLE_NAME}
      FOR EACH ROW
      EXECUTE FUNCTION set_updated_at()
    SQL
  end

  def self.down(session)
    session.call("DROP TRIGGER IF EXISTS set_#{TABLE_NAME}_updated_at ON #{TABLE_NAME};")
    session.call("DROP TABLE IF EXISTS #{TABLE_NAME};")
  end
end
