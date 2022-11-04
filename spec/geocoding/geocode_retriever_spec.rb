# frozen_string_literal: true

module MappingService
  module Geocoding
    RSpec.describe GeocodeRetriever do
      let(:query) { 'Ballard+Nature+Center+Altamont+IL' }

      subject do
        described_class.new
      end

      it 'returns nil for a unknown provider' do
        expect(subject.call(query: query, provider: 'ABC')).to be_nil
      end

      context 'Here Provider' do
        let(:response_body) do
          File.read('./spec/fixtures/here_geocode_response.json')
        end

        let(:response) { JSON.parse(response_body) }

        it 'returns the response from the here geocode client' do
          allow_any_instance_of(MappingService::Providers::Here::GeocodeClient)
            .to receive(:call).with({ query: query }).and_return(response)

          expect(subject.call(query: query, provider: 'Here')).to eq(response)
        end
      end

      context 'Google Provider' do
        let(:response_body) do
          File.read('./spec/fixtures/google_geocode_response.json')
        end

        let(:response) { JSON.parse(response_body) }

        it 'returns the response from the Google Provider' do
          allow_any_instance_of(MappingService::Providers::Google::GeocodeClient)
            .to receive(:call).with({ query: query }).and_return(response)

          expect(subject.call(query: query, provider: 'Google')).to eq(response)
        end
      end
    end
  end
end
