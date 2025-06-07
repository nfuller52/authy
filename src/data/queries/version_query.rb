# frozen_string_literal: true

module Queries
  class VersionQuery < Queries::BasePgQuery
    Result = Data.define(:version)

    def call
      client = DB::Client.new(
        DB::Postgres::Adapter.new(
          host: 'localhost',
          database: 'authy_development',
          username: 'postgres',
          password: 'postgres',
          port: 6001
        )
      )

      Sync do
        session = client.session
        result = session.call('SELECT VERSION();')
        result = result.to_a.map { |r| Result.new(r) }
        print(result)
      ensure
        session&.close
      end
    end
  end
end
