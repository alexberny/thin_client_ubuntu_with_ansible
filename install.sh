#!/bin/bash
#
# Instal Ansible module
#
# curl -sL  https://github.com/alexberny/install.sh | sudo bash
#

set -x
set -e
PATH=/usr/local/bin:$PATH

# update all
sudo apt update

# install git
sudo apt install git

# install ansible
sudo apt install ansible

# get ansible script
git clone https://github.com/alexberny/thin_client_ubunut_with_ansible.git

ansible-playbook thin_client_ubunut_with_ansible/thinclient-setup.yml --ask-become-pass