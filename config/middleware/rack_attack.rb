# frozen_string_literal:  true

require 'json'

number_of_requests = ENV.fetch('NUMBER_OF_REQUESTS', nil)
period_of_requests = ENV.fetch('PERIOD_OF_REQUESTS', nil)

error_response = {
  error: 'Request limit reached, please try again later',
  limits: {
    number_of_requests: number_of_requests,
    period_of_requests: period_of_requests
  }
}.to_json

if number_of_requests && period_of_requests
  Rack::Attack.enabled = true
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: "redis://localhost:6379")

  Rack::Attack.throttle('requests by ip', limit: number_of_requests.to_i, period: period_of_requests.to_i) do |request|
    request.ip
  end

  Rack::Attack.throttled_responder = lambda do |request|
    [429, {}, [error_response]]
  end
end
