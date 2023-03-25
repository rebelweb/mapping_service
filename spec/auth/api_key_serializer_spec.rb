# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeySerializer do
      subject { described_class.represent(api_key) }

      let(:api_key) do
        {
          key: 'abc123',
          description: 'Test',
          admin: false,
          geocoding: false,
          expires_at: Time.new(2025,1,2,0,0,0),
          created_at: Time.zone.now
        }
      end

      let(:response) { JSON.parse(subject.to_json) }

      it 'does not display the key' do
        expect(response.keys).to_not include('key')
      end

      it 'returns the description' do
        expect(response['description']).to eq('Test')
      end

      it 'returns the admin field' do
        expect(response['admin']).to be_falsey
      end

      it 'returns the geocoding field' do
        expect(response['geocoding']).to be_falsey
      end

      it 'returns the expires_at field' do
        expect(response['expires_at']).to include('2025-01-02')
      end

      it 'returns the created_at field' do
        expect(response['created_at']).to_not be_nil
      end
    end
  end
end