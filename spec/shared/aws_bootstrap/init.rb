shared_examples 'aws_bootstrap::init' do
  describe port(22) do
    it { should be_listening }
  end

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /^PermitRootLogin no/ }
  end

  describe service('ssh') do
    it { should be_running }
  end

  describe user('appuser') do
    it { should exist }
    it { should have_home_directory '/home/appuser' }
    it { should have_login_shell '/bin/bash' }
    it { should have_authorized_key 'ssh-rsa <insert public key here> ' }
  end
end
