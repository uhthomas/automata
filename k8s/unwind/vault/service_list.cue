package vault

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	spec: {
		ports: [{
			name: "http"
			port: 8200
		}, {
			name: "https-internal"
			port: 8201
		}]
		selector: {
			"app.kubernetes.io/name":      "vault"
			"app.kubernetes.io/component": "server"
		}
		publishNotReadyAddresses: true
	}
}, {
	metadata: {
		name: "\(#Name)-active"
		labels: "vault-active": "true"
	}
	spec: {
		ports: [{
			name: "http"
			port: 8200
		}, {
			name: "https-internal"
			port: 8201
		}]
		selector: {
			"app.kubernetes.io/name":      "vault"
			"app.kubernetes.io/component": "server"
			"vault-active":                "true"
		}
		publishNotReadyAddresses: true
	}
}, {
	metadata: name: "\(#Name)-standby"
	spec: {
		ports: [{
			name: "http"
			port: 8200
		}, {
			name: "https-internal"
			port: 8201
		}]
		selector: {
			"app.kubernetes.io/name":      "vault"
			"app.kubernetes.io/component": "server"
			"vault-active":                "false"
		}
		publishNotReadyAddresses: true
	}
}, {
	metadata: {
		name: "\(#Name)-internal"
		labels: "vault-internal": "true"
	}
	spec: {
		ports: [{
			name: "http"
			port: 8200
		}, {
			name: "https-internal"
			port: 8201
		}]
		selector: {
			"app.kubernetes.io/name":      "vault"
			"app.kubernetes.io/component": "server"
		}
		clusterIP:                v1.#ClusterIPNone
		publishNotReadyAddresses: true
	}
}, {
	metadata: {
		name: "\(#Name)-tailscale"
		annotations: "tailscale.com/hostname": "\(#Name)-unwind"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      "vault"
			"app.kubernetes.io/component": "server"
			"vault-active":                "true"
		}
		type:              v1.#ServiceTypeLoadBalancer
		loadBalancerClass: "tailscale"
	}
}]
