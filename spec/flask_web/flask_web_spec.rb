require 'spec_helper'

describe 'flask_web' do

  include_examples 'aws_bootstrap::init'
  include_examples 'ubuntu_base::init'

  # System dependencies
  describe package('python-pip') do
    it { should be_installed }
  end

  describe package('virtualenv') do
    it { should be_installed.by('pip') }
  end

  # Application dependencies
  describe package('mysql-client') do
    it { should be_installed }
  end

  describe package('libmysqlclient-dev') do
    it { should be_installed }
  end

  describe package('libxml2-dev') do
    it { should be_installed }
  end

  describe package('libxslt1-dev') do
    it { should be_installed }
  end

  describe package('build-essential') do
    it { should be_installed }
  end

  describe package('libfreetype6-dev') do
    it { should be_installed }
  end

  describe package('python-imaging') do
    it { should be_installed }
  end

  describe package('python-dev') do
    it { should be_installed }
  end

  describe package('nginx') do
    it { should be_installed }
  end


  # Application config
  describe file('/var/www/app-web') do
    it {
      should be_directory
      should be_owned_by 'appweb'
    }
  end

  describe file("/var/www/app-web/app") do
    it { should be_directory }
  end

  describe file('/var/www/app-web/VERSION') do
    it { should be_file }
  end

  describe file('/var/venv/app-web') do
    it { should be_directory }
  end

  describe file('/var/www/app-web/app/config.py') do
    it { should be_file }
  end


  # nginx, supervisor, and gunicorn
  describe service('nginx') do
    it { should be_running }
  end

  describe file('/etc/nginx/sites-available/default') do
    it { should_not be_file }
  end

  describe file('/etc/nginx/sites-enabled/default') do
    it { should_not be_symlink }
  end

  describe file('/etc/nginx/sites-available/app') do
    it { should be_file }
  end

  describe file('/etc/nginx/sites-enabled/app') do
    it { should be_symlink }
  end

  describe port(80) do
    it { should be_listening.with('tcp')  }
  end

  describe service ('supervisor') do
    it { should be_running }
  end

  describe service ('app') do
    it { should be_running }
  end
end
