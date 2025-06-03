# frozen_string_literal: true

source 'https://rubygems.org'

gem 'falcon', '~> 0.51'
gem 'sinatra', '~> 4.1'
gem 'zeitwerk', '~> 2.7'

group :test do
  gem 'faker', '~> 3.5'
  gem 'rspec', '~> 3.13'
end

group :local do
  gem 'localhost', '~> 1.5'
  gem 'rerun', '~> 0.14'
end

group :local, :test do
  gem 'rubocop', '~> 1.75', require: false
  gem 'rubocop-performance', '~> 1.25', require: false
  gem 'rubocop-rspec', '~> 3.6', require: false
end
