package cilium

import ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

#CiliumLoadBalancerIPPoolList: ciliumv2.#CiliumLoadBalancerIPPoolList & {
	apiVersion: "cilium.io/v2"
	kind:       "CiliumLoadBalancerIPPoolList"
	items: [...{
		apiVersion: "cilium.io/v2"
		kind:       "CiliumLoadBalancerIPPool"
	}]
}

#CiliumLoadBalancerIPPoolList: items: [{
	metadata: name: "cilium-lb-ipam-default"
	spec: {
		blocks: [{cidr: "192.168.135.0/24"}]
		disabled: false
	}
}]
