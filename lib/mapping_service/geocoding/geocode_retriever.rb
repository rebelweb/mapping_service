# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodeRetriever
      attr_reader :here_client, :google_client

      def initialize(here_client: MappingService::Providers::Here::GeocodeClient.new,
                     google_client: MappingService::Providers::Google::GeocodeClient.new)
        self.here_client = here_client
        self.google_client = google_client
      end

      def call(query:, provider: 'Here')
        case provider
        when 'Here'
          here_client.call(query: query)
        when 'Google'
          google_client.call(query: query)
        end
      end

      private

      attr_writer :here_client, :google_client
    end
  end
end
