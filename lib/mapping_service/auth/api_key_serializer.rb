# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKeySerializer < Grape::Entity
      format_with(:iso_timestamp, &:iso8601)

      expose :description, documentation: { type: 'String', desc: 'Name of Key' }
      expose :active, documentation: { type: 'Boolean', desc: 'Key is enabled/disabled' }
      expose :admin, documentation: { type: 'Boolean', desc: 'Key provides admin privileges' }
      expose :geocoding, documentation: { type: 'Boolean', desc: 'Key has privileges to make geocode requests' }

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'DateTime', desc: 'Time the API Key was created' }
        expose :expires_at, documentation: { type: 'DateTime', desc: 'Time the API Key expires' }
      end
    end
  end
end
