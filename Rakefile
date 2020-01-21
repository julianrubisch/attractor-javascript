# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task build: :assets

desc 'Preprocess assets'
task :assets do
  npm_output = `cd src/javascript/calculator && npm run build`
  puts npm_output
end
