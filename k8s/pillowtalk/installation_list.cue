package tigera_operator

import "k8s.io/api/core/v1"

installationList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "operator.tigera.io/v1"
		kind:       "Installation"
	}]
}

installationList: items: [{
	metadata: name: "default"
	// Note: The ipPools section cannot be modified post-install.
	spec: calicoNetwork: ipPools: [{
		blockSize:     26
		cidr:          "10.96.0.0/16"
		encapsulation: "VXLANCrossSubnet"
		natOutgoing:   "Enabled"
		nodeSelector:  "all()"
	}]
}]
