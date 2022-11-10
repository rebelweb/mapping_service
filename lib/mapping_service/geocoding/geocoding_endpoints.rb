# frozen_string_literal: true

require 'grape'

module MappingService
  module Geocoding
    class GeocodingEndpoints < Grape::API
      params do
        requires :query, type: String, desc: 'Query for location data'
        optional :provider, type: String, provider: true, desc: 'Provider to use to retrieve data'
      end
      get '/' do
        provider = params.key?(:provider) ? params[:provider] : 'Here'

        GeocodingService.new.call(query: params[:query], provider: provider)
      end
    end
  end
end
