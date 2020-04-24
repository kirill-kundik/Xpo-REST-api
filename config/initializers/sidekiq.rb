# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-scheduler'

rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'
redis_config = YAML.load_file(rails_root.to_s + '/config/redis.yml')
redis_config.merge! redis_config.fetch(rails_env, {})
redis_config.symbolize_keys!

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/12"
  }
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(
      File.expand_path('../crons/sending_statistics_scheduler.yml', __dir__)
    )
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/12"
  }
end