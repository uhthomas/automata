package headlamp

import (
	ciliumv2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"
	ciliumpolicy "github.com/cilium/cilium/pkg/policy/api"
)

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
		endpointSelector: matchLabels: "app.kubernetes.io/name": #Name
		ingress: [{
			fromEndpoints: [{
				matchLabels: {
					"app.kubernetes.io/component": "proxy"
					"app.kubernetes.io/name":      "envoy"
					"io.kubernetes.pod.namespace": "envoy-gateway"
				}
			}]
			toPorts: [{ports: [{
				port:     "4466"
				protocol: ciliumpolicy.#ProtoTCP
			}]}]
		}, {
			fromEntities: [ciliumpolicy.#EntityHost]
			toPorts: [{ports: [{
				port:     "4466"
				protocol: ciliumpolicy.#ProtoTCP
			}]}]
		}]
	}
}]
