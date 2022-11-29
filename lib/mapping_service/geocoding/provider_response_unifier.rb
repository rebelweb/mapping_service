# frozen_string_literal: true

# Unified Response
# {
#   provider: 'Here',
#   cached_date: 2022-11-11T12:00:49Z,
#   items: [
#     {
#       title: 'Ballard Nature Center',
#       address: '5253 E US Highway 40'
#       city: 'Altamont',
#       state: 'Illinois',
#       state_code: 'IL',
#       country: 'United States'
#       country_code: 'US'
#       zipCode: '62411',
#       county: 'Effingham',
#       latitude: 0.0,
#       longitude: 0.0,
#       categories: [
#         ""
#       ]
#     }
#   ]
# }

module MappingService
  module Geocoding
    class ProviderResponseUnifier
      def initialize(response:)
        self.payload = response.response
        self.provider = response.provider
        self.cached_date = response.created_at
      end

      def call
        {
          provider: provider,
          cached_date: cached_date,
          items: items
        }
      end

      private

      attr_accessor :payload, :provider, :cached_date

      def items
        config = case provider
                 when 'Google'
                   { klass: GoogleUnifiedResponse, key: 'results' }
                 when 'Here'
                   { klass: HereUnifiedResponse, key: 'items' }
                 end

        payload[config[:key]].collect do |item|
          config[:klass].new(item).call
        end
      end

      class GoogleUnifiedResponse
        def initialize(result)
          self.result = result
        end

        def call
          {
            title: title,
            address: address,
            city: city,
            state: state,
            state_code: state_code,
            country: country,
            country_code: country_code,
            zip_code: zip_code,
            county: county,
            latitude: latitude,
            longitude: longitude,
            categories: categories
          }
        end

        private

        attr_accessor :result

        def address_components
          result['address_components']
        end

        def title
          result['address_components'][0]['long_name']
        end

        def address
          "#{number['long_name']} #{street['long_name']}"
        end

        def number
          address_components.find { |comp| comp['types'].include? 'street_number' }
        end

        def street
          address_components.find { |comp| comp['types'].include? 'route' }
        end

        def city
          component = result['address_components'].find { |comp| comp['types'].include? 'locality' }
          component['long_name']
        end

        def state
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_1' }
          component['long_name']
        end

        def state_code
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_1' }
          component['short_name']
        end

        def country
          component = result['address_components'].find { |comp| comp['types'].include? 'country' }
          component['long_name']
        end

        def country_code
          component = result['address_components'].find { |comp| comp['types'].include? 'country' }
          component['short_name']
        end

        def zip_code
          component = result['address_components'].find { |comp| comp['types'].include? 'postal_code' }
          component['long_name']
        end

        def county
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_2' }
          component['long_name']
        end

        def latitude
          result['geometry']['location']['lat']
        end

        def longitude
          result['geometry']['location']['lng']
        end

        def categories
          result['types']
        end
      end

      class HereUnifiedResponse
        def initialize(item)
          self.item = item
        end

        def call
          {
            title: title,
            address: street_address,
            city: city,
            state: state,
            state_code: state_code,
            country: country,
            country_code: country_code,
            zip_code: zip_code,
            county: county,
            latitude: latitude,
            longitude: longitude,
            categories: categories
          }
        end

        private

        attr_accessor :item

        def address
          item['address']
        end

        def title
          item['title']
        end

        def street_address
          number = address['houseNumber']
          street = address['street']

          "#{number} #{street}"
        end

        def city
          address['city']
        end

        def state
          address['state']
        end

        def state_code
          address['stateCode']
        end

        def country
          address['countryName']
        end

        def country_code
          address['countryCode']
        end

        def zip_code
          address['postalCode']
        end

        def county
          address['county']
        end

        def latitude
          item['position']['lat']
        end

        def longitude
          item['position']['lng']
        end

        def categories
          item['categories'].collect { |category| category['name'] }
        end
      end
    end
  end
end
