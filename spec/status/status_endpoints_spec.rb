# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Status Endpoints', type: :endpoint do
  def app
    MappingService::Application
  end

  it 'returns the application info' do
    allow(ENV).to receive(:fetch).with('GOOGLE_API_KEY', nil).and_return('123')
    allow(ENV).to receive(:fetch).with('HERE_API_KEY', nil).and_return('')

    get '/status'

    body = JSON.parse(last_response.body)

    expect(last_response.status).to eq(200)
    expect(body['version']).to eq('0.2.0')
    expect(body['available_providers']).to eq(['Google'])
  end
end
