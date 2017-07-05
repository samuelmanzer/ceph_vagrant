# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Inspired by this excellent guide:
# https://github.com/carmstrong/multinode-ceph-vagrant

CODENAME = "jessie"
SERVER_COUNT = 1

Vagrant.configure("2") do |config|

  config.vm.box = "debian/#{CODENAME}64"

  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # populate /etc/hosts on all VMs with all VM IPs/hostnames
  config.hostmanager.enabled = true

  # Cache APT packages and such - make Ceph install faster
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # Ceph admin node
  config.vm.define "node0" do |node0|
    admin.vm.hostname = "node0"
    admin.vm.network "private_network", ip: "172.16.0.10"
    admin.vm.provision "shell", inline: "apt-get install apt-transport-https"
    # Ceph install instructions from http://docs.ceph.com/docs/master/install/get-packages/
    admin.vm.provision "shell", inline: "wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add -"
    admin.vm.provision "shell", inline: "echo deb https://download.ceph.com/debian-jewel/ $(lsb_release -sc) main | tee /etc/apt/sources.list.d/ceph.list"
    admin.vm.provision "shell", inline: "DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq ntp ceph-deploy"
  end

  # Ceph servers
  (1..SERVER_COUNT).each do |i|
    config.vm.define "node#{i}" do |server|
      server.vm.hostname = "node#{i}"
      server.vm.network "private_network", ip: "172.16.0.#{i+10}"
    end
  end
end
