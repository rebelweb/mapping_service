# frozen_string_literal: true

Dir.glob('lib/**/*.rb').each do |f|
  require "./#{f}"
end
