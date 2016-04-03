source 'https://rubygems.org'
ruby '2.3.0'

gem 'dotenv-rails'
gem 'rails', '~> 4.2.0'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml'
gem 'jbuilder', '~> 2.0'

gem 'bcrypt', '~> 3.1.7'
gem 'redis-rails'
gem 'nokogiri' # Parses the tvdb xml files
gem "active_model_serializers", "~> 0.9.0"

gem 'spring', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'hirb'
  gem 'guard'
  gem 'guard-minitest'
  gem 'minitest-reporters'
  gem 'rails_best_practices', '1.15.6'
end

group :production do
  gem 'newrelic_rpm'
end
