# frozen_string_literal: true

module Migration202506071505CreateOauthClients
  TABLE_NAME = 'oauth_clients'

  def self.up(session)
    session.call(<<~SQL)
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        name TEXT NOT NULL,
        client_id TEXT NOT NULL UNIQUE DEFAULT gen_random_uuid(),
        client_secret TEXT NOT NULL,
        redirect_uris TEXT[] NOT NULL
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
