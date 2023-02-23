package unwind

import "k8s.io/api/core/v1"

metalMachineTemplateList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
		kind:       "MetalMachineTemplate"
	}]
}

metalMachineTemplateList: items: [{
	metadata: {
		name:      "unwind-cp"
		namespace: "default"
	}
	spec: template: spec: serverClassRef: {
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "ServerClass"
		name:       "any"
	}
}]
