package redis_operator

import "k8s.io/api/core/v1"

#ServiceMonitorList: v1.#List & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

#ServiceMonitorList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		endpoints: [{port: "metrics"}]
		namespaceSelector: matchNames: [#Namespace]
	}
}]
