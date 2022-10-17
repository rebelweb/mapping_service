# frozen_string_literal: true

module MappingService
  class Application < Grape::API
    version 'v1', using: :header, vendor: :rebelweb
    format :json

    mount Status::StatusEndpoints => '/status'
    mount Geocoding::GeocodingEndpoints => '/geocoding'
  end
end
