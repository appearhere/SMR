workers Integer(ENV.fetch('WEB_CONCURRENCY'))
threads_count = Integer(ENV.fetch('MAX_THREADS'))
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV.fetch('PORT')
environment ENV.fetch('RACK_ENV')

