#!/bin/bash
# Añadimos usuario ansible como sudo - NOPASSWD
echo 'Creating ansible sudoers file on k8smaster'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8smaster "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
echo 'Creating ansible sudoers file on k8sworker'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8sworker "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
echo 'Creating ansible sudoers file on k8sworker2'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8sworker2 "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"


# Instalamos dependencias de modulos del playbook
ansible-galaxy collection install community.general && ansible-galaxy collection install ansible.posix
# Lanzamos Playbook del deploy
ansible-playbook -i hosts playbooks/01_deploy_k8s.yml
