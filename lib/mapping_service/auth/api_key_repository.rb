# frozen_string_literal: true

module MappingService
  module Auth
    class ApiKeyRepository
      # :reek:UtilityFunction
      def all
        ApiKey.all
      end

      # :reek:UtilityFunction
      def find_by_key(key)
        ApiKey.find_by(key: key)
      end

      # :reek:UtilityFunction
      def create(params)
        time = Time.current

        ApiKey.create!(
          key: SecureRandom.hex(32),
          description: params[:description],
          geocoding: params[:geocoding],
          admin: params[:admin],
          expires_at: time + params[:expires_in].days,
          created_at: time
        )
      end

      # :reek:UtilityFunction
      def destroy(key)
        api_key = ApiKey.find_by(key: key)

        return if api_key.nil?

        api_key.destroy
      end
    end
  end
end
