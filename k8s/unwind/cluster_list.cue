package unwind

import "k8s.io/api/core/v1"

clusterList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "cluster.x-k8s.io/v1beta1"
		kind:       "Cluster"
	}]
}

clusterList: items: [{
	metadata: {
		name:      "unwind"
		namespace: "default"
	}
	spec: {
		clusterNetwork: {
			pods: cidrBlocks: ["10.244.0.0/16"]
			services: cidrBlocks: ["10.96.0.0/12"]
		}
		controlPlaneRef: {
			apiVersion: "controlplane.cluster.x-k8s.io/v1alpha3"
			kind:       "TalosControlPlane"
			name:       "unwind-cp"
		}
		infrastructureRef: {
			apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
			kind:       "MetalCluster"
			name:       "unwind"
		}
	}
}]
