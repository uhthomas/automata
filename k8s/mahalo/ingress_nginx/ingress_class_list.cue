package ingress_nginx

import networkingv1 "k8s.io/api/networking/v1"

ingressClassList: networkingv1.#IngressClassList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "IngressClassList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "IngressClass"
	}]
}

ingressClassList: items: [{
	metadata: name: "nginx"
	spec: controller: "k8s.io/ingress-nginx"
}]
