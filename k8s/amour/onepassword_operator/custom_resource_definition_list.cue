package onepassword_operator

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
	metadata: name: "onepassworditems.onepassword.com"
	spec: {
		group: "onepassword.com"
		names: {
			kind:     "OnePasswordItem"
			listKind: "OnePasswordItemList"
			plural:   "onepassworditems"
			singular: "onepassworditem"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "OnePasswordItem is the Schema for the onepassworditems API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "OnePasswordItemSpec defines the desired state of OnePasswordItem"
						properties: itemPath: type: "string"
						type: "object"
					}
					status: {
						description: "OnePasswordItemStatus defines the observed state of OnePasswordItem"
						properties: conditions: {
							items: {
								properties: {
									lastTransitionTime: {
										description: "Last time the condition transit from one status to another."
										format:      "date-time"
										type:        "string"
									}
									message: {
										description: "Human-readable message indicating details about last transition."
										type:        "string"
									}
									status: {
										description: "Status of the condition, one of True, False, Unknown."
										type:        "string"
									}
									type: {
										description: "Type of job condition, Completed."
										type:        "string"
									}
								}
								required: ["status", "type"]
								type: "object"
							}
							type: "array"
						}
						required: ["conditions"]
						type: "object"
					}
					type: {
						description: "Kubernetes secret type. More info: https://kubernetes.io/docs/concepts/configuration/secret/#secret-types"
						type:        "string"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
