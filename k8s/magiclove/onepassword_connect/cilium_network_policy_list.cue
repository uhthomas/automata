package onepassword_connect

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
		// ingress: [{
		// 	fromEndpoints: [{
		// 		matchLabels: {
		// 			"app.kubernetes.io/name":      "onepassword-operator"
		// 			"io.kubernetes.pod.namespace": "onepassword-operator"
		// 		}
		// 	}]
		// 	toPorts: [{ports: [{port: "8080"}]}]
		// }]
		// egress: [{}]
	}
}]
