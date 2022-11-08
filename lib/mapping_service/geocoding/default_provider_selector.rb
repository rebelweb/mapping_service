# frozen_string_literal: true

module MappingService
  module Geocoding
    class DefaultProviderSelector
      def call
        return nil unless configured_providers.any?

        preferred = ENV.fetch('PREFERRED_PROVIDER', nil)
        configured_providers.include?(preferred) ? preferred : configured_providers.first
      end

      def configured_providers
        providers = []

        providers << 'Google' unless ENV.fetch('GOOGLE_API_KEY', nil).empty?
        providers << 'Here' unless ENV.fetch('HERE_API_KEY', nil).empty?

        providers
      end
    end
  end
end
