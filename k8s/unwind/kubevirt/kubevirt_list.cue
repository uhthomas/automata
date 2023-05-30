package kubevirt

import (
	"k8s.io/api/core/v1"
	kubevirtv1 "kubevirt.io/api/core/v1"
)

#KubeVirtList: kubevirtv1.#KubeVirtList & {
	apiVersion: "kubevirt.io/v1"
	kind:       "KubeVirtList"
	items: [...{
		apiVersion: "kubevirt.io/v1"
		kind:       "KubeVirt"
	}]
}

#KubeVirtList: items: [{
	metadata: name: "kubevirt"
	spec: {
		certificateRotateStrategy: {}
		configuration: developerConfiguration: featureGates: []
		customizeComponents: {}
		imagePullPolicy: v1.#PullIfNotPresent
		workloadUpdateStrategy: {}
	}
}]
