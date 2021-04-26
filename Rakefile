# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

task :webpack_rebuild do
  FileUtils.rm "tmp/cache/webpacker/last-compilation-digest-production"
  Rake::Task["webpacker:compile"].invoke
  system "overmind restart web"
end

task :reboot => :environment do
  puts "♻️ Rebooting Posture..."
  system "git pull"
  Rake::Task["db:migrate"].invoke
  FileUtils.rm "tmp/cache/webpacker/last-compilation-digest-production"
  system "overmind quit"
  Rake::Task["assets:precompile"].invoke
  system "overmind start -D"
end
