package karma

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
		endpointSelector: {}
		egress: [{
			toEndpoints: [{
				matchLabels: {
					"io.kubernetes.pod.namespace": "kube-system"
					"k8s-app":                     "kube-dns"
				}
			}]
			toPorts: [{
				ports: [{
					port:     "53"
					protocol: ciliumpolicy.#ProtoUDP
				}]
				rules: dns: [{matchPattern: "*"}]
			}]
		}, {
			toEndpoints: [{
				matchLabels: {
					"io.kubernetes.pod.namespace": "vm"
					"app.kubernetes.io/name":      "vmalertmanager"
					"app.kubernetes.io/instance":  "vm"
				}
			}]
			toPorts: [{ports: [{port: "9093"}]}]
		}]
	}
}]
