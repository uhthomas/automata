package secrets_store_csi_driver

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
	metadata: name: "secretproviderclasses.secrets-store.csi.x-k8s.io"
	spec: {
		group: "secrets-store.csi.x-k8s.io"
		names: {
			kind:     "SecretProviderClass"
			listKind: "SecretProviderClassList"
			plural:   "secretproviderclasses"
			singular: "secretproviderclass"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "SecretProviderClass is the Schema for the secretproviderclasses API"

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
						description: "SecretProviderClassSpec defines the desired state of SecretProviderClass"
						properties: {
							parameters: {
								additionalProperties: type: "string"
								description: "Configuration for specific provider"
								type:        "object"
							}
							provider: {
								description: "Configuration for provider name"
								type:        "string"
							}
							secretObjects: {
								items: {
									description: "SecretObject defines the desired state of synced K8s secret objects"
									properties: {
										annotations: {
											additionalProperties: type: "string"
											description: "annotations of k8s secret object"
											type:        "object"
										}
										data: {
											items: {
												description: "SecretObjectData defines the desired state of synced K8s secret object data"
												properties: {
													key: {
														description: "data field to populate"
														type:        "string"
													}
													objectName: {
														description: "name of the object to sync"
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										labels: {
											additionalProperties: type: "string"
											description: "labels of K8s secret object"
											type:        "object"
										}
										secretName: {
											description: "name of the K8s secret object"
											type:        "string"
										}
										type: {
											description: "type of K8s secret object"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
					status: {
						description: "SecretProviderClassStatus defines the observed state of SecretProviderClass"
						properties: byPod: {
							items: {
								description: "ByPodStatus defines the state of SecretProviderClass as seen by an individual controller"

								properties: {
									id: {
										description: "id of the pod that wrote the status"
										type:        "string"
									}
									namespace: {
										description: "namespace of the pod that wrote the status"
										type:        "string"
									}
								}
								type: "object"
							}
							type: "array"
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
		}, {
			deprecated:         true
			deprecationWarning: "secrets-store.csi.x-k8s.io/v1alpha1 is deprecated. Use secrets-store.csi.x-k8s.io/v1 instead."

			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "SecretProviderClass is the Schema for the secretproviderclasses API"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "SecretProviderClassSpec defines the desired state of SecretProviderClass"
						properties: {
							parameters: {
								additionalProperties: type: "string"
								description: "Configuration for specific provider"
								type:        "object"
							}
							provider: {
								description: "Configuration for provider name"
								type:        "string"
							}
							secretObjects: {
								items: {
									description: "SecretObject defines the desired state of synced K8s secret objects"

									properties: {
										annotations: {
											additionalProperties: type: "string"
											description: "annotations of k8s secret object"
											type:        "object"
										}
										data: {
											items: {
												description: "SecretObjectData defines the desired state of synced K8s secret object data"

												properties: {
													key: {
														description: "data field to populate"
														type:        "string"
													}
													objectName: {
														description: "name of the object to sync"
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										labels: {
											additionalProperties: type: "string"
											description: "labels of K8s secret object"
											type:        "object"
										}
										secretName: {
											description: "name of the K8s secret object"
											type:        "string"
										}
										type: {
											description: "type of K8s secret object"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
					status: {
						description: "SecretProviderClassStatus defines the observed state of SecretProviderClass"
						properties: byPod: {
							items: {
								description: "ByPodStatus defines the state of SecretProviderClass as seen by an individual controller"

								properties: {
									id: {
										description: "id of the pod that wrote the status"
										type:        "string"
									}
									namespace: {
										description: "namespace of the pod that wrote the status"
										type:        "string"
									}
								}
								type: "object"
							}
							type: "array"
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
		}]
	}
}, {
	metadata: name: "secretproviderclasspodstatuses.secrets-store.csi.x-k8s.io"
	spec: {
		group: "secrets-store.csi.x-k8s.io"
		names: {
			kind:     "SecretProviderClassPodStatus"
			listKind: "SecretProviderClassPodStatusList"
			plural:   "secretproviderclasspodstatuses"
			singular: "secretproviderclasspodstatus"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "SecretProviderClassPodStatus is the Schema for the secretproviderclassespodstatus API"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					status: {
						description: "SecretProviderClassPodStatusStatus defines the observed state of SecretProviderClassPodStatus"

						properties: {
							mounted: type: "boolean"
							objects: {
								items: {
									description: "SecretProviderClassObject defines the object fetched from external secrets store"

									properties: {
										id: type:      "string"
										version: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							podName: type:                 "string"
							secretProviderClassName: type: "string"
							targetPath: type:              "string"
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
		}, {
			deprecated: true
			name:       "v1alpha1"
			schema: openAPIV3Schema: {
				description: "SecretProviderClassPodStatus is the Schema for the secretproviderclassespodstatus API"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					status: {
						description: "SecretProviderClassPodStatusStatus defines the observed state of SecretProviderClassPodStatus"

						properties: {
							mounted: type: "boolean"
							objects: {
								items: {
									description: "SecretProviderClassObject defines the object fetched from external secrets store"

									properties: {
										id: type:      "string"
										version: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							podName: type:                 "string"
							secretProviderClassName: type: "string"
							targetPath: type:              "string"
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
		}]
	}
}]
