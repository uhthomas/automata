package emqx

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
			name:       "mqtt"
			port:       1883
			targetPort: "mqtt"
		}, {
			name:       "mqtt-ws"
			port:       8083
			targetPort: "mqtt-ws"
		}, {
			name:       "mqtt-wss"
			port:       8084
			targetPort: "mqtt-wss"
		}, {
			name:       "mqtt-tls"
			port:       8883
			targetPort: "mqtt-tls"
		}, {
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
