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

      private

      attr_accessor :api_keys
    end
  end
end
