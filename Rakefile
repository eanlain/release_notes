require "bundler/gem_tasks"
require "cucumber"
require "cucumber/rake/task"
require "rspec/core/rake_task"

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec