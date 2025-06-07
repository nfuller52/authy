# frozen_string_literal: true

module Migration202506071420EnableExtensions
  EXTENSIONS = %w[pgcrypto citext pg_trgm].freeze

  def self.up(session)
    EXTENSIONS.each do |extension|
      session.call("CREATE EXTENSION IF NOT EXISTS \"#{extension}\";")
    end
  end

  def self.down(session)
    EXTENSIONS.each do |extension|
      session.call("DROP EXTENSION IF EXISTS \"#{extension}\";")
    end
  end
end
