require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

task :spec => 'spec:local'
task :provision => 'provision:local'
task :configure => 'configure:local'
task :default => :spec

namespace :spec do
  task :local do
    cluster_definition = YAML::load(File.open("cluster-definition.yml"))
    cluster_nodes = cluster_definition['cluster']

    cluster_nodes.each do |node|
      host = node['name']
      desc "Run serverspec tests to #{host}"
      task = host.to_sym
      role = node['role']
      RSpec::Core::RakeTask.new(task) do |t|
        ENV['TARGET_HOST'] = host
        t.pattern = "spec/#{role}/*_spec.rb"
      end
      Rake::Task[task].execute
    end 
  end
end

namespace :provision do
  task :local do
      exec('vagrant up')    
  end
end

namespace :configure do
  task :local do
      exec('vagrant provision')
  end
end