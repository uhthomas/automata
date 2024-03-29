package dragonfly_operator_system

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
	metadata: name: "dragonflies.dragonflydb.io"
	spec: {
		group: "dragonflydb.io"
		names: {
			kind:     "Dragonfly"
			listKind: "DragonflyList"
			plural:   "dragonflies"
			singular: "dragonfly"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Dragonfly is the Schema for the dragonflies API"
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
						description: "DragonflySpec defines the desired state of Dragonfly"
						properties: {
							args: {
								description: "(Optional) Dragonfly container args to pass to the container Refer to the Dragonfly documentation for the list of supported args"
								items: type: "string"
								type: "array"
							}
							image: {
								description: "Image is the Dragonfly image to use"
								type:        "string"
							}
							replicas: {
								description: "Replicas is the total number of Dragonfly instances including the master"
								format:      "int32"
								type:        "integer"
							}
							resources: {
								description: "(Optional) Dragonfly container resource limits. Any container limits can be specified."
								properties: {
									claims: {
										description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
		 This field is immutable.
		"""
										items: {
											description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
											properties: name: {
												description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."
												type:        "string"
											}
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
										"x-kubernetes-list-map-keys": [
											"name",
										]
										"x-kubernetes-list-type": "map"
									}
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
										type:        "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
										type:        "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "DragonflyStatus defines the observed state of Dragonfly"
						properties: {
							isRollingUpdate: {
								description: "IsRollingUpdate is true if the Dragonfly instance is being updated"
								type:        "boolean"
							}
							phase: {
								description: "Status of the Dragonfly Instance It can be one of the following: - \"ready\": The Dragonfly instance is ready to serve requests - \"configuring-replication\": The controller is updating the master of the Dragonfly instance - \"resources-created\": The Dragonfly instance resources were created but not yet configured"
								type:        "string"
							}
						}
						type: "object"
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
