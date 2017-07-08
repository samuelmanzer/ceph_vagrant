.PHONY: up clean reload

up:
	ssh-add ~/.vagrant.d/insecure_private_key
	vagrant up --provider=libvirt

clean:
	vagrant destroy -f

reload: clean
	make up
