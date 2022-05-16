# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  os = "bento/centos-7"
  net_ip = "192.168.56"

  config.vm.define "salt-master", primary: true do |master_config|
    master_config.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = 1
      vb.name = "salt-master"
    end

    master_config.vm.box = "#{os}"
    master_config.vm.hostname = 'salt-master'
    master_config.vm.network "private_network", ip: "#{net_ip}.20"
    master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"

    master_config.vm.provision :salt do |salt|
      salt.master_config = "saltstack/etc/salt-master"
      salt.master_key = "saltstack/keys/salt-master.pem"
      salt.master_pub = "saltstack/keys/salt-master.pub"
      salt.minion_key = "saltstack/keys/salt-master.pem"
      salt.minion_pub = "saltstack/keys/salt-master.pub"
      salt.seed_master = {
                          "salt-minion1" => "saltstack/keys/salt-minion1.pub",
                          "salt-minion2" => "saltstack/keys/salt-minion2.pub"
                         }

      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = true
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp -x python3"
    end
  end


  [
    ["salt-minion1",    "#{net_ip}.21",    "512",    os ],
    ["salt-minion2",    "#{net_ip}.22",    "512",    os ],
  ].each do |vmname,ip,mem,os|
    config.vm.define "#{vmname}" do |minion_config|
      minion_config.vm.provider "virtualbox" do |vb|
        vb.memory = "#{mem}"
        vb.cpus = 1
        vb.name = "#{vmname}"
      end

      minion_config.vm.box = "#{os}"
      minion_config.vm.hostname = "#{vmname}"
      minion_config.vm.network "private_network", ip: "#{ip}"

      minion_config.vm.provision :salt do |salt|
        salt.minion_config = "saltstack/etc/#{vmname}"
        salt.minion_key = "saltstack/keys/#{vmname}.pem"
        salt.minion_pub = "saltstack/keys/#{vmname}.pub"
        salt.install_type = "stable"
        salt.verbose = true
        salt.colorize = true
        salt.bootstrap_options = "-P -c /tmp -x python3"
      end
    end
  end
end
