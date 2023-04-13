# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Auth
    RSpec.describe ApiKey do
      let(:api_key) { build(:api_key) }

      describe '#expired?' do
        it 'returns true if the expired date is before to current time' do
          api_key.expires_at = Time.current - 1.day
          expect(api_key.expired?).to be_truthy
        end

        it 'returns false if the expires date is after the current time' do
          expect(api_key.expired?).to be_falsey
        end

        it "returns false if the key doesn't expire" do
          api_key.expires_at = nil
          expect(api_key.expired?).to be_falsey
        end
      end
    end
  end
end
