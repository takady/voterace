require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Voterace
  class Application < Rails::Application
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc

    config.generators do |generator|
      generator.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      generator.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
