# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe GeocodingService do
      let(:query) { 'Ballard+Nature+Center+Altamont+IL' }

      let(:response_body) do
        File.read('./spec/fixtures/here_geocode_response.json')
      end

      let(:response) { JSON.parse(response_body) }

      subject do
        described_class.new
      end

      it 'makes the request to get the geocode request' do
        allow_any_instance_of(MappingService::Geocoding::GeocodeRetriever)
          .to receive(:call).with({ query: query, provider: 'Here' }).and_return(response)

        expect(subject.call(query: query)).to eq(response)
      end

      it 'saves the response into cache' do
        expect do
          subject.call(query: query)
        end.to change(ProviderResponse, :count).by(1)
      end

      context 'retriving cached response' do
        let(:cached_response) do
          ProviderResponse.create(
            query: query,
            provider: 'Here',
            response: response,
            created_at: Time.zone.now
          )
        end

        it 'returns the result from cache' do
          expect(subject.call(query: query)).to eq(cached_response.response)
        end
      end

      context 'selecting a provider' do
        let(:response_data) { File.read('./spec/fixtures/google_geocode_response.json') }
        let(:response) { JSON.parse(response_data) }

        before do
          allow_any_instance_of(MappingService::Providers::Google::GeocodeClient)
            .to receive(:call).and_return(response)
        end

        it 'uses the selected provider' do
          expect_any_instance_of(MappingService::Providers::Google::GeocodeClient)
            .to receive(:call)

          subject.call(query: query, provider: 'Google')
        end
      end
    end
  end
end
