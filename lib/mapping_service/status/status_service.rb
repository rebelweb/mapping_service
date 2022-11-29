# frozen_string_literal: true

module MappingService
  module Status
    class StatusService
      def initialize(default_provider_selector: MappingService::Geocoding::DefaultProviderSelector.new)
        self.default_provider_selector = default_provider_selector
      end

      class << self
        def call
          new.call
        end
      end

      def call
        {
          version: MappingService::VERSION,
          available_providers: default_provider_selector.configured_providers,
          default_provider: default_provider_selector.call
        }
      end

      private

      attr_accessor :default_provider_selector
    end
  end
end
