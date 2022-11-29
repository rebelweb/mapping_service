# frozen_string_literal: true

require 'net/http'

module MappingService
  module Providers
    module Here
      class GeocodeClient
        ENDPOINT = 'https://geocode.search.hereapi.com/v1/geocode'

        def initialize(api_key: ENV.fetch('HERE_API_KEY'))
          self.api_key = api_key
        end

        def call(query:)
          return if api_key.empty? || query.empty?

          response = make_request(query)

          JSON.parse(response.body) if response.code == '200'
        end

        private

        attr_accessor :api_key

        def make_request(query)
          MappingService::RequestBuilder.new(endpoint: ENDPOINT, params: request_params(query)).call
        end

        def request_params(query)
          {
            q: query.gsub(' ', '+'),
            apiKey: api_key
          }
        end
      end
    end
  end
end
