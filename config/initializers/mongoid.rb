# frozen_string_literal: true

require 'mongoid'

class DatabaseConfig
  class << self
    def database_name
      case ENV.fetch('APP_ENV', 'development')
      when 'development'
        'mapping_service_development'
      when 'test'
        'mapping_service_test'
      when 'production'
        ENV.fetch('DATABASE_NAME', 'mapping_service_production')
      else
        ENV.fetch('DATABASE_NAME')
      end
    end

    def hosts
      ENV.fetch('DATABASE_HOST', 'localhost:27017').split(',')
    end
  end
end

Mongoid.configure do |config|
  config.clients.default = {
    hosts: DatabaseConfig.hosts,
    database: DatabaseConfig.database_name
  }

  config.log_level = :warn
end
