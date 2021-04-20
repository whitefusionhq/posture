# frozen_string_literal: true

require "ruby2js/filter/functions"
require "ruby2js/filter/camelCase"
require "ruby2js/filter/return"
require "ruby2js/filter/esm"
require "ruby2js/filter/tagged_templates"

require "json"

module Ruby2JS
  class Loader
    def self.options
      # Change the options for your configuration here:
      {
        eslevel: 2021,
        include: [:class, :call],
        underscored_private: true,
        autoimports: {
          :ApplicationController => "controllers/application_controller",
          [:ApplicationElement]  => "application_element.js.rb",
          [:html, :css]          => "lit-element",
          [:render]              => "lit-html",
          :Toaster               => "lib/toaster.js.rb",
          :Daniel                => "lib/daniel.js.rb",
          :Elemental             => "lib/elemental.js.rb",
        },
      }
    end

    def self.process(source)
      Ruby2JS.convert(source, options).to_s
    end

    def self.process_with_source_map(source)
      conv = Ruby2JS.convert(source, options)
      {
        code: conv.to_s,
        sourceMap: conv.sourcemap,
      }.to_json
    end
  end
end
