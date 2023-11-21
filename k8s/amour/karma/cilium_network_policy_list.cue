package karma

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
					protocol: "UDP"
				}]
				rules: dns: [{matchPattern: "*"}]
			}]
		}, {
			toServices: [{
				k8sService: {
					serviceName: "vmalertmanager-vm"
					namespace:   "vm"
				}
			}]
			toPorts: [{
				ports: [{port: "8080"}]
			}]
		}]
	}
}]
