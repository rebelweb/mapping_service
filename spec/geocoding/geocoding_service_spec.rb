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

      let(:geocode_retriever) { double('geocode_retriever') }

      subject do
        described_class.new(
          geocode_retriever: geocode_retriever
        )
      end

      it 'makes the request to get the geocode request' do
        allow(geocode_retriever)
          .to receive(:call).with({query: query}).and_return(response)

        expect(subject.call(query: query)).to eq(response)
      end
    end
  end
end
