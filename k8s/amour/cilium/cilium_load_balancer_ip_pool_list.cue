package cilium

import ciliumv2alpha1 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1"

#CiliumLoadBalancerIPPoolList: ciliumv2alpha1.#CiliumLoadBalancerIPPoolList & {
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumLoadBalancerIPPoolList"
	items: [...{
		apiVersion: "cilium.io/v2alpha1"
		kind:       "CiliumLoadBalancerIPPool"
	}]
}

#CiliumLoadBalancerIPPoolList: items: [{
	metadata: name: "cilium-lb-ipam-default"
	spec: {
		cidrs: [{cidr: "10.210.0.0/16"}]
		disabled: false
	}
}]
