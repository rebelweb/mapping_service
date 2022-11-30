# frozen_string_literal: true

require 'grape_logging'

module MappingService
  class Application < Grape::API
    version 'v1', using: :header, vendor: :rebelweb
    format :json

    logger.formatter = GrapeLogging::Formatters::Default.new

    unless ENV.fetch('APP_ENV', 'development') == 'test'
      insert_before Grape::Middleware::Error, GrapeLogging::Middleware::RequestLogger, logger: logger
    end

    mount Status::StatusEndpoints => '/status'
    mount Geocoding::GeocodingEndpoints => '/geocoding'
  end
end
