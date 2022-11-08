# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Status
    RSpec.describe StatusService do
      subject { described_class.new }

      before do
        allow(ENV).to receive(:fetch).and_return('')
      end

      it 'returns the version' do
        expect(subject.call[:version]).to eq('0.2.0')
      end

      describe 'available providers' do
        it 'returns Google when the Google Provider is configured' do
          allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('abc123')
          allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('')

          payload = subject.call

          expect(payload[:available_providers]).to include('Google')
          expect(payload[:available_providers]).to_not include('Here')
        end

        it 'returns Here when the Here Provider is configured' do
          allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('abc123')
          allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('')

          payload = subject.call

          expect(payload[:available_providers]).to include('Here')
          expect(payload[:available_providers]).to_not include('Google')
        end

        it 'includes both providers if both are configured' do
          allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('abc123')
          allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('abc123')

          payload = subject.call

          expect(payload[:available_providers]).to include('Here')
          expect(payload[:available_providers]).to include('Google')
        end
      end

      describe 'default provider' do
        it 'returns the default provider' do
          allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('abc123')

          expect(subject.call[:default_provider]).to eq('Here')
        end
      end
    end
  end
end
