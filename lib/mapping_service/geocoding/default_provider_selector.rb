# frozen_string_literal: true

module MappingService
  module Geocoding
    class DefaultProviderSelector
      def initialize(
        here_api_key: ENV.fetch('HERE_API_KEY', nil),
        google_api_key: ENV.fetch('GOOGLE_API_KEY', nil),
        preferred_provider: ENV.fetch('PREFERRED_PROVIDER', nil)
      )
        self.here_api_key = here_api_key
        self.google_api_key = google_api_key
        self.preferred_provider = preferred_provider
      end

      def call
        return nil unless configured_providers.any?

        configured_providers.include?(preferred_provider) ? preferred_provider : configured_providers.first
      end

      def configured_providers
        providers = []

        providers << 'Google' unless google_api_key.empty?
        providers << 'Here' unless here_api_key.empty?

        providers
      end

      private

      attr_accessor :here_api_key, :google_api_key, :preferred_provider
    end
  end
end
