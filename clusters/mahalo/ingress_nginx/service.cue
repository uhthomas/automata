package ingress_nginx

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
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
		type: "ClusterIP"
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
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "ingress-nginx-controller"
		annotations: {
			"service.beta.kubernetes.io/scw-loadbalancer-proxy-protocol-v2": "true"
			"service.beta.kubernetes.io/scw-loadbalancer-use-hostname": "true"
		}
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		type:                  "LoadBalancer"
		externalTrafficPolicy: "Local"
		ports: [{
			name:       "http"
			port:       80
			protocol:   "TCP"
			targetPort: "http"
		}, {
			name:       "https"
			port:       443
			protocol:   "TCP"
			targetPort: "https"
		}]
		selector: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}]
