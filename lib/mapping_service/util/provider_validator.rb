# frozen_string_literal: true

class Provider < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params)
    value = params[attr_name]

    return if configured_providers.include?(value.downcase)

    raise Grape::Exceptions::Validation.new(
      params: [@scope.full_name(attr_name)],
      message: 'is not a valid provider'
    )
  end

  private

  def configured_providers
    MappingService::Geocoding::DefaultProviderSelector.new.configured_providers.map(&:downcase)
  end
end
