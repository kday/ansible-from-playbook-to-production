shared_examples 'ubuntu_base::init' do
  describe package('unattended-upgrades') do
    it { should be_installed }
  end

  describe package('ufw') do
    it { should be_installed }
  end

  describe package('htop') do
    it { should be_installed }
  end

  describe package('ruby') do
    it { should be_installed }
  end

  describe package('emacs') do
    it { should be_installed }
  end

  describe port(22) do
    it { should be_listening }
  end

  describe file('/etc/security/limits.conf') do
    its(:content) { should match /\\* soft nofile 512000/ }
    its(:content) { should match /\\* hard nofile 512000/ }
    its(:content) { should match /root soft nofile 512000/ }
    its(:content) { should match /root hard nofile 512000/ }
  end

  describe file('/etc/pam.d/common-session') do
    its(:content) { should match /session required pam_limits.so/ }
  end

  describe service('ufw') do
    it { should be_enabled }
  end

  describe file('/etc/timezone') do
    its(:content) { should match /America\/New_York\n/ }
  end

  describe user('scout') do
    it { should exist }
    it { should belong_to_group 'scout' }
  end

  describe package('scout') do
    it { should be_installed.by('gem') }
  end
end
