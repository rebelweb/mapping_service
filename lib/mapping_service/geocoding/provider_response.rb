# frozen_string_literal: true

class ProviderResponse
  include Mongoid::Document

  field :query, type: String
  field :provider, type: String
  field :response, type: Hash
  field :created_at, type: DateTime
end
