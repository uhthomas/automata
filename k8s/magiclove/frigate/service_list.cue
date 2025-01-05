package frigate

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
			name:       "http"
			port:       80
			targetPort: "http"
		}, {
			name:       "rtmp"
			port:       1935
			targetPort: "upnp"
		}, {
			name:       "rtsp"
			port:       8554
			targetPort: "discovery"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
