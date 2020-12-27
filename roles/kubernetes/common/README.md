# Common
Common settings used for master and workers nodes which are installed using [mosibi-kubernetes](https://github.com/Mosibi/mosibi-kubernetes)

## Parameters
* `kubernetes_version`: Kubernetes version to install, for example `v1.20.1` (No default value, must be set)
* `network_plugin`: Configures the network plugin to use. Only cilium is supported (Default: `cilium`)
* `container_runtime_engine`: Configures the container runtime to use. Only crio is supported (Default: `crio`)
* `debug_common`: Enable or disable debugging the role (Default: `false`)