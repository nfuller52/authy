# frozen_string_literal: true

module Migration202506071453CreateUsers
  TABLE_NAME = 'users'

  def self.up(session)
    session.call(<<~SQL)
      CREATE TABLE IF NOT EXISTS #{TABLE_NAME} (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
        email CITEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      );
    SQL

    session.call(<<~SQL)
      CREATE TRIGGER set_users_updated_at
      BEFORE UPDATE ON #{TABLE_NAME}
      FOR EACH ROW
      EXECUTE FUNCTION set_updated_at()
    SQL
  end

  def self.down(session)
    session.call("DROP TRIGGER IF EXISTS set_users_updated_at ON #{TABLE_NAME};")
    session.call("DROP TABLE IF EXISTS #{TABLE_NAME};")
  end
end
