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
      def call(payload, provider, cached_date = nil)
        {
          provider: provider,
          cached_date: cached_date,
          items: items(payload, provider)
        }
      end

      private

      def items(payload, provider)
        case provider
        when 'Google'
          GoogleUnifiedResponse.new(payload).call
        when 'Here'
          HereUnifiedResponse.new(payload).call
        end
      end

      class GoogleUnifiedResponse
        def initialize(payload)
          self.payload = payload
        end

        def call
          payload['results'].collect do |result|
            {
              title: title(result),
              address: address(result),
              city: city(result),
              state: state(result),
              state_code: state_code(result),
              country: country(result),
              country_code: country_code(result),
              zip_code: zip_code(result),
              county: county(result),
              latitude: latitude(result),
              longitude: longitude(result),
              categories: categories(result)
            }
          end
        end

        private

        attr_accessor :payload

        def title(result)
          result['address_components'][0]['long_name']
        end

        def address(result)
          number = result['address_components'].find { |comp| comp['types'].include? 'street_number' }
          street = result['address_components'].find { |comp| comp['types'].include? 'route' }

          "#{number['long_name']} #{street['long_name']}"
        end

        def city(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'locality' }
          component['long_name']
        end

        def state(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_1' }
          component['long_name']
        end

        def state_code(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_1' }
          component['short_name']
        end

        def country(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'country' }
          component['long_name']
        end

        def country_code(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'country' }
          component['short_name']
        end

        def zip_code(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'postal_code' }
          component['long_name']
        end

        def county(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_2' }
          component['long_name']
        end

        def latitude(result)
          result['geometry']['location']['lat']
        end

        def longitude(result)
          result['geometry']['location']['lng']
        end

        def categories(result)
          result['types']
        end
      end

      class HereUnifiedResponse
        def initialize(payload)
          self.payload = payload
        end

        def call
          payload['items'].collect do |item|
            {
              title: title(item),
              address: address(item),
              city: city(item),
              state: state(item),
              state_code: state_code(item),
              country: country(item),
              country_code: country_code(item),
              zip_code: zip_code(item),
              county: county(item),
              latitude: latitude(item),
              longitude: longitude(item),
              categories: categories(item)
            }
          end
        end

        private

        attr_accessor :payload

        def title(item)
          item['title']
        end

        def address(item)
          number = item['address']['houseNumber']
          street = item['address']['street']

          "#{number} #{street}"
        end

        def city(item)
          item['address']['city']
        end

        def state(item)
          item['address']['state']
        end

        def state_code(item)
          item['address']['stateCode']
        end

        def country(item)
          item['address']['countryName']
        end

        def country_code(item)
          item['address']['countryCode']
        end

        def zip_code(item)
          item['address']['postalCode']
        end

        def county(item)
          item['address']['county']
        end

        def latitude(item)
          item['position']['lat']
        end

        def longitude(item)
          item['position']['lng']
        end

        def categories(item)
          item['categories'].collect { |category| category['name'] }
        end
      end
    end
  end
end
