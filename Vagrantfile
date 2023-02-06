# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
    
  config.ssh.insert_key = false

  config.vm.define "web" do |web|
    web.vm.box="mark79/ubuntu"
    web.vm.box_version = "0.1.0"
    web.vm.hostname = "web.martin.bg"
    web.vm.provider :virtualbox do |vb|
            vb.name = "web"
        end
    web.vm.network "private_network", ip: "192.168.34.99"
    web.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    web.vm.provision "shell", path: "web.sh"
  end


  config.vm.define "db" do |db|
    db.vm.box="mark79/ubuntu"
    db.vm.box_version = "0.1.0"
    db.vm.hostname = "db.martin.bg"
    db.vm.provider :virtualbox do |vb|
            vb.name = "db"
        end
    db.vm.network "private_network", ip: "192.168.34.100"
    db.vm.provision "shell", path: "db.sh"
  end

end