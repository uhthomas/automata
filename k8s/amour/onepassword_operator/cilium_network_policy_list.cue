package onepassword_operator

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
		ingress: [{}]
		// ingress: [{
		// 	fromEntities: ["host"]
		// 	toPorts: [{ports: [{port: "https"}]}]
		// }]
		// egress: [{
		// 	toEntities: ["host"]
		// 	toPorts: [{ports: [{port: "https"}]}]
		// }]
		// egress: [{
		// 	toEndpoints: [{
		// 		matchLabels: {
		// 			"io.kubernetes.pod.namespace": "kube-system"
		// 			"k8s-app":                     "kube-dns"
		// 		}
		// 	}]
		// 	toPorts: [{
		// 		ports: [{
		// 			port:     "53"
		// 			protocol: "UDP"
		// 		}]
		// 		rules: dns: [{
		// 			matchPattern: "*"
		// 		}]
		// 	}]
		// }, {
		// 	toServices: [{
		// 		k8sService: {
		// 			serviceName: "onepassword-connect"
		// 			namespace:   "onepassword-connect"
		// 		}
		// 	}]
		// 	toPorts: [{ports: [{port: "http"}]}]
		// }]
	}
}]
