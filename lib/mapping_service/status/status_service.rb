# frozen_string_literal: true

module MappingService
  module Status
    class StatusService
      class << self
        def call
          new.call
        end
      end

      def call
        {
          version: MappingService::VERSION,
          available_providers: available_providers,
          default_provider: 'Here'
        }
      end

      private

      def available_providers
        providers = []

        providers << 'Google' unless ENV.fetch('GOOGLE_API_KEY', nil).empty?
        providers << 'Here' unless ENV.fetch('HERE_API_KEY', nil).empty?

        providers
      end
    end
  end
end
