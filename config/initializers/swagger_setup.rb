# frozen_string_literal: true

require_relative '../../lib/mapping_service/status/status_response'

GrapeSwagger.model_parsers.register(::GrapeSwagger::Entity::Parser, MappingService::Status::StatusResponse)
