source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in rubocop_plus.gemspec
gemspec

group :development do
  gem 'rspec_starter', "~> 2.0", require: false
end

group :development, :test do
  gem "bundler", "~> 2.0"
  gem "pry", "~> 0.14.1"
  gem "rake", "~> 13.0"
end

group :test do
  gem "rspec", "~> 3.12"
end
