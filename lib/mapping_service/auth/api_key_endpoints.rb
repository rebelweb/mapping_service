# frozen_string_literal: true

require 'grape'
require_relative './authentication_helper'

module MappingService
  module Auth
    class ApiKeyEndpoints < Grape::API
      helpers AuthenticationHelper

      get '/' do
        authorize_admin!
        keys = ApiKeyRepository.new.get_all
        payload = { keys: keys }
        present payload, with: ApiKeysSerializer
      end

      params do
        requires :description, type: String, desc: 'Key Description'
        requires :admin, type: Boolean, desc: 'Key has admin permission'
        requires :geocoding, type: Boolean, desc: 'Key has permission to make geocode requests'
        optional :expires_in, type: Integer, desc: 'Time that the key expires'
      end
      post '/' do
        authorize_admin!
        api_key = ApiKeyRepository.new.create(params)
        status 200
        present api_key
      end

      params do
        requires :key, type: String, desc: 'Api Key to destroy'
      end
      delete '/:key' do
        authorize_admin!
        result = ApiKeyRepository.new.destroy params[:key]
        status 404 if result.nil?

        present result
      end
    end
  end
end
