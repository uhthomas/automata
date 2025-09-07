package cilium

import ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

#CiliumBGPAdvertisementList: ciliumv2.#CiliumBGPAdvertisementList & {
	apiVersion: "cilium.io/v2"
	kind:       "CiliumBGPAdvertisementList"
	items: [...{
		apiVersion: "cilium.io/v2"
		kind:       "CiliumBGPAdvertisement"
	}]
}

#CiliumBGPAdvertisementList: items: [{
	metadata: {
		name: "default"
		labels: advertise: "bgp"
	}
	spec: advertisements: [{
		advertisementType: ciliumv2.#BGPServiceAdvert
		service: addresses: [ciliumv2.#BGPLoadBalancerIPAddr]
		selector: matchExpressions: [{
			key:      "somekey"
			operator: "NotIn"
			values: ["never-used-value"]
		}]
	}]
}]
