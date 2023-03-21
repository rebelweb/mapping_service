# frozen_string_literal: true

require './config/application'
require 'rack/attack'
require './config/middleware/rack_attack'

use Rack::Attack
use Rack::Static, urls: ['/swagger_ui']

run MappingService::Application
