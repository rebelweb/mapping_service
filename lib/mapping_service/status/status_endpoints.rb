# frozen_string_literal: true

module MappingService
  module Status
    class StatusEndpoints < Grape::API
      get '/' do
        StatusService.call
      end
    end
  end
end
