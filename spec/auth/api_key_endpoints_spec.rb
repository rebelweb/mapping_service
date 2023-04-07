# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeyEndpoints, type: :endpoint do
      def app
        MappingService::Application
      end

      let!(:api_key) do
        ApiKey.create(
          key: 'abc123',
          description: 'Generic key',
          admin: true,
          geocoding: true,
          expires_at: Time.zone.now,
          created_at: Time.zone.now
        )
      end

      describe 'get /' do
        it 'renders a list of api keys' do
          get '/admin/api_keys'

          data = JSON.parse(last_response.body)

          expect(data['keys'].count).to eq(1)
          expect(data['keys'][0]['description']).to eq('Generic key')
        end
      end

      describe 'delete /:key' do
        it 'returns a 404 error code when key is not found' do
          delete '/admin/api_keys/abc1234'
          expect(last_response.status).to eq(404)
        end

        it 'returns a 200 code when key is found and removed' do
          delete "/admin/api_keys/#{api_key.key}"
          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
