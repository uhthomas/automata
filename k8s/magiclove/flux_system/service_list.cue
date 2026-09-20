package flux_system

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
	metadata: {
		name: "source-controller"
		labels: {
			"app.kubernetes.io/component": "source-controller"
			"control-plane":               "controller"
		}
	}
	spec: {
		ports: [{
			name:       "http"
			protocol:   "TCP"
			port:       80
			targetPort: "http"
		}]
		selector: app: "source-controller"
		type: "ClusterIP"
	}
}]
