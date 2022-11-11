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
              state: state(result)[0],
              state_code: state(result)[1],
              country: country(result)[0],
              country_code: country(result)[1],
              zip_code: zip_code(result),
              county: county(result),
              latitude: result['geometry']['location']['lat'],
              longitude: result['geometry']['location']['lng'],
              categories: result['types']
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
          [component['long_name'], component['short_name']]
        end

        def country(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'country' }
          [component['long_name'], component['short_name']]
        end

        def zip_code(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'postal_code' }
          component['long_name']
        end

        def county(result)
          component = result['address_components'].find { |comp| comp['types'].include? 'administrative_area_level_2' }
          component['long_name']
        end
      end

      class HereUnifiedResponse
        def initialize(payload)
          self.payload = payload
        end

        def call
          payload['items'].collect do |item|
            {
              title: item['title'],
              address: address(item),
              city: item['address']['city'],
              state: item['address']['state'],
              state_code: item['address']['stateCode'],
              country: item['address']['countryName'],
              country_code: item['address']['countryCode'],
              zip_code: item['address']['postalCode'],
              county: item['address']['county'],
              latitude: item['position']['lat'],
              longitude: item['position']['lng'],
              categories: categories(item)
            }
          end
        end

        private

        attr_accessor :payload

        def address(item)
          number = item['address']['houseNumber']
          street = item['address']['street']

          "#{number} #{street}"
        end

        def categories(item)
          item['categories'].collect { |category| category['name'] }
        end
      end
    end
  end
end
