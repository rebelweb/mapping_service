# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKey
      include Mongoid::Document

      field :key, type: String
      field :description, type: String
      field :active, type: Boolean
      field :admin, type: Boolean
      field :geocoding, type: Boolean
      field :expires_at, type: DateTime
      field :created_at, type: DateTime

      def expired?
        return false if expires_at.nil?

        expires_at < Time.current
      end
    end
  end
end
