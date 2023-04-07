# frozen_string_literal: true

require 'grape'

module MappingService
  module Auth
    class ApiKeyEndpoints < Grape::API
      get '/' do
        keys = ApiKeyRepository.new.get_all
        payload = { keys: keys }
        present payload, with: ApiKeysSerializer
      end

      params do
        requires :key, type: String, desc: 'Api Key to destroy'
      end
      delete '/:key' do
        result = ApiKeyRepository.new.destroy params[:key]
        status 404 if result.nil?

        present result
      end
    end
  end
end
