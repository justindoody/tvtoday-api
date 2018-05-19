source 'https://rubygems.org'
ruby '~> 2.5.1'

gem 'dotenv-rails', '~> 2.1'
gem 'rails', '~> 4.2.0'
gem 'pg', '~> 0.18.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 4.1'
gem 'coffee-rails', '~> 4.1'
gem 'jquery-rails' #, '~> 4.1'
gem 'turbolinks', '~> 2.5'
gem 'haml', '~> 4.0'
gem 'sprockets', '~> 3.0'

gem 'lockup', '~> 1.3'
gem 'redis-rails', '~> 4.0'
gem 'nokogiri', '~> 1.8' # Parses the tvdb xml files
gem 'active_model_serializers', '~> 0.10'

gem 'rollbar', '~> 2.11'

gem 'bootsnap', require: false
gem 'spring', group: :development

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
  gem 'ffaker', '~> 2.0'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'capybara'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'selenium-webdriver', '~> 2.53.0'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'hirb'
end

group :production do
  gem 'newrelic_rpm', '~> 3.9'
end
