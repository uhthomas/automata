package olm

import "k8s.io/api/core/v1"

#OLMConfigList: v1.#List & {
	apiVersion: "operators.coreos.com/v1"
	kind:       "OLMConfigList"
	items: [...{
		apiVersion: "operators.coreos.com/v1"
		kind:       "OLMConfig"
	}]
}

#OLMConfigList: items: [{metadata: name: "cluster"}]
