# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# https://github.com/mitchellh/vagrant/issues/2679

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/20141208/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.define "db_manage" do |db_manage|
    db_manage.vm.network "private_network", ip: "192.168.50.4", bridge: 'en0: Wi-Fi (AirPort)'
  end

  config.vm.define "flask_web" do |flask_web|
    flask_web.vm.network "private_network", ip: "192.168.50.5", bridge: 'en0: Wi-Fi (AirPort)'
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "images/base-image.yml"
    ansible.sudo = true
    ansible.inventory_path = 'inventory/vagrant'
    ansible.host_key_checking = false
    # user password is 'secret'
    ansible.extra_vars = { ansible_ssh_user: 'vagrant',
                           hostname: 'testhost',
                           user_password: '$6$rounds=100000$2onkEGH70mCJyS8o$MfJiOsct.wQ2dNCu0Gqz4rhRhqUDf2c9kXUoA2eQDhFLZ7T0IZ.BLHBJMHmqk3IrAsWNmd/NxlAe7ElY4CotO.',
                           configure_networking: false,
                           disable_admin_sudo_pass: true
                         }
  end
end
