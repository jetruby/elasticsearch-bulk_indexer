# Don't push the gem to rubygems
require 'bundler/gem_tasks'
ENV['gem_push'] = 'false'

Rake::Task['release'].enhance do
  raise '`GEMGATE_AUTH` should be specified' unless ENV['GEMGATE_AUTH']
  spec = Gem::Specification::load(Dir.glob('*.gemspec').first)

  system "curl -F file=@pkg/#{spec.name}-#{spec.version}.gem -u #{ENV['GEMGATE_AUTH']} https://gemgate-universum.herokuapp.com"
end
