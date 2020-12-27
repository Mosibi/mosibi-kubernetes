# mosibi-kubernetes
This project contains several Ansible roles to create an virtual infrastructure and install Kubernetes on top of it. The focus is on using [CRI-O](https://cri-o.io/) as the container runtime and [Cilium](https://cilium.io/) for network connectivity and security although other container runtime engines and container network interfaces are also possible.

The Ansible role `infrastructure` is available to install a cluster of virtual machines and role `kubernetes` and its sub-roles will install and configure the Kubernetes cluster on (virtual) machines. After installation you will have a Kubernetes cluster with the following components:

* [CRI-O](https://cri-o.io): Container runtime engine. Optional it is also possible to use Docker as a CRE
* [Cilium](https://cilium.io): Cilium provides secure networking and uses [eBPF](https://ebpf.io) to enforce policies and replaces the need for kube-proxy.
* [Traefik](https://traefik.io): Traefik is a HTTP reverse proxy and load balancer that makes deploying microservices easy
* [MetalLB](https://metallb.universe.tf): MetalLB is a load-balancer implementation for bare metal (and virtual) Kubernetes clusters, using standard routing protocols.

This project is tested with CentOS 8, it will probably also run with CentOS 7. There are hooks and some preliminary code for docker as container runtime engine and calico are network plugin, but be aware that those are not tested and only provided as an example.

## Create the infrastructure
This **optional** step can be used to create a virtual infrastructure where Kubernetes can be installed on. By default it will create five virtual systems, one control host, one master and three workers. The control host is a host where the second part of the installation, installing the Kubernetes cluster, can be executed from. By using a control host, your workstation will not be tainted with software needed for the installation.

    ansible-playbook -i localhost, playbook-install-infrastructure.yml

### Custom configuration
The `infrastructure/terraform` role support several parameters to change the configuration of the hosts, see [roles/infrastructure/terraform/README.md](roles/infrastructure/terraform/README.md). Those values can be placed in the file *group_vars/all/infrastructure.yml*, please be aware that the parameter `user.ssh_pub_key` **must be set**, otherwise you can't login in to the hosts after the installation.

## Prepare the control host
This is also an **optional** step, the control host is the host from where the Kubernetes installation is instantiated and on which several extra (ansible) packages are installed which are used during and after the installation of Kubernetes. For example the `kubectl` binary will be downloaded and configured for the user running the playbook

    ansible-playbook -i inventory playbook-prepare-controlhost.yml

### Inventory
When the `infrastructure` role is used, the file *inventory* is present, else you need to create it yourself, see the file *inventory.example* for an example.

### Sync only
To speed up runtime, the playbook `playbook-prepare-controlhost.yml` supports the tag `sync` to only execute the synchronization instead of the complete playbook.

    ansible-playbook -i inventory playbook-prepare-controlhost.yml --tags sync

## Install Kubernetes
After installing the nodes, with or without the `infrastructure` role, the installation of the cluster can be executed. If a separate control host is used, execute it from the that host instead of your workstation

    ansible-playbook -i inventory playbook-install-kubernetes.yml

### Inventory
When the `infrastructure` role is used, the file *inventory* is present, else you need to create it yourself, see *inventory.example*. 

### Custom configuration
The subroles under Kubernetes, support several parameters, to set for example the Kubernetes version which must be used, see the README.md files in those subroles for more information and when needed, edit the file *group_vars/all/kubernetes.yml* to change the default values for a parameter.
