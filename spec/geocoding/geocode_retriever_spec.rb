# frozen_string_literal: true

module MappingService
  module Geocoding
    RSpec.describe GeocodeRetriever do
      let(:query) { 'Ballard+Nature+Center+Altamont+IL' }

      let(:response_body) do
        File.read('./spec/fixtures/here_geocode_response.json')
      end

      let(:response) { JSON.parse(response_body) }

      subject do
        described_class.new
      end

      it 'returns the response from the selected geocode client' do
        allow_any_instance_of(MappingService::Providers::Here::GeocodeClient)
          .to receive(:call).with({ query: query }).and_return(response)

        expect(subject.call(query: query)).to eq(response)
      end
    end
  end
end
