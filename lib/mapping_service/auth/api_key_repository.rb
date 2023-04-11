# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKeyRepository
      def get_all
        ApiKey.all
      end

      def create params
        ApiKey.create(
          key: SecureRandom.hex(32),
          description: params[:description],
          geocoding: params[:geocoding],
          admin: params[:admin],
          expires_at: Time.zone.now + params[:expires_in].days,
          created_at: Time.zone.now
        )
      end

      def destroy key
        api_key = ApiKey.find_by(key: key)

        return if api_key.nil?

        api_key.destroy
      end
    end
  end
end
