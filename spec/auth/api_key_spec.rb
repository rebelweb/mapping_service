# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKey do
      let(:key) { SecureRandom.hex(32) }
      let(:expires_at) { }

      it 'creates a key' do
        api_key = described_class.create(
          key: key,
          description: 'Sample',
          active: true,
          geocoding: true,
          admin: true,
          expires_at: Time.zone.now + 30.days,
          created_at: Time.zone.now
        )

        expect(api_key).to be_truthy
      end
    end
  end
end