package unwind_bootstrap

import "k8s.io/api/core/v1"

talosControlPlaneList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "controlplane.cluster.x-k8s.io/v1alpha3"
		kind:       "TalosControlPlane"
	}]
}

talosControlPlaneList: items: [{
	metadata: {
		name:      "unwind-cp"
		namespace: "default"
	}
	spec: {
		controlPlaneConfig: controlplane: {
			generateType: "controlplane"
			talosVersion: "v1.3.5"
			configPatches: [{
				op:    "add"
				path:  "/cluster/allowSchedulingOnControlPlanes"
				value: true
			}]
		}
		infrastructureTemplate: {
			apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
			kind:       "MetalMachineTemplate"
			name:       "unwind-cp"
		}
		replicas: 5
		version:  "v1.26.1"
	}
}]
