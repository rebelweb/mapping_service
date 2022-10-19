# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe ProviderResponse do
      let(:query) { 'Ballard+Nature+Center+Altamont+Illinois' }
      let(:provider) { 'Here' }

      let(:response_body) do
        File.read('./spec/fixtures/here_geocode_response.json')
      end

      let(:response) { JSON.parse(response_body) }

      it 'creates a record' do
        cache = described_class.create(
          query: query,
          provider: provider,
          response: response,
          created_at: Time.zone.now
        )

        expect(cache).to be_truthy
      end
    end
  end
end
