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
          uri = URI(ENDPOINT)
          uri.query = URI.encode_www_form(request_params(query))

          client = Net::HTTP.new(uri.host, uri.port)
          client.use_ssl = true

          request = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
          client.request(request)
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
