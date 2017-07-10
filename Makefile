.PHONY: up provision clean reload

# Need to run ansible in 'make' instead of Vagrantfile
# so that we can be sure that all hosts are up
up:
	ssh-add ~/.vagrant.d/insecure_private_key
	vagrant up --provider=libvirt && make provision

# Does not rerun vagrant provisioning, just ansible.
# we run ansible from admin guest instead of host so that
# we can access guest DNS
provision:
		vagrant ssh node0 -c 'cd /vagrant && ./run_ansible.sh'

clean:
	vagrant destroy -f

reload: clean
	make up
