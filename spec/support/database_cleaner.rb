# frozen_string_literal: true

require 'database_cleaner-mongoid'

DatabaseCleaner[:mongoid].strategy = :deletion
