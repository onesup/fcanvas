require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Fcanvas
  class Application < Rails::Application
    config.force_ssl = false
    config.time_zone = 'Asia/Seoul'
    config.i18n.default_locale = :ko_KR
    FACEBOOK_CONFIG = YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env]
    config.middleware.use Rack::Facebook::SignedRequest, app_id: FACEBOOK_CONFIG[:app_id], secret: FACEBOOK_CONFIG[:app_secret], inject_facebook: false
    config.action_dispatch.default_headers = {
      'X-XSS-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff'
    }
  end
end
