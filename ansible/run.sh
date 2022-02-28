#!/bin/bash

# Instalamos dependencias de modulos del playbook
ansible-galaxy collection install community.general && ansible-galaxy collection install ansible.posix
# Lanzamos Playbook del deploy
ansible-playbook -i hosts playbooks/01_deploy_k8s.yml
