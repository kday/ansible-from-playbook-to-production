require 'rake'
require 'rspec/core/rake_task'

# Test a specific role:
# rake spec:mysql_master

task :default => :spec
task :spec => 'spec:all'

namespace :spec do
  task :all     => ['spec:db_manage', 'spec:flask_web']
  task :default => :all
  
  roles = [:db_manage, :flask_web]
  roles.each do |role|
    RSpec::Core::RakeTask.new(role) do |t|
      if !ENV['CI']
        ENV['TARGET_HOST'] = role.to_s
      end
      t.pattern = "spec/#{role}/*_spec.rb"
    end
  end
end
