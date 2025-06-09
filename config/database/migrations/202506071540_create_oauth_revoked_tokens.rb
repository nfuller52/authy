# frozen_string_literal: true

module Migration202506071540CreateOauthRevokedTokens
  TABLE_NAME = 'oauth_revoked_tokens'

  def self.up(session)
    session.call(<<~SQL)
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        token_id UUID NOT NULL,
        token_type TEXT NOT NULL,
        revoked_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        reason TEXT
      );
    SQL

    session.call(<<~SQL)
      CREATE UNIQUE INDEX IF NOT EXISTS oauth_revoked_tokens_token_idx
      ON #{TABLE_NAME} (token_id, token_type);
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
    session.call('DROP INDEX IF EXISTS oauth_revoked_tokens_token_idx;')
    session.call("DROP TABLE IF EXISTS #{TABLE_NAME};")
  end
end
