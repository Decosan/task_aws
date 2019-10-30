source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem "aws-sdk-s3", require: false
gem "chartkick"
gem 'simple_calendar', '~> 2.0'
gem 'mini_magick', '~> 4.8'
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
  gem 'rubocop'
  gem 'rails-controller-testing'
end

group :development do
  gem 'letter_opener_web'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors' # render better error page
  gem 'binding_of_caller' # use irb on better_errors
  gem 'pry-rails' # use binding.pry
  gem 'pry-byebug' # use step over on binding.pry
  gem 'pry-doc' # extend pry document support
  gem 'rubocop'
  gem 'rails_best_practices'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'webdrivers'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'launchy'
gem 'rails-i18n'
gem 'kaminari'