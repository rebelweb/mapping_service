# frozen_string_literal: true

min_threads = ENV.fetch('PUMA_MIN_THREADS', 2)
max_threads = ENV.fetch('PUMA_MAX_THREADS', 5)

workers ENV.fetch('PUMA_WORKERS', 3)
threads min_threads, max_threads

preload_app!

bind 'tcp://0.0.0.0:4000'
