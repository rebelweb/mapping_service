# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Providers
    module Google
      RSpec.describe GeocodeClient do
        let(:query) { 'Ballard Nature Center Altamont IL' }

        subject { described_class.new }

        it 'returns a successful response', vcr: { cassette_name: 'google/geocode/success' } do
          response = subject.call(query: query)

          expect(response['results'][0]['address_components'][0]['long_name']).to eq('Ballard Nature Center')
        end

        it 'returns nil if the API key is invalid', vcr: { cassette_name: 'google/geocode/invalid_api_key' } do
          allow(ENV).to receive(:fetch).and_return('abc123')

          response = subject.call(query: query)

          expect(response).to be_nil
        end

        it 'returns nil if the API key is not set' do
          allow(ENV).to receive(:fetch).and_return('')

          response = subject.call(query: query)

          expect(response).to be_nil
        end
      end
    end
  end
end
