package cilium

import ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

#CiliumBGPPeerConfigList: ciliumv2.#CiliumBGPPeerConfigList & {
	apiVersion: "cilium.io/v2"
	kind:       "CiliumBGPPeerConfigList"
	items: [...{
		apiVersion: "cilium.io/v2"
		kind:       "CiliumBGPPeerConfig"
	}]
}

#CiliumBGPPeerConfigList: items: [{
	metadata: name: "default"
	spec: families: [{
		afi:  "ipv4"
		safi: "unicast"
		advertisements: matchLabels: advertise: "bgp"
	}]
}]
