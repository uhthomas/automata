package onepassword_secrets_injector

import ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

#CiliumNetworkPolicyList: ciliumv2.#CiliumNetworkPolicyList & {
	apiVersion: "cilium.io/v2"
	kind:       "CiliumNetworkPolicyList"
	items: [...{
		apiVersion: "cilium.io/v2"
		kind:       "CiliumNetworkPolicy"
	}]
}

#CiliumNetworkPolicyList: items: [{
	spec: {
		endpointSelector: {}
		// ingress: [{}]
		// egress: [{toFQDNs: [{matchName: "1password.com"}]}]
	}
}]
