# frozen_string_literal: true

module MappingService
  module Geocoding
    class GeocodingService
      attr_reader :geocode_retriever

      def initialize(geocode_retriever:)
        self.geocode_retriever = geocode_retriever
      end

      def call(query:)
        geocode_retriever.call(query: query)
      end

      private

      attr_writer :geocode_retriever
    end
  end
end
