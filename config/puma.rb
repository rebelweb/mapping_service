# frozen_string_literal: true

workers 3
threads 2, 5

preload_app!

bind 'tcp://0.0.0.0:4000'
