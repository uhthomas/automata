package sealed_secrets

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

custom_resource_definition: [...apiextensionsv1.#CustomResourceDefinition]

custom_resource_definition: [{
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: name: "sealedsecrets.bitnami.com"
	spec: {
		group: "bitnami.com"
		names: {
			kind:     "SealedSecret"
			listKind: "SealedSecretList"
			plural:   "sealedsecrets"
			singular: "sealedsecret"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					type:                                   "object"
					"x-kubernetes-preserve-unknown-fields": true
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
