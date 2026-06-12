package karma

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
	data: "karma.yaml": yaml.Marshal({
		history: rewrite: [{
			source: "(.*)"
			uri:    "http://vmsingle-vm.vm:8429"
		}]
	})
}]
