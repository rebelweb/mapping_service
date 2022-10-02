# frozen_string_liter: true

module MappingService
  module Status
    class StatusService
      class << self
        def call
          new.call
        end
      end

      def call
        {
          version: MappingService::VERSION
        }
      end
    end
  end
end
