# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Providers
    module Here
      RSpec.describe GeocodeClient do
        let(:query) { 'Ballard+Nature+Center+Altamont+IL' }

        subject { described_class.new }

        it 'set the endpoint for the Here API' do
          expect(MappingService::Providers::Here::GeocodeClient::ENDPOINT)
            .to eq('https://geocode.search.hereapi.com/v1/geocode')
        end

        it 'returns a response from the here API',
          vcr: { cassette_name: 'here/geocode/success' } do
          response = subject.call(query: query)

          expect(response["items"][0]["address"]["city"]).to eq('Altamont')
          expect(response["items"][0]["address"]["stateCode"]).to eq('IL')
        end

        it 'returns nil when the api key is not set' do
          allow(ENV).to receive(:[]).and_return('')

          response = subject.call(query: query)

          expect(response).to be_nil
        end

        it 'returns nil if the api key is invalid',
          vcr: { cassette_name: 'here/geocode/invalid_api_key' } do
          allow(ENV).to receive(:[]).and_return('')
          allow(ENV).to receive(:[]).with('HERE_API_KEY').and_return('abc123')

          response = subject.call(query: query)

          expect(response).to be_nil
        end

        it 'returns nil if the query is empty' do
          response = subject.call(query: '')

          expect(response).to be_nil
        end
      end
    end
  end
end
