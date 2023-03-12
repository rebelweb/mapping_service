# frozen_string_literal: true

require_relative 'location_response'

module MappingService
  module Geocoding
    class GeocodeResponse < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :provider, documentation: { type: 'String', desc: 'The service used to obtain the data' }
      expose :items, using: Geocoding::LocationResponse, documentation: { is_array: true, desc: 'Results from the search' }
      with_options(format_with: :iso_timestamp) do
        expose :cached_date, documentation: { type: 'DateTime', desc: 'Time response was cached from the provider' }
      end
    end
  end
end
