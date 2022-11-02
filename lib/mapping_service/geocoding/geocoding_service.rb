# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodingService
      attr_reader :geocode_retriever

      def initialize(geocode_retriever: GeocodeRetriever.new,
        repository: ProviderResponseRepository.new)
        self.geocode_retriever = geocode_retriever
        self.provider_response_repository = repository
      end

      def call(query:)
        cache = provider_response_repository.retrieve(
          query: query,
          provider: 'Here'
        )

        response = cache

        unless cache
          response = geocode_retriever.call(query: query)

          provider_response_repository.create(
            query: query,
            provider: 'Here',
            response: response,
          )
        end

        response
      end

      private

      attr_reader :provider_response_repository
      attr_writer :geocode_retriever, :provider_response_repository
    end
  end
end
