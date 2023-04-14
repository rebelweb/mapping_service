# frozen_string_literal: true

FactoryBot.define do
  factory :api_key, class: MappingService::Auth::ApiKey do
    key { SecureRandom.hex(32) }
    description { 'Sample Key' }
    admin { true }
    geocoding { true }
    active { true }
    expires_at { Time.current + 90.days }
    created_at { Time.current }
  end
end
