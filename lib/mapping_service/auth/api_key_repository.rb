# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKeyRepository
      def get_all
        ApiKey.all
      end

      def destroy key
        api_key = ApiKey.find_by(key: key)

        return if api_key.nil?

        api_key.destroy
      end
    end
  end
end
