# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe GeocodeResponse do
      subject { described_class.represent(geocode_response) }

      let(:json) { JSON.parse(subject.to_json) }

      let(:geocode_response) do
        {
          provider: 'Google',
          cached_date: Time.new(2022, 1, 1, 13, 25, 0),
          items: [location]
        }
      end

      let(:location) do
        {
          title: 'Ballard Nature Center',
          address: '123 Main St',
          city: 'Altamont',
          state: 'Illinois',
          state_code: 'IL',
          country: 'United States',
          country_code: 'US',
          zip_code: '62411',
          county: 'Effingham',
          latitude: 0,
          longitude: 0,
          categories: ['Park']
        }
      end

      it 'only exposes provider, items, and cached_date' do
        expect(json.keys).to eq(%w[provider items cached_date])
      end

      it 'contains one item' do
        expect(json['items'].count).to eq(1)
      end

      it 'returns a response' do
        expect(json['provider']).to eq('Google')
        expect(json['cached_date']).to include('2022-01-01T13:25:00')
        expect(json['items'][0]['title']).to eq('Ballard Nature Center')
        expect(json['items'][0]['address']).to eq('123 Main St')
        expect(json['items'][0]['city']).to eq('Altamont')
        expect(json['items'][0]['state']).to eq('Illinois')
        expect(json['items'][0]['state_code']).to eq('IL')
        expect(json['items'][0]['country']).to eq('United States')
        expect(json['items'][0]['country_code']).to eq('US')
        expect(json['items'][0]['zip_code']).to eq('62411')
        expect(json['items'][0]['latitude']).to eq(0)
        expect(json['items'][0]['longitude']).to eq(0)
        expect(json['items'][0]['categories']).to eq(['Park'])
      end
    end
  end
end
