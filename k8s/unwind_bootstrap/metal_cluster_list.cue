package unwind_bootstrap

import "k8s.io/api/core/v1"

metalClusterList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
		kind:       "MetalCluster"
	}]
}

metalClusterList: items: [{
	metadata: {
		name:      "unwind"
		namespace: "default"
	}
	spec: controlPlaneEndpoint: {
		host: "unwind.starjunk.net"
		port: 6443
	}
}]
