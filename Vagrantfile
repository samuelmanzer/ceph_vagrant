# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Inspired by this excellent guide:
# https://github.com/carmstrong/multinode-ceph-vagrant

CODENAME = "jessie"
SERVER_COUNT = 4
DEFAULT_GATEWAY="172.16.0.1"

Vagrant.configure("2") do |config|

  config.vm.box = "debian/#{CODENAME}64"

  # simplify; don't want to deal with NFS bidirectional sync
  # it requires sudo
  config.vm.synced_folder "./", "/vagrant", type: "rsync"

  # Needed for ansible/ceph-deploy
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # Use KVM for hardware accelerated virtualization
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
  end

  # Admin node
  config.vm.define "node0" do |admin|
      admin.vm.hostname = "node0"
      admin.vm.network "private_network", ip: "172.16.0.10"

      admin.vm.provision "shell", inline: "cat /vagrant/cluster_hosts >> /etc/hosts"

      # Install ansible
      admin.vm.provision "shell", inline: "echo 'deb http://#{DEFAULT_GATEWAY}:8080/ubuntu trusty main' > /etc/apt/sources.list"
      admin.vm.provision "shell", inline: "echo 'deb http://#{DEFAULT_GATEWAY}:8080/debian jessie main' >> /etc/apt/sources.list"
      admin.vm.provision "shell", inline: "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367"
      admin.vm.provision "shell", inline: "apt-get update && apt-get install -yq ansible"
  end

  # Other ceph servers
  (1..SERVER_COUNT-1).each do |i|
    config.vm.define "node#{i}" do |server|
      server.vm.hostname = "node#{i}"
      server.vm.network "private_network", ip: "172.16.0.#{10+i}"

      server.vm.provision "shell", inline: "cat /vagrant/cluster_hosts >> /etc/hosts"
    end
  end
end
