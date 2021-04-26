schedule_file = "config/schedule.yml"

Redis.exists_returns_integer = false

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
