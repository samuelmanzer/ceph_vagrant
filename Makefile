.PHONY: up load provision clean reload install

up:
	ssh-add ~/.vagrant.d/insecure_private_key
	vagrant up --provider=libvirt

# Does not rerun vagrant provisioning, just ansible.
# we run ansible from admin guest instead of host so that
# we can access guest DNS
# Also need to run ansible in 'make' instead of Vagrantfile
# so that we can be sure that all hosts are up
provision:
		vagrant ssh node0 -c 'cd /vagrant && ./run_ansible.sh'

load: up
	make provision

clean:
	vagrant destroy -f

reload: clean
	make load
