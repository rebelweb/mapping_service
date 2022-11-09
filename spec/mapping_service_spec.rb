# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MappingService do
  it 'has a version number' do
    version = MappingService::VERSION
    version_parts = version.split('.')

    expect(version_parts[0]).to eq('0')
    expect(version_parts[1]).to eq('3')
  end
end
