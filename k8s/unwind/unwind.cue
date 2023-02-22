import "encoding/yaml"

apiVersion: "v1"
items: [{
	apiVersion: "cluster.x-k8s.io/v1beta1"
	kind:       "Cluster"
	metadata: {
		name:      "unwind"
		namespace: "default"
	}
	spec: {
		clusterNetwork: {
			pods: cidrBlocks: [
				"10.244.0.0/16",
			]
			services: cidrBlocks: [
				"10.96.0.0/12",
			]
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
}, {
	apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
	kind:       "MetalCluster"
	metadata: {
		name:      "unwind"
		namespace: "default"
	}
	spec: controlPlaneEndpoint: {
		host: "unwind.starjunk.net"
		port: 6443
	}
}, {
	apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
	kind:       "MetalMachineTemplate"
	metadata: {
		name:      "unwind-cp"
		namespace: "default"
	}
	spec: template: spec: serverClassRef: {
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "ServerClass"
		name:       "any"
	}
}, {
	apiVersion: "controlplane.cluster.x-k8s.io/v1alpha3"
	kind:       "TalosControlPlane"
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
}, {
	apiVersion: "bootstrap.cluster.x-k8s.io/v1alpha3"
	kind:       "TalosConfigTemplate"
	metadata: {
		name:      "unwind-workers"
		namespace: "default"
	}
	spec: template: spec: {
		generateType: "join"
		talosVersion: "v1.3.5"
	}
}, {
	apiVersion: "cluster.x-k8s.io/v1beta1"
	kind:       "MachineDeployment"
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
			version: "v1.26.1"
		}
	}
}, {
	apiVersion: "infrastructure.cluster.x-k8s.io/v1alpha3"
	kind:       "MetalMachineTemplate"
	metadata: {
		name:      "unwind-workers"
		namespace: "default"
	}
	spec: template: spec: serverClassRef: {
		apiVersion: "metal.sidero.dev/v1alpha1"
		kind:       "ServerClass"
		name:       "any"
	}
}]
kind: "List"
metadata: resourceVersion: ""
