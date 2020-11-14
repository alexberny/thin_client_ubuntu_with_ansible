#!/bin/bash
#
# Instal Ansible module
#
# curl -sL https://raw.githubusercontent.com/alexberny/thin_client_ubunut_with_ansible/main/install.sh | bash
#
# wget https://raw.githubusercontent.com/alexberny/thin_client_ubunut_with_ansible/main/install.sh -O - | bash

set -x
set -e
PATH=/usr/local/bin:$PATH

# update all
sudo apt update

# install git
sudo apt install git

# install ansible
sudo apt install ansible

# install psutil
sudo apt install python3-psutil

# install ansible galaxy dep
ansible-galaxy collection install community.general

# get ansible script
if [!-d thin_client_ubunut_with_ansible ]; then
    git clone https://github.com/alexberny/thin_client_ubunut_with_ansible.git
else
    cd thin_client_ubunut_with_ansible
    git pull
    cd ~
fi

# lunch ansible playbook
ansible-playbook thin_client_ubunut_with_ansible/thinclient-setup.yml --ask-become-pass