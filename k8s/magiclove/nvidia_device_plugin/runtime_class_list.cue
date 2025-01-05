package nvidia_device_plugin

import nodev1 "k8s.io/api/node/v1"

#RuntimeClassList: nodev1.#RuntimeClassList & {
	apiVersion: "node.k8s.io/v1"
	kind:       "RuntimeClassList"
	items: [...{
		apiVersion: "node.k8s.io/v1"
		kind:       "RuntimeClass"
	}]
}

#RuntimeClassList: items: [{
	metadata: name: "nvidia"
	handler: "nvidia"
}]
