require "rubocop_plus/version"
require "rubocop_plus/core_ext/string"
require "rubocop"
# require "rubocop-performance"
# require "rubocop-rails"

# Setup pry for development when running "rake console". Guard against load
# errors in production (since pry is not a runtime dependency in the .gemspec)
# rubocop:disable Lint/SuppressedException
begin
  require "pry"
rescue LoadError
end
# rubocop:enable Lint/SuppressedException
