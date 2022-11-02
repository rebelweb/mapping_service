# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodingService
      attr_reader :geocode_retriever

      def initialize(geocode_retriever: GeocodeRetriever.new)
        self.geocode_retriever = geocode_retriever
      end

      def call(query:)
        cache = ProviderResponse.where(
          name: 'Here',
          query: query
        ).last

        response = cache

        unless cache
          response = geocode_retriever.call(query: query)

          ProviderResponse.create(
            query: query,
            provider: 'Here',
            response: response,
            created_at: Time.zone.now
          )
        end

        response
      end

      private

      attr_writer :geocode_retriever
    end
  end
end
