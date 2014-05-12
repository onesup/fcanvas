source 'https://rubygems.org'
gem 'rails', '4.0.0'
gem 'execjs'
gem 'therubyracer'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'fb-channel-file'
gem 'rack-facebook-signed-request', :git => 'git://github.com/cmer/rack-facebook-signed-request.git'
gem 'koala', '>= 1.7.0rc1'
gem 'simple_form', '>= 3.0.0'
gem 'useragent', '>= 0.2.1'
gem 'p3p'
gem 'omniauth'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'devise', '~> 3.1.0'
gem 'rack-iframe'
gem 'kaminari'
gem 'rack-cors', :require => 'rack/cors'
gem 'yajl-ruby'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'quiet_assets'
  gem 'sqlite3'
  gem 'pry'
  gem 'capistrano', '~> 2.15.4'
end

group :production do
  gem 'mysql2'
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem "database_cleaner"
  gem "email_spec"
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end
