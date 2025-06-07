# frozen_string_literal: true

module Pg
  module Db
    def client
      @client ||= DB::Client.new(DB::Postgres::Adapter.new(database: 'authy_development',
                                                           username: 'postgres',
                                                           password: 'postgres',
                                                           port: '6001'))
    end
  end
end
