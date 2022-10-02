# frozen_string_liter: true

module MappingService
  module Status
    class StatusService
      def call
        {
          version: MappingService::VERSION
        }
      end
    end
  end
end
