# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

Dir.glob('lib/**/*.rb').each do |f|
  require "./#{f}"
end
