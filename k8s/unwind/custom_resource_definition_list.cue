package unwind

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

#CustomResourceDefinitionList: apiextensionsv1.#CustomResourceDefinitionList & {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinitionList"
	items: [...{
		apiVersion: "apiextensions.k8s.io/v1"
		kind:       "CustomResourceDefinition"
	}]
}

#CustomResourceDefinitionList: items: [{
	metadata: name: "applysets.starjunk.net"
	spec: {
		group: "starjunk.net"
		names: {
			kind:   "ApplySet"
			plural: "applysets"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			name:    "v1"
			served:  true
			storage: true
			schema: openAPIV3Schema: type: "object"
		}]
	}
}]
