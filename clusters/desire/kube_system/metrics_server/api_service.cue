package metrics_server

import apiregistrationv1 "k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"

api_service: [...apiregistrationv1.#APIService]

api_service: [{
	apiVersion: "apiregistration.k8s.io/v1"
	kind:       "APIService"
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
