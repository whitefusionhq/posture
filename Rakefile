# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

task :webpack_rebuild do
  "tmp/cache/webpacker/last-compilation-digest-production".tap do |path|
    FileUtils.rm(path) if File.exist?(path)
  end
  Rake::Task["webpacker:compile"].invoke
  sh "overmind restart web"
end

task reboot: :environment do
  puts "♻️ Rebooting Posture..."
  sh "git pull"
  Rake::Task["db:migrate"].invoke
  "tmp/cache/webpacker/last-compilation-digest-production".tap do |path|
    FileUtils.rm(path) if File.exist?(path)
  end
  sh "overmind quit"
  Rake::Task["assets:precompile"].invoke
  sh "overmind start -D"
end
