package kube_system

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
		name: "kube-controller-manager"
		labels: "app.kubernetes.io/name": name
	}
	spec: {
		ports: [{
			name: "metrics"
			port: 10257
		}]
		selector: "k8s-app": "kube-controller-manager"
		clusterIP: v1.#ClusterIPNone
	}
}, {
	metadata: {
		name: "kube-scheduler"
		labels: "app.kubernetes.io/name": name
	}
	spec: {
		ports: [{
			name: "metrics"
			port: 10259
		}]
		selector: "k8s-app": "kube-scheduler"
		clusterIP: v1.#ClusterIPNone
	}
}]
