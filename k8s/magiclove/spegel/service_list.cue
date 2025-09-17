package spegel

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
			name:       "http-metrics"
			port:       9090
			targetPort: "metrics"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-bootstrap"
	spec: {
		ports: [{
			name:       "router"
			port:       5001
			targetPort: "router"
		}]
		selector: "app.kubernetes.io/name": #Name
		clusterIP:                v1.#ClusterIPNone
		publishNotReadyAddresses: true
	}
}, {
	metadata: name: "\(#Name)-registry"
	spec: {
		ports: [{
			name:       "registry"
			port:       5000
			targetPort: "registry"
			nodePort:   30020
		}]
		selector: "app.kubernetes.io/name": #Name
		type:                v1.#ServiceTypeNodePort
		trafficDistribution: "PreferSameNode"
	}
}]
