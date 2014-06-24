listen 3000
worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout 30
preload_app true
working_directory '/var/www/movie-tell.com'
stderr_path '/var/log/unicorn/movie-tell.com-error.log'
stdout_path '/var/log/unicorn/movie-tell.com-access.log'

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing.  Wait for master to send QUIT.'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end