# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe GeocodingEndpoints, type: :endpoint do
      def app
        MappingService::Application
      end

      it 'renders the data for the query', vcr: { cassette_name: 'here/geocode/success' } do
        get '/geocoding?query=Ballard+Nature+Center+Altamont+IL'

        data = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(data['items'][0]['title']).to eq('Ballard Nature Center')
        expect(data['items'][0]['address']['city']).to eq('Altamont')
        expect(data['items'][0]['address']['state']).to eq('Illinois')
      end

      it 'returns a bad request response when a query is not attached' do
        get '/geocoding'

        expect(last_response.status).to eq(400)
      end

      it 'uses the prefered provider' do
        get '/geocoding?query=Ballard%20Nature%20Center%20Altamont%20IL&provider=Google'

        data = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(data['results'][0]['address_components'][0]['long_name'])
          .to eq('Ballard Nature Center')
      end
    end
  end
end
