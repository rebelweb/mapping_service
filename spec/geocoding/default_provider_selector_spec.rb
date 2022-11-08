# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Geocoding
    RSpec.describe DefaultProviderSelector do
      subject { described_class.new }

      before do
        allow(ENV).to receive(:fetch).and_return('')
      end

      it 'returns the value from the PREFERRED_PROVIDER env var' do
        allow(ENV).to receive(:fetch).with('PREFERRED_PROVIDER', nil).and_return('Google')
        allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('abc')

        expect(subject.call).to eq('Google')
      end

      it 'checks if the preferred provider is configured' do
        allow(ENV).to receive(:fetch).with('PREFERRED_PROVIDER', nil).and_return('Google')
        allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('')

        expect(subject.call).to_not eq('Google')
      end

      it "returns the first available provider if the preferred provider isn't configured" do
        allow(ENV).to receive(:fetch).with('PREFERRED_PROVIDER', nil).and_return('Google')
        allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('')
        allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('abc123')

        expect(subject.call).to eq('Here')
      end
    end
  end
end
