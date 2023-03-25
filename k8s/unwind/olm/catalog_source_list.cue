package olm

import "k8s.io/api/core/v1"

#CatalogSourceList: v1.#List & {
	apiVersion: "operators.coreos.com/v1alpha1"
	kind:       "CatalogSourceList"
	items: [...{
		apiVersion: "operators.coreos.com/v1alpha1"
		kind:       "CatalogSource"
	}]
}

#CatalogSourceList: items: [{
	metadata: name: "operatorhubio-catalog"
	spec: {
		sourceType:  "grpc"
		image:       "quay.io/operatorhubio/catalog:latest"
		displayName: "Community Operators"
		publisher:   "OperatorHub.io"
		grpcPodConfig: securityContextConfig: "restricted"
		updateStrategy: registryPoll: interval: "60m"
	}
}]
