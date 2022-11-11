# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodingService
      def initialize(geocode_retriever: GeocodeRetriever.new,
                     repository: ProviderResponseRepository.new,
                     default_provider_selector: DefaultProviderSelector.new,
                     response_unifier: ProviderResponseUnifier.new)
        self.geocode_retriever = geocode_retriever
        self.provider_response_repository = repository
        self.default_provider_selector = default_provider_selector
        self.response_unifier = response_unifier
      end

      def call(query:, provider: nil)
        selected_provider = provider.blank? ? default_provider_selector.call : provider

        response = provider_response_repository.retrieve(
          query: query,
          provider: selected_provider
        )

        response = save_to_cache(query: query, provider: selected_provider) if response.nil?
        response_unifier.call(response.response, response.provider, response.created_at)
      end

      private

      attr_accessor :provider_response_repository, :geocode_retriever, :default_provider_selector, :response_unifier

      def save_to_cache(query:, provider:)
        response = geocode_retriever.call(query: query, provider: provider)

        provider_response_repository.create(
          query: query,
          provider: provider,
          response: response
        )
      end
    end
  end
end
