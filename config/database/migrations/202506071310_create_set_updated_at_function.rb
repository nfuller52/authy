# frozen_string_literal: true

module Migration202506071310CreateSetUpdatedAtFunction
  def self.up(session)
    session.call(<<~SQL)
      CREATE OR REPLACE FUNCTION set_updated_at()
      RETURNS TRIGGER AS $$
      BEGIN
        NEW.updated_at = now();
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def self.down(session)
    session.call('DROP FUNCTION IF EXISTS set_updated_at();')
  end
end
