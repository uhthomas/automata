package unwind_bootstrap

import "k8s.io/api/core/v1"

machineDeploymentList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "cluster.x-k8s.io/v1beta1"
		kind:       "MachineDeployment"
	}]
}

machineDeploymentList: items: [{
	metadata: {
		name:      "unwind-workers"
		namespace: "default"
	}
	spec: {
		clusterName: "unwind"
		replicas:    0
		selector: matchLabels: null
		template: spec: {
			bootstrap: configRef: {
				apiVersion: "bootstrap.cluster.x-k8s.io/v1alpha3"
				kind:       "TalosConfigTemplate"
				name:       "unwind-workers"
			}
			clusterName: "unwind"
			infrastructureRef: {
				apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
				kind:       "MetalMachineTemplate"
				name:       "unwind-workers"
			}
			version: "v1.26.2"
		}
	}
}]
