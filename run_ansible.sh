#!/bin/bash

ansible-playbook --ssh-common-args="-o ForwardAgent=yes" -i ansible_inventory playbook.yml
