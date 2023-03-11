# frozen_string_literal: true

module MappingService
  module Status
    class StatusEndpoints < Grape::API
      desc 'Gives Application Information' do
        success StatusResponse
      end
      get '/' do
        present StatusService.call, with: StatusResponse
      end
    end
  end
end
