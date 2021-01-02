# frozen_string_literal: true

Rails.autoloaders.each do |autoloader|
  autoloader.ignore("app/components/**/*.js.rb")
end
