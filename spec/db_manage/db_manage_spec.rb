require 'spec_helper'

describe 'db_manage' do

  include_examples 'aws_bootstrap::init'
  include_examples 'ubuntu_base::init'

  # System dependencies
  describe package('mysql-client') do
    it { should be_installed }
  end

  describe package('python-pip') do
    it { should be_installed }
  end

  describe package('virtualenv') do
    it { should be_installed.by('pip') }
  end

  # Application config
  describe file('/var/www/app-db') do
    it {
      should be_directory
      should be_owned_by 'appdb'
    }
  end

  describe file('/var/www/app-db/appdb') do
    it { should be_directory }
  end

  describe file('/var/www/app-db/VERSION') do
    it { should be_file }
  end

  describe file('/var/venv/app-db') do
    it { should be_directory }
  end

  describe user ('appdb') do
    it { should exist }
  end

  describe user('appuser') do
    it { should belong_to_group 'appdb' }
  end
end
