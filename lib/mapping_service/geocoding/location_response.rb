# frozen_string_literal: true

module MappingService
  module Geocoding
    class LocationResponse < Grape::Entity
      expose :title, documentation: { type: 'String', desc: 'Name of the location' }
      expose :address, documentation: { type: 'String', desc: 'Street address of the location' }
      expose :city, documentation: { type: 'String', desc: 'Locality of the location' }
      expose :state, documentation: { type: 'String', desc: 'Full Name of the State of location' }
      expose :state_code, documentation: { type: 'string', desc: '2 character shorthand of the state of location' }
      expose :country, documentation: { type: 'String', desc: 'Full Name of Country of location' }
      expose :country_code, documentation: { type: 'String', desc: '2 character shorthand of the country of location' }
      expose :zip_code, documentation: { type: 'String', desc: 'Postal code of the location' }
      expose :county, documentation: { type: 'String', desc: 'Subsection of state for the location' }
      expose :latitude, documentation: { type: 'Float', desc: 'East/West geocoordinate of the location' }
      expose :longitude, documentation: { type: 'Float', desc: 'North/South geocoordinate of the location' }
      expose :categories, documentation: { type: 'String', is_array: true, desc: 'Keywords to describe location' }
    end
  end
end
