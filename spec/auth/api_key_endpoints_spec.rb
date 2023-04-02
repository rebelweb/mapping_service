# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeyEndpoints, type: :endpoint do
      def app
        MappingService::Application
      end

      describe '/' do
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

        it 'renders a list of api keys' do
          get '/admin/api_keys'

          data = JSON.parse(last_response.body)

          expect(data['keys'].count).to eq(1)
          expect(data['keys'][0]['description']).to eq('Generic key')
        end
      end
    end
  end
end