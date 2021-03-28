package ingress_nginx

import "k8s.io/api/core/v1"

serviceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

serviceList: items: [{
	metadata: {
		name: "ingress-nginx-controller-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		type: v1.#ServiceTypeClusterIP
		ports: [{
			name:       "https-webhook"
			port:       443
			targetPort: "webhook"
		}]
		selector: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}, {
	metadata: {
		name: "ingress-nginx-controller"
		annotations: {
			"service.beta.kubernetes.io/scw-loadbalancer-proxy-protocol-v2": "true"
			"service.beta.kubernetes.io/scw-loadbalancer-use-hostname":      "true"
		}
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		type:                  v1.#ServiceTypeLoadBalancer
		externalTrafficPolicy: v1.#ServiceExternalTrafficPolicyTypeLocal
		ports: [{
			name:       "http"
			port:       80
			protocol:   v1.#ProtocolTCP
			targetPort: "http"
		}, {
			name:       "https"
			port:       443
			protocol:   v1.#ProtocolTCP
			targetPort: "https"
		}]
		selector: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}]
