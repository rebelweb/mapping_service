# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe ProviderResponseUnifier do

      subject { described_class.new }

      context 'Google Provider' do
        let(:response_body) { File.read('./spec/fixtures/google_geocode_response.json') }
        let(:response) { JSON.parse(response_body) }

        it 'returns the unified response for the Google Provider' do
          unified_response = subject.call(response, 'Google')

          expect(unified_response[:provider]).to eq('Google')
          expect(unified_response[:cached_date]).to be_nil
          expect(unified_response[:items][0][:title]).to eq('Ballard Nature Center')
          expect(unified_response[:items][0][:address]).to eq('5253 U.S. 40')
          expect(unified_response[:items][0][:city]).to eq('Altamont')
          expect(unified_response[:items][0][:state]).to eq('Illinois')
          expect(unified_response[:items][0][:state_code]).to eq('IL')
          expect(unified_response[:items][0][:country]).to eq('United States')
          expect(unified_response[:items][0][:country_code]).to eq('US')
          expect(unified_response[:items][0][:zip_code]).to eq('62411')
          expect(unified_response[:items][0][:county]).to eq('Effingham County')
          expect(unified_response[:items][0][:latitude]).to eq(39.0625551)
          expect(unified_response[:items][0][:longitude]).to eq(-88.7048813)
          expect(unified_response[:items][0][:categories]).to eq(%w[establishment park point_of_interest tourist_attraction])
        end
      end

      context 'here provider' do
        let(:response_body) { File.read('./spec/fixtures/here_geocode_response.json') }
        let(:response) { JSON.parse(response_body) }

        it 'returns the unified response for the Here Provider' do
          unified_response = subject.call(response, 'Here')

          expect(unified_response[:provider]).to eq('Here')
          expect(unified_response[:cached_date]).to be_nil
          expect(unified_response[:items][0][:title]).to eq('Ballard Nature Center')
          expect(unified_response[:items][0][:address]).to eq('5253 E US Highway 40')
          expect(unified_response[:items][0][:city]).to eq('Altamont')
          expect(unified_response[:items][0][:state]).to eq('Illinois')
          expect(unified_response[:items][0][:state_code]).to eq('IL')
          expect(unified_response[:items][0][:country]).to eq('United States')
          expect(unified_response[:items][0][:country_code]).to eq('USA')
          expect(unified_response[:items][0][:zip_code]).to eq('62411-2485')
          expect(unified_response[:items][0][:county]).to eq('Effingham')
          expect(unified_response[:items][0][:latitude]).to eq(39.06721)
          expect(unified_response[:items][0][:longitude]).to eq(-88.70767)
          expect(unified_response[:items][0][:categories]).to eq(['Park-Recreation Area',
            'Landmark-Attraction',
            'Trailhead',
            'Organizations and Societies'
          ])
        end
      end
    end
  end
end
