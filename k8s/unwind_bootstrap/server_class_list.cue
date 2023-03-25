package unwind_bootstrap

import "k8s.io/api/core/v1"

serverClassList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "ServerClass"
	}]
}

// serverClassList: items: [{
//  spec: configPatches: [... #patch]
// }]

serverClassList: items: [{
	metadata: name: "r430"
	spec: {
		qualifiers: systemInformation: productName: "PowerEdge R430"
		configPatches: []
	}
}, {
	metadata: name: "r720"
	spec: {
		qualifiers: systemInformation: version: "PowerEdge R720"
		configPatches: []
	}
}]
