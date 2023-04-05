package csi_snapshotter

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	metadata: {
		name: "csi-snapshotter"
		labels: app: "csi-snapshotter"
	}
	spec: {
		ports: [{
			name: "dummy"
			port: 12345
		}]
		selector: app: "csi-snapshotter"
	}
}]
