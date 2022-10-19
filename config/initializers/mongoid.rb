# frozen_string_literal: true

require 'mongoid'

Mongoid.load!('./config/database.yml', ENV.fetch('APP_ENV', 'development'))
