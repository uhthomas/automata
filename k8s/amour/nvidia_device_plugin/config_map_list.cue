package nvidia_device_plugin

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
	data: "config.yaml": yaml.Marshal({
		version: "v1"
		sharing: timeSlicing: resources: [{
			name:     "nvidia.com/gpu"
			replicas: 5
		}]
	})
}]
