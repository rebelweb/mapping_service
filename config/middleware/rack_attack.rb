# frozen_string_literal:  true

require 'json'

number_of_requests = ENV.fetch('NUMBER_OF_REQUESTS', nil)
period_of_requests = ENV.fetch('PERIOD_OF_REQUESTS', nil)
cache_server = ENV.fetch('RACK_ATTACK_CACHE', nil)

error_response = {
  error: 'Request limit reached, please try again later',
  limits: {
    number_of_requests: number_of_requests,
    period_of_requests: period_of_requests
  }
}.to_json

if number_of_requests && period_of_requests && cache_server
  Rack::Attack.enabled = true
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: cache_server)

  Rack::Attack.throttle('requests by ip', limit: number_of_requests.to_i, period: period_of_requests.to_i, &:ip)

  Rack::Attack.throttled_responder = -> { [429, {}, [error_response]] }
end
