 # frozen_string_literal: true

 module MappingService
  module Auth
    module AuthenticationHelper
      def authorize_admin!
        error!('Unauthorized', 401) unless current_user.try(:admin)
      end

      def authorize_geocoding!
        error!('Unauthorized', 401) unless current_user.try(:geocoding)
      end

      def current_user
        api_key = api_key_repository.find_by_key(headers['Api-Key'])
        api_key unless api_key.nil? || api_key.expired?
      end

      def api_key_repository
        @api_key_repository ||= ApiKeyRepository.new
      end
    end
  end
end
