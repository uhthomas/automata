package pillowtalk

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
	spec: calicoNetwork: {
		// Note: The ipPools section cannot be modified post-install.
		ipPools: [{
			blockSize:     26
			cidr:          "172.16.0.0/16"
			encapsulation: "VXLANCrossSubnet"
			natOutgoing:   "Enabled"
			nodeSelector:  "all()"
		}]
		nodeAddressAutodetectionV4: cidrs: ["10.0.0.0/24"]
	}
}]
