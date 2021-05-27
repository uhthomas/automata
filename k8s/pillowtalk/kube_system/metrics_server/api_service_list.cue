package metrics_server

import apiregistrationv1 "k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"

apiServiceList: apiregistrationv1.#APIServiceList & {
	apiVersion: "apiregistration.k8s.io/v1"
	kind:       "APIService"
	items: [...{
		apiVersion: "apiregistration.k8s.io/v1"
		kind:       "APIService"
	}]
}

apiServiceList: items: [{
	metadata: name: "v1beta1.metrics.k8s.io"
	spec: {
		service: {
			name:      "metrics-server"
			namespace: "kube-system"
		}
		group:                 "metrics.k8s.io"
		version:               "v1beta1"
		insecureSkipTLSVerify: true
		groupPriorityMinimum:  100
		versionPriority:       100
	}
}]
