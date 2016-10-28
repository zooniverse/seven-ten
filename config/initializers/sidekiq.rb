require 'redis'
require 'sidekiq'

redis_config = YAML.load_file('config/redis.yml')[Rails.env].symbolize_keys

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

require 'sidekiq/web'
sidekiq_admin = YAML.load_file 'config/sidekiq_admin.yml'
Sidekiq::Web.use Rack::Auth::Basic do |name, password|
  name.present? &&
  password.present? &&
  name == sidekiq_admin['sidekiq_admin_name'] &&
  password == sidekiq_admin['sidekiq_admin_password']
end unless Rails.env.test? || Rails.env.development? || Rails.env.docker_development?

# preload autoloaded workers
Dir[Rails.root.join('app/workers/**/*.rb')].sort.each do |path|
  name = path.match(/workers\/(.+)\.rb$/)[1]
  name.classify.constantize unless path =~ /workers\/concerns/
end

unless Rails.env.test?
  require 'sidekiq-cron'
  schedule = Rails.root.join 'config/worker_schedule.yml'
  Sidekiq::Cron::Job.load_from_array(YAML.load_file(schedule)) if schedule.exist?
end
