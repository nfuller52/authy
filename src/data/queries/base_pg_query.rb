# frozen_string_literal: true

module Queries
  class BasePgQuery
    include Pg::Db

    def self.call(*, **)
      new(*, **).call
    end

    protected

    def with_session
      session = client.session
      yield session
    ensure
      session&.close
    end
  end
end
