# frozen_string_literal: true

module MappingService
  module Geocoding
    class ProviderResponseRepository
      def retrieve(query: , provider: )
        ProviderResponse.where(
          query: query,
          provider: provider
        ).last
      end
    end
  end
end
