# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodeRetriever
      attr_reader :here_client

      def initialize(here_client: MappingService::Providers::Here::GeocodeClient.new)
        self.here_client = here_client
      end

      def call(query:)
        here_client.call(query: query)
      end

      private

      attr_writer :here_client
    end
  end
end
