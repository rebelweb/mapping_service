# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeyRepository do
      subject { described_class.new }

      let!(:api_key) do
        ApiKey.create(
          key: SecureRandom.hex(64),
          description: 'Sample Key',
          admin: false,
          geocoding: true,
          active: true,
          expires_at: Time.zone.now + 90.days,
          created_at: Time.zone.now
        )
      end

      describe '#get_all' do
        it 'returns all api keys in the system' do
          expect(subject.get_all).to include(api_key)
        end
      end

      describe '#create' do
        let(:params) do
          {
            description: 'Sameple',
            admin: false,
            geocoding: true,
            expires_in: 90
          }
        end

        it 'creates the ApiKey' do
          expect { subject.create(params) }.to change(ApiKey, :count).by(1)
        end
      end

      describe '#destroy' do
        it 'returns nil if a key is not found' do
          expect(subject.destroy('abc123')).to be_nil
        end

        it 'returns true if the key is removed' do
          expect(subject.destroy(api_key.key)).to be_truthy
        end
      end
    end
  end
end