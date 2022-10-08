# frozen_string_literal: true

require 'net/http'

module MappingService
  module Providers
    module Here
      class GeocodeClient
        ENDPOINT = 'https://geocode.search.hereapi.com/v1/geocode'

        def initialize(api_key: ENV['HERE_API_KEY'])
          self.api_key = api_key
        end

        def call(query:)
          return if api_key.empty? || query.empty?

          uri = URI(ENDPOINT)
          uri.query = URI.encode_www_form(request_params(query))

          client = Net::HTTP.new(uri.host, uri.port)
          client.use_ssl = true

          request = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
          response = client.request(request)

          JSON.parse(response.body) if response.code == '200'
        end

        private

        attr_accessor :api_key

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
