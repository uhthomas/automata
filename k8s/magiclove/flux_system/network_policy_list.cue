package flux_system

import networkingv1 "k8s.io/api/networking/v1"

#NetworkPolicyList: networkingv1.#NetworkPolicyList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicyList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "NetworkPolicy"
	}]
}

#NetworkPolicyList: items: [{
	metadata: name: "allow-egress"
	spec: {
		podSelector: {}
		ingress: [{
			from: [{podSelector: {}}]
		}]
		egress: [{}]
		policyTypes: ["Ingress", "Egress"]
	}
}, {
	metadata: name: "allow-scraping"
	spec: {
		podSelector: {}
		ingress: [{
			ports: [{
				protocol: "TCP"
				port:     8080
			}]
			from: [{namespaceSelector: {}}]
		}]
		policyTypes: ["Ingress"]
	}
}, {
	metadata: name: "allow-webhooks"
	spec: {
		podSelector: matchLabels: app: "notification-controller"
		ingress: [{
			from: [{namespaceSelector: {}}]
		}]
		policyTypes: ["Ingress"]
	}
}]
