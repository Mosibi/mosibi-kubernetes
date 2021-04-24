# Master
Settings used for Masters nodes which are installed using [mosibi-kubernetes](https://github.com/Mosibi/mosibi-kubernetes)

## Parameters
* `debug_master`: Enable or disable debugging the role (Default: `false`)
* `kubernetes_version`: Kubernetes version to install, for example `v1.20.6` (No default value, must be set)
* `apiserver_advertise_address`: Kubeadm setting, the apiserver ip address to advertise (Default: `<ip address of the first master node>`)
* `kubeadm_opts`: Extra Kubeadm settings (Default: `""`)
* `helm_version`: Helm version to use (Default: `v3.5.4`)
* `cilium_release`: Cilium version to use (Default: `1.9.6`)
* `install_hubble`: Enable or disable the installation of Hubble (Default: `true`)
* `install_traefik`: Enable or disable the installation of Traefik (Default: `true`)
* `install_metallb`: Enable or disable the installation of Metal-LB (Default: `true`)
* `metallb_pool_start`: Start address of the MetalLB pool (Default: `192.168.122.240`)
* `metallb_pool_end`: End address of the MetalLB pool (Default: `192.168.122.250`)
