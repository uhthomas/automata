package metrics_server

import apiregistrationv1 "k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"

#APIServiceList: apiregistrationv1.#APIServiceList & {
	apiVersion: "apiregistration.k8s.io/v1"
	kind:       "APIServiceList"
	items: [...{
		apiVersion: "apiregistration.k8s.io/v1"
		kind:       "APIService"
	}]
}

#APIServiceList: items: [{
	metadata: name: "v1beta1.metrics.k8s.io"
	spec: {
		group:                 "metrics.k8s.io"
		groupPriorityMinimum:  100
		insecureSkipTLSVerify: true
		service: {
			name:      #Name
			namespace: #Namespace
		}
		version:         "v1beta1"
		versionPriority: 100
	}
}]
