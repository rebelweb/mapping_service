# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Status
    RSpec.describe StatusResponse do
      subject { described_class.represent(status_info) }

      let(:status_info) do
        {
          version: '1.0.0',
          available_providers: %w[Here Google],
          default_provider: 'Google',
          extra_info: 'Data'
        }
      end

      let(:json) { JSON.parse(subject.to_json) }

      it 'only shows version, available_providers, and default_provider' do
        expect(json.keys).to eq(%w[version available_providers default_provider])
      end

      it 'renders the version' do
        expect(json['version']).to eq('1.0.0')
      end

      it 'renders the available_providers' do
        expect(json['available_providers']).to eq(%w[Here Google])
      end

      it 'renders the default provider' do
        expect(json['default_provider']).to eq('Google')
      end
    end
  end
end
