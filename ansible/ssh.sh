#!/bin/bash
echo 'Creating ansible sudoers file on k8smaster'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8smaster "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
echo 'Creating ansible sudoers file on k8sworker'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8sworker "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
echo 'Creating ansible sudoers file on k8sworker2'
    ssh -o "StrictHostKeyChecking no" -t ansible@k8sworker2 "sudo touch /etc/sudoers.d/ansible; echo 'ansible  ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
