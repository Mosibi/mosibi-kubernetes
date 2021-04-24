# Control
Configure a control system which can be used to install Kubernetes from, using [mosibi-kubernetes](https://github.com/Mosibi/mosibi-kubernetes)

## Parameters
* `kubernetes_version`: Kubernetes version to install, for example `v1.20.6` (No default value, must be set)
* `kubectl_on_control_host`: Wether or not to install kubectl on the control host (Default: `true`)
* `helm_on_control_host`: Wether or not to install helm on the control host (Default: `false`)
* `debug_control`: Enable or disable debugging the role (Default: `false`)
