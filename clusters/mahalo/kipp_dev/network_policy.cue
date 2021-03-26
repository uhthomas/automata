package kipp_dev

import networkingv1 "k8s.io/api/networking/v1"

networkPolicyList: networkingv1.#NetworkPolicyList & {
	apiVersion: "v1"
	kind:       "List"
}

networkPolicyList: items: [{
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	spec: {
		podSelector: {}
		policyTypes: [
			networkingv1.#PolicyTypeIngress,
			networkingv1.#PolicyTypeEgress,
		]
		ingress: [{
			from: [{
				namespaceSelector: matchLabels: "app.kubernetes.io/name": "ingress-nginx"
				podSelector: matchLabels: {
					"app.kubernetes.io/name":      "ingress-nginx"
					"app.kubernetes.io/instance":  "ingress-nginx"
					"app.kubernetes.io/component": "controller"
				}
			}]
			ports: [{
				port: "http"
			}]
		}, {
			from: [{
				namespaceSelector: matchLabels: "app.kubernetes.io/name": "prometheus"
				podSelector: matchLabels: {
					"app.kubernetes.io/name":      "prometheus"
					"app.kubernetes.io/instance":  "prometheus"
					"app.kubernetes.io/component": "server"
				}
			}]
		}]
		egress: [{
			to: [{
				ipBlock: cidr: "0.0.0.0/0"
			}]
		}]
	}
}]
