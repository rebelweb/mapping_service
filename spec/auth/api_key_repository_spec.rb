# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeyRepository do
      subject { described_class.new }

      let!(:api_key) { create(:api_key) }

      describe '#get_all' do
        it 'returns all api keys in the system' do
          expect(subject.get_all).to include(api_key)
        end
      end

      describe '#find_by_key' do
        it 'finds the key if it exists' do
          expect(subject.find_by_key(api_key.key)).to eq(api_key)
        end

        it "returns nil if the key doesn't exist" do
          expect(subject.find_by_key('abc123')).to be_nil
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
