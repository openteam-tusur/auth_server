require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Novosibirsk'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    config_file = Rails.root.join('config/settings.yml')
    if File.exist? config_file
      Settings.read(config_file)
    else
      raise "Please, create a #{config_file}!"
    end

    config.action_mailer.default_url_options = { host: Settings['app.host'], port: Settings['app.port'] }

    # Devise layout configuration
    config.to_prepare do
      Devise::SessionsController.layout "session"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "session" }
      Devise::ConfirmationsController.layout "session"
      Devise::UnlocksController.layout "session"
      Devise::PasswordsController.layout "session"
    end
  end
end
