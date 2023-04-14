# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe GeocodingEndpoints, type: :endpoint do
      def app
        MappingService::Application
      end

      let(:api_key) { create(:api_key) }

      it 'renders the data for the query', vcr: { cassette_name: 'here/geocode/success' } do
        header 'API-KEY', api_key.key
        get '/geocoding?query=Ballard+Nature+Center+Altamont+IL'

        data = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(data['items'][0]['title']).to eq('Ballard Nature Center')
        expect(data['items'][0]['city']).to eq('Altamont')
        expect(data['items'][0]['state']).to eq('Illinois')
      end

      it 'returns a bad request response when a query is not attached' do
        get '/geocoding'

        expect(last_response.status).to eq(400)
      end

      it 'uses the preferred provider' do
        header 'API-KEY', api_key.key
        get '/geocoding?query=Ballard%20Nature%20Center%20Altamont%20IL&provider=Google'

        data = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(data['items'][0]['title'])
          .to eq('Ballard Nature Center')
      end

      it 'returns an error if the provider param is invalid' do
        get '/geocoding?query=Ballard%20Nature%20Center%20Altamont%20IL&provider=bing'

        expect(last_response.status).to eq(400)
      end

      it "returns a error if the provider isn't configured" do
        allow(ENV).to receive(:fetch).and_return('')
        allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('abc123')

        get '/geocoding?query=Ballard%20Nature%20Center%20Altamont%20IL&provider=here'

        expect(last_response.status).to eq(400)
      end
    end
  end
end
