# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Status Endpoints', type: :endpoint do
  def app
    MappingService::Application
  end

  it 'returns the application info' do
    get '/status'

    body = JSON.parse(last_response.body)

    expect(last_response.status).to eq(200)
    expect(body['version']).to eq('0.1.1')
  end
end
