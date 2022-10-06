# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

ENV['APP_ENV'] ||= 'development'

Dir.glob('config/initializers/**/*.rb').each do |f|
  require "./#{f}"
end

Dir.glob('lib/**/*.rb').each do |f|
  require "./#{f}"
end
