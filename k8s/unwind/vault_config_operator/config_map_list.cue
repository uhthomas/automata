package vault_config_operator

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	metadata: name:                         "vault-config-operator-manager-config"
	data: "controller_manager_config.yaml": yaml.Marshal({
		apiVersion: "controller-runtime.sigs.k8s.io/v1alpha1"
		kind:       "ControllerManagerConfig"
		health: healthProbeBindAddress: ":8081"
		metrics: bindAddress:           "127.0.0.1:8080"
		webhook: port:                  9443
		leaderElection: {
			leaderElect:  true
			resourceName: "3d7d3a62.redhat.io"
		}
	})
}]
