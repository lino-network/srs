# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.network "forwarded_port", guest: 1935, host: 1935, auto_correct: true
  config.vm.network "forwarded_port", guest: 19351, host: 19351, auto_correct: true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "debian/stretch64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    cd /home/vagrant/
    git clone https://github.com/lino-network/srs.git
    cd srs
    cd trunk
    ./configure && make
  SHELL
end
