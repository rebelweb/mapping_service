# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKeyEndpoints, type: :endpoint do
      def app
        MappingService::Application
      end

      let!(:api_key) { create(:api_key) }

      describe 'get /' do
        it 'renders a list of api keys' do
          header 'API-KEY', api_key.key
          get '/admin/api_keys'

          data = JSON.parse(last_response.body)

          expect(data['keys'].count).to eq(1)
          expect(data['keys'][0]['description']).to eq('Sample Key')
        end

        it 'returns a 401 for non authorized users' do
          get '/admin/api_keys'
          expect(last_response.status).to eq(401)
        end
      end

      describe 'post' do
        context 'valid' do
          let(:params) do
            {
              description: 'Sample',
              admin: true,
              geocoding: true,
              expires_in: 90
            }
          end

          it 'creates the api key' do
            expect do
              header 'API-KEY', api_key.key
              post '/admin/api_keys', params
            end.to change(ApiKey, :count).by(1)
          end

          it 'returns a 200 status' do
            header 'API-KEY', api_key.key
            post '/admin/api_keys', params
            expect(last_response.status).to eq(200)
            json = JSON.parse(last_response.body)
            expect(json['description']).to eq('Sample')
          end

          it 'returns a 401 status when user not authorized' do
            post '/admin/api_keys', params
            expect(last_response.status).to eq(401)
          end
        end
      end

      describe 'delete /:key' do
        it 'returns a 404 error code when key is not found' do
          header 'API-KEY', api_key.key
          delete '/admin/api_keys/abc1234'
          expect(last_response.status).to eq(404)
        end

        it 'returns a 200 code when key is found and removed' do
          header 'API-KEY', api_key.key
          delete "/admin/api_keys/#{api_key.key}"
          expect(last_response.status).to eq(200)
        end

        it 'returns a 401 for non authorized users' do
          delete "/admin/api_keys/#{api_key.key}"
          expect(last_response.status).to eq(401)
        end
      end
    end
  end
end
