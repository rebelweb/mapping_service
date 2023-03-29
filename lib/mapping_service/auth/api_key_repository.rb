# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKeyRepository
      def get_all
        ApiKey.all
      end
    end
  end
end
