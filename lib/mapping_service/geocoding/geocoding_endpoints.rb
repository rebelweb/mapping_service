# frozen_string_literal: true

require 'grape'

module MappingService
  module Geocoding
    class GeocodingEndpoints < Grape::API
      desc 'Retrieves Geocoding Data for a Given Query' do
        success GeocodeResponse
      end
      params do
        requires :query, type: String, desc: 'Query for location data'
        optional :provider, type: String, provider: true, desc: 'Provider to use to retrieve data'
      end
      get '/' do
        provider = params.key?(:provider) ? params[:provider] : 'Here'

        present GeocodingService.new.call(query: params[:query], provider: provider), with: GeocodeResponse
      end
    end
  end
end
