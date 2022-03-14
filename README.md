# Introduction

This section aims to describe the solution developed to automate the deployment of a Kubernetes Clustered service created within a Cloud environment.
For this project, the following technologies are to be used:
* Azure: As Cloud provider where we will deploy our infrastructure in the cloud.
* Terraform: As an IaaC tool to deploy the necessary resources in our Cloud provider.
* Centos 8 Stream Free: As the operating system of the machines that we deploy in Azure. (Version 1.2019.0810, Publisher: “Cognosys”)
* Ansible: As a tool to provision and automate the deployment of Kubernetes in the resources deployed in Azure. Also a posteriori, to automate the deployment of the application within the workers.
* Kubernetes: As an orchestration tool for the pods and services that we will deploy within the workers. As container engine of the same, we will use CRI-O.
* Percona XtraDB Cluster: As a MySQL high availability service under the same NFS share of the master, automatically deployed in Kubernetes.

# First local steps to init deploying

* Ansible => 2.9 installed.
* Python3 => 3.6 installed.
* Have a local user created called Ansible, with sudo permissions ALL=(ALL) NOPASSWD:ALL.
* An ssh-keygen must be performed beforehand to generate the key pair.
* Download the repository in a path where the Ansible user is the owner, and has write and execute permissions. In our case we have used  /dat/Github/CP2/ (All commands should be runned by Ansible user)

# Infraestructure creation in Azure with Terraform

Inside /terraform with Ansible user execute:
```console
ansible@BENDER /dat/github/CP2/terraform
terraform init
```
And when terraform generates the TFState:

```console
ansible@BENDER /dat/github/CP2/terraform
terraform apply
```
# Kubernetes deployment with Ansible

Modify the ips of /etc/hosts by those created in azure (or from our inventory /ansible/hosts)
 
20.224.207.147  k8smaster
20.224.207.18   k8sworker
20.126.74.245   k8sworker2

the ip's change every time we destroy the environment.

run run.sh script  from /ansible.
This script will take care of giving NOPASSWD:ALL permissions to remote machines, install ansible.galaxy dependencies and run the initial playbook.

After about 10 minutes we should have our kubernetes cluster deployed and a Percona XtraDB Cluster pods ready to work.

We can check the acces to then with:
mysql -hk8sworker -uroot -p -P30036 -e "select @@hostname;"
mysql -hk8sworker2 -uroot -p -P30036 -e "select @@hostname;"# CP2
