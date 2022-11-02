# frozen_string_literal: true

module MappingService
  module Geocoding
    class ProviderResponseRepository
      def retrieve(query: , provider: )
        responses = ProviderResponse.where(
          query: query,
          provider: provider
        )

        responses = responses.and(filter_expired_results) unless filter_expired_results.nil?
        responses.last
      end

      private

      def filter_expired_results
        valid_days = ENV.fetch('RESPONSE_VALID_FOR', nil)

        return if valid_days.nil?

        valid_before = Time.zone.now - valid_days.days
        ProviderResponse.where(:created_at.gte => valid_before)
      end
    end
  end
end
