source "https://rubygems.org"
ruby "2.5.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootsnap", require: false
gem "bulk_insert"
gem "devise", github: "plataformatec/devise"
gem "flipper"
gem "flipper-active_record"
gem "geocoder"
gem "pg", "~> 0.18"
gem "puma", "~> 3.12"
gem "rails", "5.2.0"
gem "sass-rails", "~> 5.0"
gem "sentry-raven"
gem "simple_form", "4.0.0"
gem "svgeez"
gem "textacular", github: "textacular/textacular"
gem "uglifier", ">= 1.3.0"
gem 'scenic'
gem 'rack-cors'

# https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-nav"
  gem "faker"
end

group :development do
  gem "debase", "0.2.2.beta14"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "ruby-debug-ide"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "rubocop"
  gem "rubocop-rspec"
end

group :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
end
