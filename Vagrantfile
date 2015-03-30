# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# dockerとNginxインストール
$script = <<SCRIPT
wget -qO- https://get.docker.com/ | sh
apt-get install -y nginx
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Forward keys from SSH agent rather than copypasta
  config.ssh.forward_agent = true

  config.vm.synced_folder "./files", "/working"

  config.vm.define :ubuntu, primary: true do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.network :forwarded_port, guest: 80, host: 10080
    ubuntu.vm.network :private_network, ip: "192.168.33.99"
  end

  config.vm.provision "shell", inline: $script
end
