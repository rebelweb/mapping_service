# frozen_string_literal: true

class ApiKeysSerializer < Grape::Entity
  expose :keys, documentation: { description: 'Array of Keys' }
end
