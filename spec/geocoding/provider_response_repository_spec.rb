# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe ProviderResponseRepository do
      let(:query) { 'Ballard+Nature+Center+Altamont+IL' }
      let(:response_data) { File.read('./spec/fixtures/here_geocode_response.json') }
      let(:response) { JSON.parse(response_data) }

      subject { described_class.new }

      describe '#retrieve' do
        context 'response exists' do
          before do
            ProviderResponse.create(
              query: query,
              provider: 'Here',
              response: response,
              created_at: Time.zone.now
            )
          end

          it 'retrieves the response from cache' do
            cache = subject.retrieve(query: query, provider: 'Here')
            expect(cache.response).to eq(response)
          end

          it 'returns nil if the response is past the cache expiration' do
            allow(ENV).to receive(:fetch).with('RESPONSE_VALID_FOR', nil).and_return(90)

            Timecop.freeze(Time.zone.now + 91.days) do
              cache = subject.retrieve(query: query, provider: 'Here')
              expect(cache).to be_nil
            end
          end
        end

        it 'returns null if there is no response in the cache' do
          expect(subject.retrieve(query: query, provider: 'Here')).to be_nil
        end
      end

      describe '#create' do
        it 'writes the cache record' do
          expect do
            subject.create(query: query, provider: 'Here', response: response)
          end.to change(ProviderResponse, :count).by(1)
        end
      end
    end
  end
end
