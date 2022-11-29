# frozen_string_literal: true

require 'net/http'

module MappingService
  module Providers
    module Google
      class GeocodeClient
        ENDPOINT = 'https://maps.googleapis.com/maps/api/geocode/json'

        def initialize(api_key: ENV.fetch('GOOGLE_API_KEY'))
          self.api_key = api_key
        end

        def call(query:)
          return if api_key.blank?

          body = JSON.parse(make_request(query).body)

          return nil if body['status'] == 'REQUEST_DENIED'

          body
        end

        private

        attr_accessor :api_key

        def make_request(query)
          MappingService::RequestBuilder.new(endpoint: ENDPOINT, params: request_params(query)).call
        end

        def request_params(query)
          {
            address: query.gsub('+', ' '),
            key: api_key
          }
        end
      end
    end
  end
end
