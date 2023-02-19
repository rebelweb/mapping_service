# frozen_string_literal: true

require './config/application'

use Rack::Static, urls: ['/swagger_ui']

run MappingService::Application
