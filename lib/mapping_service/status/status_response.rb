# frozen_string_literal: true

module MappingService
  module Status
    class StatusResponse < Grape::Entity
      expose :version,
             documentation: { type: 'String', desc: 'Application version' }

      expose :available_providers,
             documentation: { type: 'String', is_array: true, desc: 'Available providers for data retreval' }

      expose :default_provider,
             documentation: { type: 'String', desc: "Provider to use if the provider isn't specified" }
    end
  end
end
