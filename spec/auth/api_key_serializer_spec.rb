# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeySerializer do
      subject { described_class.represent(api_key) }

      let(:api_key) { build(:api_key) }

      let(:response) { JSON.parse(subject.to_json) }

      it 'does not display the key' do
        expect(response.keys).to_not include('key')
      end

      it 'returns the description' do
        expect(response['description']).to eq(api_key.description)
      end

      it 'returns the admin field' do
        expect(response['admin']).to be_truthy
      end

      it 'returns the geocoding field' do
        expect(response['geocoding']).to be_truthy
      end

      it 'returns the expires_at field' do
        expect(response['expires_at']).to include(api_key.expires_at.strftime('%Y-%m-%d'))
      end

      it 'returns the created_at field' do
        expect(response['created_at']).to_not be_nil
      end
    end
  end
end
