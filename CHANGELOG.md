# Changelog mosibi-kubernetes

## November 12, 2023

* Replace Centos 8 with Rocky Linux 9
* Update Helm to version 3.13.2
* Update Cilium to version 1.14.3
* MetalLB and Traefik are not installed by default anymore
  * In the future mosibi-kubernetes will move to the Cilium interal load balancer and Gateway API
* Remove compatibility with older distributions
* Use FQCN for all Ansible modules calls
* Drop Calico support
* Drop Docker runtime support
* YUM repos for Kubernetes and CRI-O are changed to https://pkgs.k8s.io/
  * CRI-O packages are now from the pre-release repo! This will changed when the stable CRI-O repo is available on https://pkgs.k8s.io/