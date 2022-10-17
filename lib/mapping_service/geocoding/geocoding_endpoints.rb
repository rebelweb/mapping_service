# frozen_string_literal: true

require 'grape'

module MappingService
  module Geocoding
    class GeocodingEndpoints < Grape::API
      params do
        requires :query, type: String, desc: 'Query for location data'
      end
      get '/' do
        GeocodingService.new.call(query: params[:query])
      end
    end
  end
end
