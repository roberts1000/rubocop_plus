require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Start an IRB console with rubocop_plus loaded"
task :console do
  # exec "pry -r rubocop_plus -I ./lib"
  exec "irb -r rubocop_plus -I ./lib"
end
