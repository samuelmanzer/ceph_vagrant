.PHONY: up load provision clean reload
.PHONY: create_workspace copy_files

create_workspace:
	mkdir -p workspace

copy_files: create_workspace
	cp cluster_hosts workspace
	cp run_ansible.sh ansible_inventory playbook.yml workspace

up: copy_files
	ssh-add ~/.vagrant.d/insecure_private_key
	vagrant up --provider=libvirt

# Does not rerun vagrant provisioning, just ansible.
# we run ansible from admin guest instead of host so that
# we can access guest DNS
# Also need to run ansible in 'make' instead of Vagrantfile
# so that we can be sure that all hosts are up
provision: copy_files
		vagrant ssh node0 -c 'cd /vagrant && ./run_ansible.sh'

load: up
	make provision

# 'vagrant destroy -f' will not work if workspace
# directory not there
clean: create_workspace
	vagrant destroy -f
	rm -rf workspace

reload: clean
	make load
