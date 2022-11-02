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
          .to receive(:call).with({ query: query }).and_return(response)

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
    end
  end
end
