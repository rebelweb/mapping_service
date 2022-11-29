# frozen_string_literal: true

module MappingService
  module Geocoding
    class ProviderResponseRepository
      def initialize(model: ProviderResponse, valid_days: ENV.fetch('RESPONSE_VALID_FOR', nil))
        self.model = model
        self.valid_days = valid_days
      end

      def retrieve(query:, provider:)
        responses = model.where(
          query: query,
          provider: provider
        )

        responses = responses.and(filter_expired_results) unless filter_expired_results.nil?
        responses.last
      end

      def create(query:, provider:, response:)
        model.create(
          query: query,
          provider: provider,
          response: response,
          created_at: Time.zone.now
        )
      end

      private

      attr_accessor :model, :valid_days

      def filter_expired_results
        return if valid_days.nil?

        valid_before = Time.zone.now - valid_days.days
        ProviderResponse.where(:created_at.gte => valid_before)
      end
    end
  end
end
