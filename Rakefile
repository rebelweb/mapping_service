# frozen_string_literal: true

require_relative './config/application'

Dir.glob('./lib/mapping_service/tasks/**/*.rake').each do |task|
  import "./#{task}"
end
