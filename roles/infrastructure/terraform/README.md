# Terraform
Install virtual machines using Terraform and libvirt

## Parameters
* `domain`: Domain name for the virtual machine (Default: `example.com`)
* `master_count`: Number of master nodes to create (Default: `1`)
* `worker_count`: Number of worker nodes to create (Default: `3`)
* `installation_image`: Image used to install the nodes (Default: `https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2`)
* `user`: Dictionary with user information for the default user which is created on all nodes
  * `name`:  User name (Default: `Username from user who executes the playbook`)
  * `gecos`: Gecos information (Default: `Gecos from user who executes the playbook`) 
  * `group`: Group name (Default: `same as name`)
  * `ssh_pub_key`: Public key for the user (Default: `$HOME/.ssh/id_rsa.pub from user who executes the playbook`)
* `tf_binary_path`: Path to the terraform binary (Default: `False`)
* `debug_terraform`: Enable or disable debugging the role (Default: `false`)

## Dependencies
* Terraform: https://www.terraform.io/downloads.html
* Libvirt provider for Terraform: https://github.com/dmacvicar/terraform-provider-libvirt#installing


## Terraform internals
The Ansible module [terraform](https://docs.ansible.com/ansible/latest/collections/community/general/terraform_module.html) is used to install the virtual infrastructure together with the [libvirt provider](https://github.com/dmacvicar/terraform-provider-libvirt) for Terraform. The Terraform state is saved in the directory mosibi-kubernetes/roles/infrastructure/terraform/tf-data.

### Remove the installed virtual systems
If you need to remove the virtual infrastructure created with this Ansible role, change to the Terraform state directory (mosibi-kubernetes/roles/infrastructure/terraform/tf-data) and execute the following command, with the right values for the variables. The `installation_image` variable must be set, but is not used during removal, so the /dev/null value is okay.

```lang=shell
  terraform destroy \
    -auto-approve \
    -var 'domain=example.com' \
    -var 'installation_image=/dev/null' \
    -var 'worker_count=4' \
    -var 'master_count=1'
```