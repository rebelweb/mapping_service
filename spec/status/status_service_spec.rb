# frozen_string_literal: true

require 'spec_helper'

module MappingService
  module Status
    RSpec.describe StatusService do
      it 'returns the version' do
        expect(described_class.new.call[:version]).to eq('0.2.0')
      end
    end
  end
end
