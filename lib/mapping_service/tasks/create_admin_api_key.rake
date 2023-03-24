# frozen_string_literal: true

require 'securerandom'

namespace :mapping_service do
  task :create_admin_api_key do
    puts 'Creating Admin API Key'

    key = SecureRandom.hex(64)
    expires = Time.zone.now + 365.days

    MappingService::Auth::ApiKey.create(
      key: key,
      description: 'Default Admin API Token',
      admin: true,
      geocoding: true,
      active: true,
      created_at: Time.zone.now,
      expires_at: expires
    )

    puts "Admin Key: #{key}, Expires: #{expires.strftime('%Y-%m-%d')}"
  end
end
