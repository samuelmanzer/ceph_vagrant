.PHONY: up load provision clean reload sync
.PHONY: mirror

# APT mirror used to make vagrant provisioning faster
mirror:
	docker run -d \
		   -v /mirror:/var/spool/apt-mirror \
		   -v `pwd`/mirror.list:/etc/apt/mirror.list \
		   -p 8080:80 \
		   --restart=always \
		   seterrychen/apt-mirror-http-server

up:
	ssh-add ~/.vagrant.d/insecure_private_key
	vagrant up --provider=libvirt

# Does not rerun vagrant provisioning, just ansible.
# we run ansible from admin guest instead of host so that
# we can access guest DNS
# Also need to run ansible in 'make' instead of Vagrantfile
# so that we can be sure that all hosts are up
provision: sync
	vagrant ssh node0 -c 'cd /vagrant && ./run_ansible.sh'

sync:
	vagrant rsync

load: up
	make provision

# 'vagrant destroy -f' will not work if workspace
# directory not there
clean:
	vagrant destroy -f

reload: clean
	make load
