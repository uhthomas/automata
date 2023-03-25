package olm

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
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "catalogsources.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "CatalogSource"
			listKind: "CatalogSourceList"
			plural:   "catalogsources"
			shortNames: [
				"catsrc",
			]
			singular: "catalogsource"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The pretty name of the catalog"
				jsonPath:    ".spec.displayName"
				name:        "Display"
				type:        "string"
			}, {
				description: "The type of the catalog"
				jsonPath:    ".spec.sourceType"
				name:        "Type"
				type:        "string"
			}, {
				description: "The publisher of the catalog"
				jsonPath:    ".spec.publisher"
				name:        "Publisher"
				type:        "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "CatalogSource is a repository of CSVs, CRDs, and operator packages."
				type:        "object"
				required: [
					"metadata",
					"spec",
				]
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
						type: "object"
						required: [
							"sourceType",
						]
						properties: {
							address: {
								description: "Address is a host that OLM can use to connect to a pre-existing registry. Format: <registry-host or ip>:<port> Only used when SourceType = SourceTypeGrpc. Ignored when the Image field is set."
								type:        "string"
							}
							configMap: {
								description: "ConfigMap is the name of the ConfigMap to be used to back a configmap-server registry. Only used when SourceType = SourceTypeConfigmap or SourceTypeInternal."
								type:        "string"
							}
							description: type: "string"
							displayName: {
								description: "Metadata"
								type:        "string"
							}
							grpcPodConfig: {
								description: "GrpcPodConfig exposes different overrides for the pod spec of the CatalogSource Pod. Only used when SourceType = SourceTypeGrpc and Image is set."
								type:        "object"
								properties: {
									nodeSelector: {
										description: "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node."
										type:        "object"
										additionalProperties: type: "string"
									}
									priorityClassName: {
										description: "If specified, indicates the pod's priority. If not specified, the pod priority will be default or zero if there is no default."
										type:        "string"
									}
									securityContextConfig: {
										description: """
		SecurityContextConfig can be one of `legacy` or `restricted`. The CatalogSource's pod is either injected with the right pod.spec.securityContext and pod.spec.container[*].securityContext values to allow the pod to run in Pod Security Admission (PSA) `restricted` mode, or doesn't set these values at all, in which case the pod can only be run in PSA `baseline` or `privileged` namespaces. Currently if the SecurityContextConfig is unspecified, the default value of `legacy` is used. Specifying a value other than `legacy` or `restricted` result in a validation error. When using older catalog images, which could not be run in `restricted` mode, the SecurityContextConfig should be set to `legacy`.
		 In a future version will the default will be set to `restricted`, catalog maintainers should rebuild their catalogs with a version of opm that supports running catalogSource pods in `restricted` mode to prepare for these changes.
		 More information about PSA can be found here: https://kubernetes.io/docs/concepts/security/pod-security-admission/'
		"""
										type:    "string"
										default: "legacy"
										enum: [
											"legacy",
											"restricted",
										]
									}
									tolerations: {
										description: "Tolerations are the catalog source's pod's tolerations."
										type:        "array"
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
											type:        "object"
											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
													type:        "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
													type:        "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
													type:        "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
													type:        "integer"
													format:      "int64"
												}
												value: {
													description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
													type:        "string"
												}
											}
										}
									}
								}
							}
							icon: {
								type: "object"
								required: [
									"base64data",
									"mediatype",
								]
								properties: {
									base64data: type: "string"
									mediatype: type:  "string"
								}
							}
							image: {
								description: "Image is an operator-registry container image to instantiate a registry-server with. Only used when SourceType = SourceTypeGrpc. If present, the address field is ignored."
								type:        "string"
							}
							priority: {
								description: "Priority field assigns a weight to the catalog source to prioritize them so that it can be consumed by the dependency resolver. Usage: Higher weight indicates that this catalog source is preferred over lower weighted catalog sources during dependency resolution. The range of the priority value can go from positive to negative in the range of int32. The default value to a catalog source with unassigned priority would be 0. The catalog source with the same priority values will be ranked lexicographically based on its name."
								type:        "integer"
							}
							publisher: type: "string"
							secrets: {
								description: "Secrets represent set of secrets that can be used to access the contents of the catalog. It is best to keep this list small, since each will need to be tried for every catalog entry."
								type:        "array"
								items: type: "string"
							}
							sourceType: {
								description: "SourceType is the type of source"
								type:        "string"
							}
							updateStrategy: {
								description: "UpdateStrategy defines how updated catalog source images can be discovered Consists of an interval that defines polling duration and an embedded strategy type"
								type:        "object"
								properties: registryPoll: {
									type: "object"
									properties: interval: {
										description: "Interval is used to determine the time interval between checks of the latest catalog source version. The catalog operator polls to see if a new version of the catalog source is available. If available, the latest image is pulled and gRPC traffic is directed to the latest catalog source."
										type:        "string"
									}
								}
							}
						}
					}
					status: {
						type: "object"
						properties: {
							conditions: {
								description: "Represents the state of a CatalogSource. Note that Message and Reason represent the original status information, which may be migrated to be conditions based in the future. Any new features introduced will use conditions."
								type:        "array"
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									type: "object"
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											type:        "string"
											maxLength:   32768
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											type:        "integer"
											format:      "int64"
											minimum:     0
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											type:        "string"
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											type:        "string"
											enum: [
												"True",
												"False",
												"Unknown",
											]
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											type:        "string"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
										}
									}
								}
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							configMapReference: {
								type: "object"
								required: [
									"name",
									"namespace",
								]
								properties: {
									lastUpdateTime: {
										type:   "string"
										format: "date-time"
									}
									name: type:            "string"
									namespace: type:       "string"
									resourceVersion: type: "string"
									uid: {
										description: "UID is a type that holds unique ID values, including UUIDs.  Because we don't ONLY use UUIDs, this is an alias to string.  Being a type captures intent and helps make sure that UIDs and names do not get conflated."
										type:        "string"
									}
								}
							}
							connectionState: {
								type: "object"
								required: [
									"lastObservedState",
								]
								properties: {
									address: type: "string"
									lastConnect: {
										type:   "string"
										format: "date-time"
									}
									lastObservedState: type: "string"
								}
							}
							latestImageRegistryPoll: {
								description: "The last time the CatalogSource image registry has been polled to ensure the image is up-to-date"
								type:        "string"
								format:      "date-time"
							}
							message: {
								description: "A human readable message indicating details about why the CatalogSource is in this condition."
								type:        "string"
							}
							reason: {
								description: "Reason is the reason the CatalogSource was transitioned to its current state."
								type:        "string"
							}
							registryService: {
								type: "object"
								properties: {
									createdAt: {
										type:   "string"
										format: "date-time"
									}
									port: type:             "string"
									protocol: type:         "string"
									serviceName: type:      "string"
									serviceNamespace: type: "string"
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "clusterserviceversions.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "ClusterServiceVersion"
			listKind: "ClusterServiceVersionList"
			plural:   "clusterserviceversions"
			shortNames: [
				"csv",
				"csvs",
			]
			singular: "clusterserviceversion"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The name of the CSV"
				jsonPath:    ".spec.displayName"
				name:        "Display"
				type:        "string"
			}, {
				description: "The version of the CSV"
				jsonPath:    ".spec.version"
				name:        "Version"
				type:        "string"
			}, {
				description: "The name of a CSV that this one replaces"
				jsonPath:    ".spec.replaces"
				name:        "Replaces"
				type:        "string"
			}, {
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ClusterServiceVersion is a Custom Resource of type `ClusterServiceVersionSpec`."
				type:        "object"
				required: [
					"metadata",
					"spec",
				]
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
						description: "ClusterServiceVersionSpec declarations tell OLM how to install an operator that can manage apps for a given version."
						type:        "object"
						required: [
							"displayName",
							"install",
						]
						properties: {
							annotations: {
								description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata."
								type:        "object"
								additionalProperties: type: "string"
							}
							apiservicedefinitions: {
								description: "APIServiceDefinitions declares all of the extension apis managed or required by an operator being ran by ClusterServiceVersion."
								type:        "object"
								properties: {
									owned: {
										type: "array"
										items: {
											description: "APIServiceDescription provides details to OLM about apis provided via aggregation"
											type:        "object"
											required: [
												"group",
												"kind",
												"name",
												"version",
											]
											properties: {
												actionDescriptors: {
													type: "array"
													items: {
														description: "ActionDescriptor describes a declarative action that can be performed on a custom resource instance"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												containerPort: {
													type:   "integer"
													format: "int32"
												}
												deploymentName: type: "string"
												description: type:    "string"
												displayName: type:    "string"
												group: type:          "string"
												kind: type:           "string"
												name: type:           "string"
												resources: {
													type: "array"
													items: {
														description: "APIResourceReference is a Kubernetes resource type used by a custom resource"
														type:        "object"
														required: [
															"kind",
															"name",
															"version",
														]
														properties: {
															kind: type:    "string"
															name: type:    "string"
															version: type: "string"
														}
													}
												}
												specDescriptors: {
													type: "array"
													items: {
														description: "SpecDescriptor describes a field in a spec block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												statusDescriptors: {
													type: "array"
													items: {
														description: "StatusDescriptor describes a field in a status block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												version: type: "string"
											}
										}
									}
									required: {
										type: "array"
										items: {
											description: "APIServiceDescription provides details to OLM about apis provided via aggregation"
											type:        "object"
											required: [
												"group",
												"kind",
												"name",
												"version",
											]
											properties: {
												actionDescriptors: {
													type: "array"
													items: {
														description: "ActionDescriptor describes a declarative action that can be performed on a custom resource instance"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												containerPort: {
													type:   "integer"
													format: "int32"
												}
												deploymentName: type: "string"
												description: type:    "string"
												displayName: type:    "string"
												group: type:          "string"
												kind: type:           "string"
												name: type:           "string"
												resources: {
													type: "array"
													items: {
														description: "APIResourceReference is a Kubernetes resource type used by a custom resource"
														type:        "object"
														required: [
															"kind",
															"name",
															"version",
														]
														properties: {
															kind: type:    "string"
															name: type:    "string"
															version: type: "string"
														}
													}
												}
												specDescriptors: {
													type: "array"
													items: {
														description: "SpecDescriptor describes a field in a spec block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												statusDescriptors: {
													type: "array"
													items: {
														description: "StatusDescriptor describes a field in a status block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												version: type: "string"
											}
										}
									}
								}
							}
							cleanup: {
								description: "Cleanup specifies the cleanup behaviour when the CSV gets deleted"
								type:        "object"
								required: [
									"enabled",
								]
								properties: enabled: type: "boolean"
							}
							customresourcedefinitions: {
								description: """
		CustomResourceDefinitions declares all of the CRDs managed or required by an operator being ran by ClusterServiceVersion.
		 If the CRD is present in the Owned list, it is implicitly required.
		"""
								type: "object"
								properties: {
									owned: {
										type: "array"
										items: {
											description: "CRDDescription provides details to OLM about the CRDs"
											type:        "object"
											required: [
												"kind",
												"name",
												"version",
											]
											properties: {
												actionDescriptors: {
													type: "array"
													items: {
														description: "ActionDescriptor describes a declarative action that can be performed on a custom resource instance"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												description: type: "string"
												displayName: type: "string"
												kind: type:        "string"
												name: type:        "string"
												resources: {
													type: "array"
													items: {
														description: "APIResourceReference is a Kubernetes resource type used by a custom resource"
														type:        "object"
														required: [
															"kind",
															"name",
															"version",
														]
														properties: {
															kind: type:    "string"
															name: type:    "string"
															version: type: "string"
														}
													}
												}
												specDescriptors: {
													type: "array"
													items: {
														description: "SpecDescriptor describes a field in a spec block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												statusDescriptors: {
													type: "array"
													items: {
														description: "StatusDescriptor describes a field in a status block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												version: type: "string"
											}
										}
									}
									required: {
										type: "array"
										items: {
											description: "CRDDescription provides details to OLM about the CRDs"
											type:        "object"
											required: [
												"kind",
												"name",
												"version",
											]
											properties: {
												actionDescriptors: {
													type: "array"
													items: {
														description: "ActionDescriptor describes a declarative action that can be performed on a custom resource instance"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												description: type: "string"
												displayName: type: "string"
												kind: type:        "string"
												name: type:        "string"
												resources: {
													type: "array"
													items: {
														description: "APIResourceReference is a Kubernetes resource type used by a custom resource"
														type:        "object"
														required: [
															"kind",
															"name",
															"version",
														]
														properties: {
															kind: type:    "string"
															name: type:    "string"
															version: type: "string"
														}
													}
												}
												specDescriptors: {
													type: "array"
													items: {
														description: "SpecDescriptor describes a field in a spec block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												statusDescriptors: {
													type: "array"
													items: {
														description: "StatusDescriptor describes a field in a status block of a CRD so that OLM can consume it"
														type:        "object"
														required: [
															"path",
														]
														properties: {
															description: type: "string"
															displayName: type: "string"
															path: type:        "string"
															value: {
																description: "RawMessage is a raw encoded JSON value. It implements Marshaler and Unmarshaler and can be used to delay JSON decoding or precompute a JSON encoding."
																type:        "string"
																format:      "byte"
															}
															"x-descriptors": {
																type: "array"
																items: type: "string"
															}
														}
													}
												}
												version: type: "string"
											}
										}
									}
								}
							}
							description: type: "string"
							displayName: type: "string"
							icon: {
								type: "array"
								items: {
									type: "object"
									required: [
										"base64data",
										"mediatype",
									]
									properties: {
										base64data: type: "string"
										mediatype: type:  "string"
									}
								}
							}
							install: {
								description: "NamedInstallStrategy represents the block of an ClusterServiceVersion resource where the install strategy is specified."
								type:        "object"
								required: [
									"strategy",
								]
								properties: {
									spec: {
										description: "StrategyDetailsDeployment represents the parsed details of a Deployment InstallStrategy."
										type:        "object"
										required: [
											"deployments",
										]
										properties: {
											clusterPermissions: {
												type: "array"
												items: {
													description: "StrategyDeploymentPermissions describe the rbac rules and service account needed by the install strategy"
													type:        "object"
													required: [
														"rules",
														"serviceAccountName",
													]
													properties: {
														rules: {
															type: "array"
															items: {
																description: "PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to."
																type:        "object"
																required: [
																	"verbs",
																]
																properties: {
																	apiGroups: {
																		description: "APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. \"\" represents the core API group and \"*\" represents all API groups."
																		type:        "array"
																		items: type: "string"
																	}
																	nonResourceURLs: {
																		description: "NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as \"pods\" or \"secrets\") or non-resource URL paths (such as \"/api\"),  but not both."
																		type:        "array"
																		items: type: "string"
																	}
																	resourceNames: {
																		description: "ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed."
																		type:        "array"
																		items: type: "string"
																	}
																	resources: {
																		description: "Resources is a list of resources this rule applies to. '*' represents all resources."
																		type:        "array"
																		items: type: "string"
																	}
																	verbs: {
																		description: "Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs."
																		type:        "array"
																		items: type: "string"
																	}
																}
															}
														}
														serviceAccountName: type: "string"
													}
												}
											}
											deployments: {
												type: "array"
												items: {
													description: "StrategyDeploymentSpec contains the name, spec and labels for the deployment ALM should create"
													type:        "object"
													required: [
														"name",
														"spec",
													]
													properties: {
														label: {
															description: "Set is a map of label:value. It implements Labels."
															type:        "object"
															additionalProperties: type: "string"
														}
														name: type: "string"
														spec: {
															description: "DeploymentSpec is the specification of the desired behavior of the Deployment."
															type:        "object"
															required: [
																"selector",
																"template",
															]
															properties: {
																minReadySeconds: {
																	description: "Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)"
																	type:        "integer"
																	format:      "int32"
																}
																paused: {
																	description: "Indicates that the deployment is paused."
																	type:        "boolean"
																}
																progressDeadlineSeconds: {
																	description: "The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s."
																	type:        "integer"
																	format:      "int32"
																}
																replicas: {
																	description: "Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1."
																	type:        "integer"
																	format:      "int32"
																}
																revisionHistoryLimit: {
																	description: "The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10."
																	type:        "integer"
																	format:      "int32"
																}
																selector: {
																	description: "Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			type:        "array"
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchLabels: {
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																			additionalProperties: type: "string"
																		}
																	}
																}
																strategy: {
																	description: "The deployment strategy to use to replace existing pods with new ones."
																	type:        "object"
																	properties: {
																		rollingUpdate: {
																			description: "Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate. --- TODO: Update this to follow our convention for oneOf, whatever we decide it to be."
																			type:        "object"
																			properties: {
																				maxSurge: {
																					description: "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods."
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					"x-kubernetes-int-or-string": true
																				}
																				maxUnavailable: {
																					description: "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods."
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					"x-kubernetes-int-or-string": true
																				}
																			}
																		}
																		type: {
																			description: "Type of deployment. Can be \"Recreate\" or \"RollingUpdate\". Default is RollingUpdate."
																			type:        "string"
																		}
																	}
																}
																template: {
																	description: "Template describes the pods that will be created."
																	type:        "object"
																	properties: {
																		metadata: {
																			description:                            "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
																			type:                                   "object"
																			"x-kubernetes-preserve-unknown-fields": true
																		}
																		spec: {
																			description: "Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
																			type:        "object"
																			required: [
																				"containers",
																			]
																			properties: {
																				activeDeadlineSeconds: {
																					description: "Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer."
																					type:        "integer"
																					format:      "int64"
																				}
																				affinity: {
																					description: "If specified, the pod's scheduling constraints"
																					type:        "object"
																					properties: {
																						nodeAffinity: {
																							description: "Describes node affinity scheduling rules for the pod."
																							type:        "object"
																							properties: {
																								preferredDuringSchedulingIgnoredDuringExecution: {
																									description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																									type:        "array"
																									items: {
																										description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																										type:        "object"
																										required: [
																											"preference",
																											"weight",
																										]
																										properties: {
																											preference: {
																												description: "A node selector term, associated with the corresponding weight."
																												type:        "object"
																												properties: {
																													matchExpressions: {
																														description: "A list of node selector requirements by node's labels."
																														type:        "array"
																														items: {
																															description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "The label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																																	type:        "string"
																																}
																																values: {
																																	description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																													matchFields: {
																														description: "A list of node selector requirements by node's fields."
																														type:        "array"
																														items: {
																															description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "The label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																																	type:        "string"
																																}
																																values: {
																																	description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																												}
																											}
																											weight: {
																												description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																												type:        "integer"
																												format:      "int32"
																											}
																										}
																									}
																								}
																								requiredDuringSchedulingIgnoredDuringExecution: {
																									description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																									type:        "object"
																									required: [
																										"nodeSelectorTerms",
																									]
																									properties: nodeSelectorTerms: {
																										description: "Required. A list of node selector terms. The terms are ORed."
																										type:        "array"
																										items: {
																											description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																											type:        "object"
																											properties: {
																												matchExpressions: {
																													description: "A list of node selector requirements by node's labels."
																													type:        "array"
																													items: {
																														description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																														type:        "object"
																														required: [
																															"key",
																															"operator",
																														]
																														properties: {
																															key: {
																																description: "The label key that the selector applies to."
																																type:        "string"
																															}
																															operator: {
																																description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																																type:        "string"
																															}
																															values: {
																																description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																																type:        "array"
																																items: type: "string"
																															}
																														}
																													}
																												}
																												matchFields: {
																													description: "A list of node selector requirements by node's fields."
																													type:        "array"
																													items: {
																														description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																														type:        "object"
																														required: [
																															"key",
																															"operator",
																														]
																														properties: {
																															key: {
																																description: "The label key that the selector applies to."
																																type:        "string"
																															}
																															operator: {
																																description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																																type:        "string"
																															}
																															values: {
																																description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																																type:        "array"
																																items: type: "string"
																															}
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																						podAffinity: {
																							description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
																							type:        "object"
																							properties: {
																								preferredDuringSchedulingIgnoredDuringExecution: {
																									description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																									type:        "array"
																									items: {
																										description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																										type:        "object"
																										required: [
																											"podAffinityTerm",
																											"weight",
																										]
																										properties: {
																											podAffinityTerm: {
																												description: "Required. A pod affinity term, associated with the corresponding weight."
																												type:        "object"
																												required: [
																													"topologyKey",
																												]
																												properties: {
																													labelSelector: {
																														description: "A label query over a set of resources, in this case pods."
																														type:        "object"
																														properties: {
																															matchExpressions: {
																																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																																type:        "array"
																																items: {
																																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																																	type:        "object"
																																	required: [
																																		"key",
																																		"operator",
																																	]
																																	properties: {
																																		key: {
																																			description: "key is the label key that the selector applies to."
																																			type:        "string"
																																		}
																																		operator: {
																																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																			type:        "string"
																																		}
																																		values: {
																																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																			type:        "array"
																																			items: type: "string"
																																		}
																																	}
																																}
																															}
																															matchLabels: {
																																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																																type:        "object"
																																additionalProperties: type: "string"
																															}
																														}
																													}
																													namespaceSelector: {
																														description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																														type:        "object"
																														properties: {
																															matchExpressions: {
																																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																																type:        "array"
																																items: {
																																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																																	type:        "object"
																																	required: [
																																		"key",
																																		"operator",
																																	]
																																	properties: {
																																		key: {
																																			description: "key is the label key that the selector applies to."
																																			type:        "string"
																																		}
																																		operator: {
																																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																			type:        "string"
																																		}
																																		values: {
																																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																			type:        "array"
																																			items: type: "string"
																																		}
																																	}
																																}
																															}
																															matchLabels: {
																																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																																type:        "object"
																																additionalProperties: type: "string"
																															}
																														}
																													}
																													namespaces: {
																														description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																														type:        "array"
																														items: type: "string"
																													}
																													topologyKey: {
																														description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																														type:        "string"
																													}
																												}
																											}
																											weight: {
																												description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																												type:        "integer"
																												format:      "int32"
																											}
																										}
																									}
																								}
																								requiredDuringSchedulingIgnoredDuringExecution: {
																									description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																									type:        "array"
																									items: {
																										description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																										type:        "object"
																										required: [
																											"topologyKey",
																										]
																										properties: {
																											labelSelector: {
																												description: "A label query over a set of resources, in this case pods."
																												type:        "object"
																												properties: {
																													matchExpressions: {
																														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																														type:        "array"
																														items: {
																															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "key is the label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																	type:        "string"
																																}
																																values: {
																																	description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																													matchLabels: {
																														description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																														type:        "object"
																														additionalProperties: type: "string"
																													}
																												}
																											}
																											namespaceSelector: {
																												description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																												type:        "object"
																												properties: {
																													matchExpressions: {
																														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																														type:        "array"
																														items: {
																															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "key is the label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																	type:        "string"
																																}
																																values: {
																																	description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																													matchLabels: {
																														description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																														type:        "object"
																														additionalProperties: type: "string"
																													}
																												}
																											}
																											namespaces: {
																												description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																												type:        "array"
																												items: type: "string"
																											}
																											topologyKey: {
																												description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																												type:        "string"
																											}
																										}
																									}
																								}
																							}
																						}
																						podAntiAffinity: {
																							description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
																							type:        "object"
																							properties: {
																								preferredDuringSchedulingIgnoredDuringExecution: {
																									description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																									type:        "array"
																									items: {
																										description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																										type:        "object"
																										required: [
																											"podAffinityTerm",
																											"weight",
																										]
																										properties: {
																											podAffinityTerm: {
																												description: "Required. A pod affinity term, associated with the corresponding weight."
																												type:        "object"
																												required: [
																													"topologyKey",
																												]
																												properties: {
																													labelSelector: {
																														description: "A label query over a set of resources, in this case pods."
																														type:        "object"
																														properties: {
																															matchExpressions: {
																																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																																type:        "array"
																																items: {
																																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																																	type:        "object"
																																	required: [
																																		"key",
																																		"operator",
																																	]
																																	properties: {
																																		key: {
																																			description: "key is the label key that the selector applies to."
																																			type:        "string"
																																		}
																																		operator: {
																																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																			type:        "string"
																																		}
																																		values: {
																																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																			type:        "array"
																																			items: type: "string"
																																		}
																																	}
																																}
																															}
																															matchLabels: {
																																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																																type:        "object"
																																additionalProperties: type: "string"
																															}
																														}
																													}
																													namespaceSelector: {
																														description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																														type:        "object"
																														properties: {
																															matchExpressions: {
																																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																																type:        "array"
																																items: {
																																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																																	type:        "object"
																																	required: [
																																		"key",
																																		"operator",
																																	]
																																	properties: {
																																		key: {
																																			description: "key is the label key that the selector applies to."
																																			type:        "string"
																																		}
																																		operator: {
																																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																			type:        "string"
																																		}
																																		values: {
																																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																			type:        "array"
																																			items: type: "string"
																																		}
																																	}
																																}
																															}
																															matchLabels: {
																																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																																type:        "object"
																																additionalProperties: type: "string"
																															}
																														}
																													}
																													namespaces: {
																														description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																														type:        "array"
																														items: type: "string"
																													}
																													topologyKey: {
																														description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																														type:        "string"
																													}
																												}
																											}
																											weight: {
																												description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																												type:        "integer"
																												format:      "int32"
																											}
																										}
																									}
																								}
																								requiredDuringSchedulingIgnoredDuringExecution: {
																									description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																									type:        "array"
																									items: {
																										description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																										type:        "object"
																										required: [
																											"topologyKey",
																										]
																										properties: {
																											labelSelector: {
																												description: "A label query over a set of resources, in this case pods."
																												type:        "object"
																												properties: {
																													matchExpressions: {
																														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																														type:        "array"
																														items: {
																															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "key is the label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																	type:        "string"
																																}
																																values: {
																																	description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																													matchLabels: {
																														description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																														type:        "object"
																														additionalProperties: type: "string"
																													}
																												}
																											}
																											namespaceSelector: {
																												description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																												type:        "object"
																												properties: {
																													matchExpressions: {
																														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																														type:        "array"
																														items: {
																															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																															type:        "object"
																															required: [
																																"key",
																																"operator",
																															]
																															properties: {
																																key: {
																																	description: "key is the label key that the selector applies to."
																																	type:        "string"
																																}
																																operator: {
																																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																	type:        "string"
																																}
																																values: {
																																	description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																	type:        "array"
																																	items: type: "string"
																																}
																															}
																														}
																													}
																													matchLabels: {
																														description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																														type:        "object"
																														additionalProperties: type: "string"
																													}
																												}
																											}
																											namespaces: {
																												description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																												type:        "array"
																												items: type: "string"
																											}
																											topologyKey: {
																												description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																												type:        "string"
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																				automountServiceAccountToken: {
																					description: "AutomountServiceAccountToken indicates whether a service account token should be automatically mounted."
																					type:        "boolean"
																				}
																				containers: {
																					description: "List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated."
																					type:        "array"
																					items: {
																						description: "A single application container that you want to run within a pod."
																						type:        "object"
																						required: [
																							"name",
																						]
																						properties: {
																							args: {
																								description: "Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							command: {
																								description: "Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							env: {
																								description: "List of environment variables to set in the container. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvVar represents an environment variable present in a Container."
																									type:        "object"
																									required: [
																										"name",
																									]
																									properties: {
																										name: {
																											description: "Name of the environment variable. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										value: {
																											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
																											type:        "string"
																										}
																										valueFrom: {
																											description: "Source for the environment variable's value. Cannot be used if value is not empty."
																											type:        "object"
																											properties: {
																												configMapKeyRef: {
																													description: "Selects a key of a ConfigMap."
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key to select."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the ConfigMap or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																												fieldRef: {
																													description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																													type:        "object"
																													required: [
																														"fieldPath",
																													]
																													properties: {
																														apiVersion: {
																															description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																															type:        "string"
																														}
																														fieldPath: {
																															description: "Path of the field to select in the specified API version."
																															type:        "string"
																														}
																													}
																												}
																												resourceFieldRef: {
																													description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																													type:        "object"
																													required: [
																														"resource",
																													]
																													properties: {
																														containerName: {
																															description: "Container name: required for volumes, optional for env vars"
																															type:        "string"
																														}
																														divisor: {
																															description: "Specifies the output format of the exposed resources, defaults to \"1\""
																															pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																															anyOf: [{
																																type: "integer"
																															}, {
																																type: "string"
																															}]
																															"x-kubernetes-int-or-string": true
																														}
																														resource: {
																															description: "Required: resource to select"
																															type:        "string"
																														}
																													}
																												}
																												secretKeyRef: {
																													description: "Selects a key of a secret in the pod's namespace"
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key of the secret to select from.  Must be a valid secret key."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the Secret or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							envFrom: {
																								description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvFromSource represents the source of a set of ConfigMaps"
																									type:        "object"
																									properties: {
																										configMapRef: {
																											description: "The ConfigMap to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the ConfigMap must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																										prefix: {
																											description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										secretRef: {
																											description: "The Secret to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the Secret must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																									}
																								}
																							}
																							image: {
																								description: "Container image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
																								type:        "string"
																							}
																							imagePullPolicy: {
																								description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
																								type:        "string"
																							}
																							lifecycle: {
																								description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
																								type:        "object"
																								properties: {
																									postStart: {
																										description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																									preStop: {
																										description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							livenessProbe: {
																								description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							name: {
																								description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
																								type:        "string"
																							}
																							ports: {
																								description: "List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "ContainerPort represents a network port in a single container."
																									type:        "object"
																									required: [
																										"containerPort",
																									]
																									properties: {
																										containerPort: {
																											description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
																											type:        "integer"
																											format:      "int32"
																										}
																										hostIP: {
																											description: "What host IP to bind the external port to."
																											type:        "string"
																										}
																										hostPort: {
																											description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
																											type:        "integer"
																											format:      "int32"
																										}
																										name: {
																											description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
																											type:        "string"
																										}
																										protocol: {
																											description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
																											type:        "string"
																											default:     "TCP"
																										}
																									}
																								}
																								"x-kubernetes-list-map-keys": [
																									"containerPort",
																									"protocol",
																								]
																								"x-kubernetes-list-type": "map"
																							}
																							readinessProbe: {
																								description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							resources: {
																								description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																								type:        "object"
																								properties: {
																									limits: {
																										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																									requests: {
																										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																								}
																							}
																							securityContext: {
																								description: "SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
																								type:        "object"
																								properties: {
																									allowPrivilegeEscalation: {
																										description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									capabilities: {
																										description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											add: {
																												description: "Added capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																											drop: {
																												description: "Removed capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																										}
																									}
																									privileged: {
																										description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									procMount: {
																										description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows."
																										type:        "string"
																									}
																									readOnlyRootFilesystem: {
																										description: "Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									runAsGroup: {
																										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									runAsNonRoot: {
																										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																										type:        "boolean"
																									}
																									runAsUser: {
																										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									seLinuxOptions: {
																										description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											level: {
																												description: "Level is SELinux level label that applies to the container."
																												type:        "string"
																											}
																											role: {
																												description: "Role is a SELinux role label that applies to the container."
																												type:        "string"
																											}
																											type: {
																												description: "Type is a SELinux type label that applies to the container."
																												type:        "string"
																											}
																											user: {
																												description: "User is a SELinux user label that applies to the container."
																												type:        "string"
																											}
																										}
																									}
																									seccompProfile: {
																										description: "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										required: [
																											"type",
																										]
																										properties: {
																											localhostProfile: {
																												description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																												type:        "string"
																											}
																											type: {
																												description: """
		type indicates which kind of seccomp profile will be applied. Valid options are:
		 Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
		"""
																												type: "string"
																											}
																										}
																									}
																									windowsOptions: {
																										description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
																										type:        "object"
																										properties: {
																											gmsaCredentialSpec: {
																												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
																												type:        "string"
																											}
																											gmsaCredentialSpecName: {
																												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
																												type:        "string"
																											}
																											hostProcess: {
																												description: "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
																												type:        "boolean"
																											}
																											runAsUserName: {
																												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																												type:        "string"
																											}
																										}
																									}
																								}
																							}
																							startupProbe: {
																								description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							stdin: {
																								description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
																								type:        "boolean"
																							}
																							stdinOnce: {
																								description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
																								type:        "boolean"
																							}
																							terminationMessagePath: {
																								description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
																								type:        "string"
																							}
																							terminationMessagePolicy: {
																								description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
																								type:        "string"
																							}
																							tty: {
																								description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
																								type:        "boolean"
																							}
																							volumeDevices: {
																								description: "volumeDevices is the list of block devices to be used by the container."
																								type:        "array"
																								items: {
																									description: "volumeDevice describes a mapping of a raw block device within a container."
																									type:        "object"
																									required: [
																										"devicePath",
																										"name",
																									]
																									properties: {
																										devicePath: {
																											description: "devicePath is the path inside of the container that the device will be mapped to."
																											type:        "string"
																										}
																										name: {
																											description: "name must match the name of a persistentVolumeClaim in the pod"
																											type:        "string"
																										}
																									}
																								}
																							}
																							volumeMounts: {
																								description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "VolumeMount describes a mounting of a Volume within a container."
																									type:        "object"
																									required: [
																										"mountPath",
																										"name",
																									]
																									properties: {
																										mountPath: {
																											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
																											type:        "string"
																										}
																										mountPropagation: {
																											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
																											type:        "string"
																										}
																										name: {
																											description: "This must match the Name of a Volume."
																											type:        "string"
																										}
																										readOnly: {
																											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
																											type:        "boolean"
																										}
																										subPath: {
																											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
																											type:        "string"
																										}
																										subPathExpr: {
																											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
																											type:        "string"
																										}
																									}
																								}
																							}
																							workingDir: {
																								description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
																								type:        "string"
																							}
																						}
																					}
																				}
																				dnsConfig: {
																					description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."
																					type:        "object"
																					properties: {
																						nameservers: {
																							description: "A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed."
																							type:        "array"
																							items: type: "string"
																						}
																						options: {
																							description: "A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy."
																							type:        "array"
																							items: {
																								description: "PodDNSConfigOption defines DNS resolver options of a pod."
																								type:        "object"
																								properties: {
																									name: {
																										description: "Required."
																										type:        "string"
																									}
																									value: type: "string"
																								}
																							}
																						}
																						searches: {
																							description: "A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed."
																							type:        "array"
																							items: type: "string"
																						}
																					}
																				}
																				dnsPolicy: {
																					description: "Set DNS policy for the pod. Defaults to \"ClusterFirst\". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'."
																					type:        "string"
																				}
																				enableServiceLinks: {
																					description: "EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true."
																					type:        "boolean"
																				}
																				ephemeralContainers: {
																					description: "List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource."
																					type:        "array"
																					items: {
																						description: """
		An EphemeralContainer is a temporary container that you may add to an existing Pod for user-initiated activities such as debugging. Ephemeral containers have no resource or scheduling guarantees, and they will not be restarted when they exit or when a Pod is removed or restarted. The kubelet may evict a Pod if an ephemeral container causes the Pod to exceed its resource allocation.
		 To add an ephemeral container, use the ephemeralcontainers subresource of an existing Pod. Ephemeral containers may not be removed or restarted.
		"""
																						type: "object"
																						required: [
																							"name",
																						]
																						properties: {
																							args: {
																								description: "Arguments to the entrypoint. The image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							command: {
																								description: "Entrypoint array. Not executed within a shell. The image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							env: {
																								description: "List of environment variables to set in the container. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvVar represents an environment variable present in a Container."
																									type:        "object"
																									required: [
																										"name",
																									]
																									properties: {
																										name: {
																											description: "Name of the environment variable. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										value: {
																											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
																											type:        "string"
																										}
																										valueFrom: {
																											description: "Source for the environment variable's value. Cannot be used if value is not empty."
																											type:        "object"
																											properties: {
																												configMapKeyRef: {
																													description: "Selects a key of a ConfigMap."
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key to select."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the ConfigMap or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																												fieldRef: {
																													description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																													type:        "object"
																													required: [
																														"fieldPath",
																													]
																													properties: {
																														apiVersion: {
																															description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																															type:        "string"
																														}
																														fieldPath: {
																															description: "Path of the field to select in the specified API version."
																															type:        "string"
																														}
																													}
																												}
																												resourceFieldRef: {
																													description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																													type:        "object"
																													required: [
																														"resource",
																													]
																													properties: {
																														containerName: {
																															description: "Container name: required for volumes, optional for env vars"
																															type:        "string"
																														}
																														divisor: {
																															description: "Specifies the output format of the exposed resources, defaults to \"1\""
																															pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																															anyOf: [{
																																type: "integer"
																															}, {
																																type: "string"
																															}]
																															"x-kubernetes-int-or-string": true
																														}
																														resource: {
																															description: "Required: resource to select"
																															type:        "string"
																														}
																													}
																												}
																												secretKeyRef: {
																													description: "Selects a key of a secret in the pod's namespace"
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key of the secret to select from.  Must be a valid secret key."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the Secret or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							envFrom: {
																								description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvFromSource represents the source of a set of ConfigMaps"
																									type:        "object"
																									properties: {
																										configMapRef: {
																											description: "The ConfigMap to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the ConfigMap must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																										prefix: {
																											description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										secretRef: {
																											description: "The Secret to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the Secret must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																									}
																								}
																							}
																							image: {
																								description: "Container image name. More info: https://kubernetes.io/docs/concepts/containers/images"
																								type:        "string"
																							}
																							imagePullPolicy: {
																								description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
																								type:        "string"
																							}
																							lifecycle: {
																								description: "Lifecycle is not allowed for ephemeral containers."
																								type:        "object"
																								properties: {
																									postStart: {
																										description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																									preStop: {
																										description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							livenessProbe: {
																								description: "Probes are not allowed for ephemeral containers."
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							name: {
																								description: "Name of the ephemeral container specified as a DNS_LABEL. This name must be unique among all containers, init containers and ephemeral containers."
																								type:        "string"
																							}
																							ports: {
																								description: "Ports are not allowed for ephemeral containers."
																								type:        "array"
																								items: {
																									description: "ContainerPort represents a network port in a single container."
																									type:        "object"
																									required: [
																										"containerPort",
																									]
																									properties: {
																										containerPort: {
																											description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
																											type:        "integer"
																											format:      "int32"
																										}
																										hostIP: {
																											description: "What host IP to bind the external port to."
																											type:        "string"
																										}
																										hostPort: {
																											description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
																											type:        "integer"
																											format:      "int32"
																										}
																										name: {
																											description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
																											type:        "string"
																										}
																										protocol: {
																											description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
																											type:        "string"
																											default:     "TCP"
																										}
																									}
																								}
																								"x-kubernetes-list-map-keys": [
																									"containerPort",
																									"protocol",
																								]
																								"x-kubernetes-list-type": "map"
																							}
																							readinessProbe: {
																								description: "Probes are not allowed for ephemeral containers."
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							resources: {
																								description: "Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources already allocated to the pod."
																								type:        "object"
																								properties: {
																									limits: {
																										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																									requests: {
																										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																								}
																							}
																							securityContext: {
																								description: "Optional: SecurityContext defines the security options the ephemeral container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext."
																								type:        "object"
																								properties: {
																									allowPrivilegeEscalation: {
																										description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									capabilities: {
																										description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											add: {
																												description: "Added capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																											drop: {
																												description: "Removed capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																										}
																									}
																									privileged: {
																										description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									procMount: {
																										description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows."
																										type:        "string"
																									}
																									readOnlyRootFilesystem: {
																										description: "Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									runAsGroup: {
																										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									runAsNonRoot: {
																										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																										type:        "boolean"
																									}
																									runAsUser: {
																										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									seLinuxOptions: {
																										description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											level: {
																												description: "Level is SELinux level label that applies to the container."
																												type:        "string"
																											}
																											role: {
																												description: "Role is a SELinux role label that applies to the container."
																												type:        "string"
																											}
																											type: {
																												description: "Type is a SELinux type label that applies to the container."
																												type:        "string"
																											}
																											user: {
																												description: "User is a SELinux user label that applies to the container."
																												type:        "string"
																											}
																										}
																									}
																									seccompProfile: {
																										description: "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										required: [
																											"type",
																										]
																										properties: {
																											localhostProfile: {
																												description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																												type:        "string"
																											}
																											type: {
																												description: """
		type indicates which kind of seccomp profile will be applied. Valid options are:
		 Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
		"""
																												type: "string"
																											}
																										}
																									}
																									windowsOptions: {
																										description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
																										type:        "object"
																										properties: {
																											gmsaCredentialSpec: {
																												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
																												type:        "string"
																											}
																											gmsaCredentialSpecName: {
																												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
																												type:        "string"
																											}
																											hostProcess: {
																												description: "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
																												type:        "boolean"
																											}
																											runAsUserName: {
																												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																												type:        "string"
																											}
																										}
																									}
																								}
																							}
																							startupProbe: {
																								description: "Probes are not allowed for ephemeral containers."
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							stdin: {
																								description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
																								type:        "boolean"
																							}
																							stdinOnce: {
																								description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
																								type:        "boolean"
																							}
																							targetContainerName: {
																								description: """
		If set, the name of the container from PodSpec that this ephemeral container targets. The ephemeral container will be run in the namespaces (IPC, PID, etc) of this container. If not set then the ephemeral container uses the namespaces configured in the Pod spec.
		 The container runtime must implement support for this feature. If the runtime does not support namespace targeting then the result of setting this field is undefined.
		"""
																								type: "string"
																							}
																							terminationMessagePath: {
																								description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
																								type:        "string"
																							}
																							terminationMessagePolicy: {
																								description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
																								type:        "string"
																							}
																							tty: {
																								description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
																								type:        "boolean"
																							}
																							volumeDevices: {
																								description: "volumeDevices is the list of block devices to be used by the container."
																								type:        "array"
																								items: {
																									description: "volumeDevice describes a mapping of a raw block device within a container."
																									type:        "object"
																									required: [
																										"devicePath",
																										"name",
																									]
																									properties: {
																										devicePath: {
																											description: "devicePath is the path inside of the container that the device will be mapped to."
																											type:        "string"
																										}
																										name: {
																											description: "name must match the name of a persistentVolumeClaim in the pod"
																											type:        "string"
																										}
																									}
																								}
																							}
																							volumeMounts: {
																								description: "Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "VolumeMount describes a mounting of a Volume within a container."
																									type:        "object"
																									required: [
																										"mountPath",
																										"name",
																									]
																									properties: {
																										mountPath: {
																											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
																											type:        "string"
																										}
																										mountPropagation: {
																											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
																											type:        "string"
																										}
																										name: {
																											description: "This must match the Name of a Volume."
																											type:        "string"
																										}
																										readOnly: {
																											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
																											type:        "boolean"
																										}
																										subPath: {
																											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
																											type:        "string"
																										}
																										subPathExpr: {
																											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
																											type:        "string"
																										}
																									}
																								}
																							}
																							workingDir: {
																								description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
																								type:        "string"
																							}
																						}
																					}
																				}
																				hostAliases: {
																					description: "HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods."
																					type:        "array"
																					items: {
																						description: "HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file."
																						type:        "object"
																						properties: {
																							hostnames: {
																								description: "Hostnames for the above IP address."
																								type:        "array"
																								items: type: "string"
																							}
																							ip: {
																								description: "IP address of the host file entry."
																								type:        "string"
																							}
																						}
																					}
																				}
																				hostIPC: {
																					description: "Use the host's ipc namespace. Optional: Default to false."
																					type:        "boolean"
																				}
																				hostNetwork: {
																					description: "Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false."
																					type:        "boolean"
																				}
																				hostPID: {
																					description: "Use the host's pid namespace. Optional: Default to false."
																					type:        "boolean"
																				}
																				hostUsers: {
																					description: "Use the host's user namespace. Optional: Default to true. If set to true or not present, the pod will be run in the host user namespace, useful for when the pod needs a feature only available to the host user namespace, such as loading a kernel module with CAP_SYS_MODULE. When set to false, a new userns is created for the pod. Setting false is useful for mitigating container breakout vulnerabilities even allowing users to run their containers as root without actually having root privileges on the host. This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature."
																					type:        "boolean"
																				}
																				hostname: {
																					description: "Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value."
																					type:        "string"
																				}
																				imagePullSecrets: {
																					description: "ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod"
																					type:        "array"
																					items: {
																						description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
																						type:        "object"
																						properties: name: {
																							description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																							type:        "string"
																						}
																					}
																				}
																				initContainers: {
																					description: "List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/"
																					type:        "array"
																					items: {
																						description: "A single application container that you want to run within a pod."
																						type:        "object"
																						required: [
																							"name",
																						]
																						properties: {
																							args: {
																								description: "Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							command: {
																								description: "Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																								type:        "array"
																								items: type: "string"
																							}
																							env: {
																								description: "List of environment variables to set in the container. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvVar represents an environment variable present in a Container."
																									type:        "object"
																									required: [
																										"name",
																									]
																									properties: {
																										name: {
																											description: "Name of the environment variable. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										value: {
																											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
																											type:        "string"
																										}
																										valueFrom: {
																											description: "Source for the environment variable's value. Cannot be used if value is not empty."
																											type:        "object"
																											properties: {
																												configMapKeyRef: {
																													description: "Selects a key of a ConfigMap."
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key to select."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the ConfigMap or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																												fieldRef: {
																													description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																													type:        "object"
																													required: [
																														"fieldPath",
																													]
																													properties: {
																														apiVersion: {
																															description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																															type:        "string"
																														}
																														fieldPath: {
																															description: "Path of the field to select in the specified API version."
																															type:        "string"
																														}
																													}
																												}
																												resourceFieldRef: {
																													description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																													type:        "object"
																													required: [
																														"resource",
																													]
																													properties: {
																														containerName: {
																															description: "Container name: required for volumes, optional for env vars"
																															type:        "string"
																														}
																														divisor: {
																															description: "Specifies the output format of the exposed resources, defaults to \"1\""
																															pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																															anyOf: [{
																																type: "integer"
																															}, {
																																type: "string"
																															}]
																															"x-kubernetes-int-or-string": true
																														}
																														resource: {
																															description: "Required: resource to select"
																															type:        "string"
																														}
																													}
																												}
																												secretKeyRef: {
																													description: "Selects a key of a secret in the pod's namespace"
																													type:        "object"
																													required: [
																														"key",
																													]
																													properties: {
																														key: {
																															description: "The key of the secret to select from.  Must be a valid secret key."
																															type:        "string"
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "Specify whether the Secret or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							envFrom: {
																								description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "EnvFromSource represents the source of a set of ConfigMaps"
																									type:        "object"
																									properties: {
																										configMapRef: {
																											description: "The ConfigMap to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the ConfigMap must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																										prefix: {
																											description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																											type:        "string"
																										}
																										secretRef: {
																											description: "The Secret to select from"
																											type:        "object"
																											properties: {
																												name: {
																													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																													type:        "string"
																												}
																												optional: {
																													description: "Specify whether the Secret must be defined"
																													type:        "boolean"
																												}
																											}
																										}
																									}
																								}
																							}
																							image: {
																								description: "Container image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
																								type:        "string"
																							}
																							imagePullPolicy: {
																								description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
																								type:        "string"
																							}
																							lifecycle: {
																								description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
																								type:        "object"
																								properties: {
																									postStart: {
																										description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																									preStop: {
																										description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																										type:        "object"
																										properties: {
																											exec: {
																												description: "Exec specifies the action to take."
																												type:        "object"
																												properties: command: {
																													description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																											httpGet: {
																												description: "HTTPGet specifies the http request to perform."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																														type:        "string"
																													}
																													httpHeaders: {
																														description: "Custom headers to set in the request. HTTP allows repeated headers."
																														type:        "array"
																														items: {
																															description: "HTTPHeader describes a custom header to be used in HTTP probes"
																															type:        "object"
																															required: [
																																"name",
																																"value",
																															]
																															properties: {
																																name: {
																																	description: "The header field name"
																																	type:        "string"
																																}
																																value: {
																																	description: "The header field value"
																																	type:        "string"
																																}
																															}
																														}
																													}
																													path: {
																														description: "Path to access on the HTTP server."
																														type:        "string"
																													}
																													port: {
																														description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																													scheme: {
																														description: "Scheme to use for connecting to the host. Defaults to HTTP."
																														type:        "string"
																													}
																												}
																											}
																											tcpSocket: {
																												description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																												type:        "object"
																												required: [
																													"port",
																												]
																												properties: {
																													host: {
																														description: "Optional: Host name to connect to, defaults to the pod IP."
																														type:        "string"
																													}
																													port: {
																														description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																														anyOf: [{
																															type: "integer"
																														}, {
																															type: "string"
																														}]
																														"x-kubernetes-int-or-string": true
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							livenessProbe: {
																								description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							name: {
																								description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
																								type:        "string"
																							}
																							ports: {
																								description: "List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "ContainerPort represents a network port in a single container."
																									type:        "object"
																									required: [
																										"containerPort",
																									]
																									properties: {
																										containerPort: {
																											description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
																											type:        "integer"
																											format:      "int32"
																										}
																										hostIP: {
																											description: "What host IP to bind the external port to."
																											type:        "string"
																										}
																										hostPort: {
																											description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
																											type:        "integer"
																											format:      "int32"
																										}
																										name: {
																											description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
																											type:        "string"
																										}
																										protocol: {
																											description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
																											type:        "string"
																											default:     "TCP"
																										}
																									}
																								}
																								"x-kubernetes-list-map-keys": [
																									"containerPort",
																									"protocol",
																								]
																								"x-kubernetes-list-type": "map"
																							}
																							readinessProbe: {
																								description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							resources: {
																								description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																								type:        "object"
																								properties: {
																									limits: {
																										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																									requests: {
																										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																										type:        "object"
																										additionalProperties: {
																											pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																											anyOf: [{
																												type: "integer"
																											}, {
																												type: "string"
																											}]
																											"x-kubernetes-int-or-string": true
																										}
																									}
																								}
																							}
																							securityContext: {
																								description: "SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
																								type:        "object"
																								properties: {
																									allowPrivilegeEscalation: {
																										description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									capabilities: {
																										description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											add: {
																												description: "Added capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																											drop: {
																												description: "Removed capabilities"
																												type:        "array"
																												items: {
																													description: "Capability represent POSIX capabilities type"
																													type:        "string"
																												}
																											}
																										}
																									}
																									privileged: {
																										description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									procMount: {
																										description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows."
																										type:        "string"
																									}
																									readOnlyRootFilesystem: {
																										description: "Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows."
																										type:        "boolean"
																									}
																									runAsGroup: {
																										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									runAsNonRoot: {
																										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																										type:        "boolean"
																									}
																									runAsUser: {
																										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "integer"
																										format:      "int64"
																									}
																									seLinuxOptions: {
																										description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										properties: {
																											level: {
																												description: "Level is SELinux level label that applies to the container."
																												type:        "string"
																											}
																											role: {
																												description: "Role is a SELinux role label that applies to the container."
																												type:        "string"
																											}
																											type: {
																												description: "Type is a SELinux type label that applies to the container."
																												type:        "string"
																											}
																											user: {
																												description: "User is a SELinux user label that applies to the container."
																												type:        "string"
																											}
																										}
																									}
																									seccompProfile: {
																										description: "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
																										type:        "object"
																										required: [
																											"type",
																										]
																										properties: {
																											localhostProfile: {
																												description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																												type:        "string"
																											}
																											type: {
																												description: """
		type indicates which kind of seccomp profile will be applied. Valid options are:
		 Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
		"""
																												type: "string"
																											}
																										}
																									}
																									windowsOptions: {
																										description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
																										type:        "object"
																										properties: {
																											gmsaCredentialSpec: {
																												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
																												type:        "string"
																											}
																											gmsaCredentialSpecName: {
																												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
																												type:        "string"
																											}
																											hostProcess: {
																												description: "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
																												type:        "boolean"
																											}
																											runAsUserName: {
																												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																												type:        "string"
																											}
																										}
																									}
																								}
																							}
																							startupProbe: {
																								description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																								type:        "object"
																								properties: {
																									exec: {
																										description: "Exec specifies the action to take."
																										type:        "object"
																										properties: command: {
																											description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																											type:        "array"
																											items: type: "string"
																										}
																									}
																									failureThreshold: {
																										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									grpc: {
																										description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											port: {
																												description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																												type:        "integer"
																												format:      "int32"
																											}
																											service: {
																												description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																												type: "string"
																											}
																										}
																									}
																									httpGet: {
																										description: "HTTPGet specifies the http request to perform."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																												type:        "string"
																											}
																											httpHeaders: {
																												description: "Custom headers to set in the request. HTTP allows repeated headers."
																												type:        "array"
																												items: {
																													description: "HTTPHeader describes a custom header to be used in HTTP probes"
																													type:        "object"
																													required: [
																														"name",
																														"value",
																													]
																													properties: {
																														name: {
																															description: "The header field name"
																															type:        "string"
																														}
																														value: {
																															description: "The header field value"
																															type:        "string"
																														}
																													}
																												}
																											}
																											path: {
																												description: "Path to access on the HTTP server."
																												type:        "string"
																											}
																											port: {
																												description: "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																											scheme: {
																												description: "Scheme to use for connecting to the host. Defaults to HTTP."
																												type:        "string"
																											}
																										}
																									}
																									initialDelaySeconds: {
																										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																									periodSeconds: {
																										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									successThreshold: {
																										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																										type:        "integer"
																										format:      "int32"
																									}
																									tcpSocket: {
																										description: "TCPSocket specifies an action involving a TCP port."
																										type:        "object"
																										required: [
																											"port",
																										]
																										properties: {
																											host: {
																												description: "Optional: Host name to connect to, defaults to the pod IP."
																												type:        "string"
																											}
																											port: {
																												description: "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																												anyOf: [{
																													type: "integer"
																												}, {
																													type: "string"
																												}]
																												"x-kubernetes-int-or-string": true
																											}
																										}
																									}
																									terminationGracePeriodSeconds: {
																										description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																										type:        "integer"
																										format:      "int64"
																									}
																									timeoutSeconds: {
																										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																										type:        "integer"
																										format:      "int32"
																									}
																								}
																							}
																							stdin: {
																								description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
																								type:        "boolean"
																							}
																							stdinOnce: {
																								description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
																								type:        "boolean"
																							}
																							terminationMessagePath: {
																								description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
																								type:        "string"
																							}
																							terminationMessagePolicy: {
																								description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
																								type:        "string"
																							}
																							tty: {
																								description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
																								type:        "boolean"
																							}
																							volumeDevices: {
																								description: "volumeDevices is the list of block devices to be used by the container."
																								type:        "array"
																								items: {
																									description: "volumeDevice describes a mapping of a raw block device within a container."
																									type:        "object"
																									required: [
																										"devicePath",
																										"name",
																									]
																									properties: {
																										devicePath: {
																											description: "devicePath is the path inside of the container that the device will be mapped to."
																											type:        "string"
																										}
																										name: {
																											description: "name must match the name of a persistentVolumeClaim in the pod"
																											type:        "string"
																										}
																									}
																								}
																							}
																							volumeMounts: {
																								description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
																								type:        "array"
																								items: {
																									description: "VolumeMount describes a mounting of a Volume within a container."
																									type:        "object"
																									required: [
																										"mountPath",
																										"name",
																									]
																									properties: {
																										mountPath: {
																											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
																											type:        "string"
																										}
																										mountPropagation: {
																											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
																											type:        "string"
																										}
																										name: {
																											description: "This must match the Name of a Volume."
																											type:        "string"
																										}
																										readOnly: {
																											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
																											type:        "boolean"
																										}
																										subPath: {
																											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
																											type:        "string"
																										}
																										subPathExpr: {
																											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
																											type:        "string"
																										}
																									}
																								}
																							}
																							workingDir: {
																								description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
																								type:        "string"
																							}
																						}
																					}
																				}
																				nodeName: {
																					description: "NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements."
																					type:        "string"
																				}
																				nodeSelector: {
																					description: "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
																					type:        "object"
																					additionalProperties: type: "string"
																					"x-kubernetes-map-type": "atomic"
																				}
																				os: {
																					description: """
		Specifies the OS of the containers in the pod. Some pod and container fields are restricted if this is set.
		 If the OS field is set to linux, the following fields must be unset: -securityContext.windowsOptions
		 If the OS field is set to windows, following fields must be unset: - spec.hostPID - spec.hostIPC - spec.hostUsers - spec.securityContext.seLinuxOptions - spec.securityContext.seccompProfile - spec.securityContext.fsGroup - spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls - spec.shareProcessNamespace - spec.securityContext.runAsUser - spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups - spec.containers[*].securityContext.seLinuxOptions - spec.containers[*].securityContext.seccompProfile - spec.containers[*].securityContext.capabilities - spec.containers[*].securityContext.readOnlyRootFilesystem - spec.containers[*].securityContext.privileged - spec.containers[*].securityContext.allowPrivilegeEscalation - spec.containers[*].securityContext.procMount - spec.containers[*].securityContext.runAsUser - spec.containers[*].securityContext.runAsGroup
		"""
																					type: "object"
																					required: [
																						"name",
																					]
																					properties: name: {
																						description: "Name is the name of the operating system. The currently supported values are linux and windows. Additional value may be defined in future and can be one of: https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration Clients should expect to handle additional values and treat unrecognized values in this field as os: null"
																						type:        "string"
																					}
																				}
																				overhead: {
																					description: "Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md"
																					type:        "object"
																					additionalProperties: {
																						pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						"x-kubernetes-int-or-string": true
																					}
																				}
																				preemptionPolicy: {
																					description: "PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset."
																					type:        "string"
																				}
																				priority: {
																					description: "The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority."
																					type:        "integer"
																					format:      "int32"
																				}
																				priorityClassName: {
																					description: "If specified, indicates the pod's priority. \"system-node-critical\" and \"system-cluster-critical\" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default."
																					type:        "string"
																				}
																				readinessGates: {
																					description: "If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to \"True\" More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates"
																					type:        "array"
																					items: {
																						description: "PodReadinessGate contains the reference to a pod condition"
																						type:        "object"
																						required: [
																							"conditionType",
																						]
																						properties: conditionType: {
																							description: "ConditionType refers to a condition in the pod's condition list with matching type."
																							type:        "string"
																						}
																					}
																				}
																				restartPolicy: {
																					description: "Restart policy for all containers within the pod. One of Always, OnFailure, Never. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy"
																					type:        "string"
																				}
																				runtimeClassName: {
																					description: "RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the \"legacy\" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class"
																					type:        "string"
																				}
																				schedulerName: {
																					description: "If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler."
																					type:        "string"
																				}
																				securityContext: {
																					description: "SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field."
																					type:        "object"
																					properties: {
																						fsGroup: {
																							description: """
		A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
		 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
		 If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.
		"""
																							type:   "integer"
																							format: "int64"
																						}
																						fsGroupChangePolicy: {
																							description: "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used. Note that this field cannot be set when spec.os.name is windows."
																							type:        "string"
																						}
																						runAsGroup: {
																							description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
																							type:        "integer"
																							format:      "int64"
																						}
																						runAsNonRoot: {
																							description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																							type:        "boolean"
																						}
																						runAsUser: {
																							description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
																							type:        "integer"
																							format:      "int64"
																						}
																						seLinuxOptions: {
																							description: "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
																							type:        "object"
																							properties: {
																								level: {
																									description: "Level is SELinux level label that applies to the container."
																									type:        "string"
																								}
																								role: {
																									description: "Role is a SELinux role label that applies to the container."
																									type:        "string"
																								}
																								type: {
																									description: "Type is a SELinux type label that applies to the container."
																									type:        "string"
																								}
																								user: {
																									description: "User is a SELinux user label that applies to the container."
																									type:        "string"
																								}
																							}
																						}
																						seccompProfile: {
																							description: "The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows."
																							type:        "object"
																							required: [
																								"type",
																							]
																							properties: {
																								localhostProfile: {
																									description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																									type:        "string"
																								}
																								type: {
																									description: """
		type indicates which kind of seccomp profile will be applied. Valid options are:
		 Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.
		"""
																									type: "string"
																								}
																							}
																						}
																						supplementalGroups: {
																							description: "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container. Note that this field cannot be set when spec.os.name is windows."
																							type:        "array"
																							items: {
																								type:   "integer"
																								format: "int64"
																							}
																						}
																						sysctls: {
																							description: "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows."
																							type:        "array"
																							items: {
																								description: "Sysctl defines a kernel parameter to be set"
																								type:        "object"
																								required: [
																									"name",
																									"value",
																								]
																								properties: {
																									name: {
																										description: "Name of a property to set"
																										type:        "string"
																									}
																									value: {
																										description: "Value of a property to set"
																										type:        "string"
																									}
																								}
																							}
																						}
																						windowsOptions: {
																							description: "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
																							type:        "object"
																							properties: {
																								gmsaCredentialSpec: {
																									description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
																									type:        "string"
																								}
																								gmsaCredentialSpecName: {
																									description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
																									type:        "string"
																								}
																								hostProcess: {
																									description: "HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true."
																									type:        "boolean"
																								}
																								runAsUserName: {
																									description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																									type:        "string"
																								}
																							}
																						}
																					}
																				}
																				serviceAccount: {
																					description: "DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead."
																					type:        "string"
																				}
																				serviceAccountName: {
																					description: "ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/"
																					type:        "string"
																				}
																				setHostnameAsFQDN: {
																					description: "If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default). In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname). In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\\\SYSTEM\\\\CurrentControlSet\\\\Services\\\\Tcpip\\\\Parameters to FQDN. If a pod does not have FQDN, this has no effect. Default to false."
																					type:        "boolean"
																				}
																				shareProcessNamespace: {
																					description: "Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false."
																					type:        "boolean"
																				}
																				subdomain: {
																					description: "If specified, the fully qualified Pod hostname will be \"<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>\". If not specified, the pod will not have a domainname at all."
																					type:        "string"
																				}
																				terminationGracePeriodSeconds: {
																					description: "Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds."
																					type:        "integer"
																					format:      "int64"
																				}
																				tolerations: {
																					description: "If specified, the pod's tolerations."
																					type:        "array"
																					items: {
																						description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
																						type:        "object"
																						properties: {
																							effect: {
																								description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
																								type:        "string"
																							}
																							key: {
																								description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
																								type:        "string"
																							}
																							operator: {
																								description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
																								type:        "string"
																							}
																							tolerationSeconds: {
																								description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
																								type:        "integer"
																								format:      "int64"
																							}
																							value: {
																								description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
																								type:        "string"
																							}
																						}
																					}
																				}
																				topologySpreadConstraints: {
																					description: "TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed."
																					type:        "array"
																					items: {
																						description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
																						type:        "object"
																						required: [
																							"maxSkew",
																							"topologyKey",
																							"whenUnsatisfiable",
																						]
																						properties: {
																							labelSelector: {
																								description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
																								type:        "object"
																								properties: {
																									matchExpressions: {
																										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																										type:        "array"
																										items: {
																											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																											type:        "object"
																											required: [
																												"key",
																												"operator",
																											]
																											properties: {
																												key: {
																													description: "key is the label key that the selector applies to."
																													type:        "string"
																												}
																												operator: {
																													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																													type:        "string"
																												}
																												values: {
																													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																													type:        "array"
																													items: type: "string"
																												}
																											}
																										}
																									}
																									matchLabels: {
																										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																										type:        "object"
																										additionalProperties: type: "string"
																									}
																								}
																							}
																							matchLabelKeys: {
																								description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector."
																								type:        "array"
																								items: type: "string"
																								"x-kubernetes-list-type": "atomic"
																							}
																							maxSkew: {
																								description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
																								type:        "integer"
																								format:      "int32"
																							}
																							minDomains: {
																								description: """
		MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
		 For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
		 This is a beta field and requires the MinDomainsInPodTopologySpread feature gate to be enabled (enabled by default).
		"""
																								type:   "integer"
																								format: "int32"
																							}
																							nodeAffinityPolicy: {
																								description: """
		NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.
		 If this value is nil, the behavior is equivalent to the Honor policy. This is a alpha-level feature enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
		"""
																								type: "string"
																							}
																							nodeTaintsPolicy: {
																								description: """
		NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.
		 If this value is nil, the behavior is equivalent to the Ignore policy. This is a alpha-level feature enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
		"""
																								type: "string"
																							}
																							topologyKey: {
																								description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes meet the requirements of nodeAffinityPolicy and nodeTaintsPolicy. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field."
																								type:        "string"
																							}
																							whenUnsatisfiable: {
																								description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location, but giving higher precedence to topologies that would help reduce the skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
																								type:        "string"
																							}
																						}
																					}
																					"x-kubernetes-list-map-keys": [
																						"topologyKey",
																						"whenUnsatisfiable",
																					]
																					"x-kubernetes-list-type": "map"
																				}
																				volumes: {
																					description: "List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes"
																					type:        "array"
																					items: {
																						description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
																						type:        "object"
																						required: [
																							"name",
																						]
																						properties: {
																							awsElasticBlockStore: {
																								description: "awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
																								type:        "object"
																								required: [
																									"volumeID",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
																										type:        "string"
																									}
																									partition: {
																										description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
																										type:        "integer"
																										format:      "int32"
																									}
																									readOnly: {
																										description: "readOnly value true will force the readOnly setting in VolumeMounts. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
																										type:        "boolean"
																									}
																									volumeID: {
																										description: "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
																										type:        "string"
																									}
																								}
																							}
																							azureDisk: {
																								description: "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
																								type:        "object"
																								required: [
																									"diskName",
																									"diskURI",
																								]
																								properties: {
																									cachingMode: {
																										description: "cachingMode is the Host Caching mode: None, Read Only, Read Write."
																										type:        "string"
																									}
																									diskName: {
																										description: "diskName is the Name of the data disk in the blob storage"
																										type:        "string"
																									}
																									diskURI: {
																										description: "diskURI is the URI of data disk in the blob storage"
																										type:        "string"
																									}
																									fsType: {
																										description: "fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
																										type:        "string"
																									}
																									kind: {
																										description: "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																								}
																							}
																							azureFile: {
																								description: "azureFile represents an Azure File Service mount on the host and bind mount to the pod."
																								type:        "object"
																								required: [
																									"secretName",
																									"shareName",
																								]
																								properties: {
																									readOnly: {
																										description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									secretName: {
																										description: "secretName is the  name of secret that contains Azure Storage Account Name and Key"
																										type:        "string"
																									}
																									shareName: {
																										description: "shareName is the azure share Name"
																										type:        "string"
																									}
																								}
																							}
																							cephfs: {
																								description: "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
																								type:        "object"
																								required: [
																									"monitors",
																								]
																								properties: {
																									monitors: {
																										description: "monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																										type:        "array"
																										items: type: "string"
																									}
																									path: {
																										description: "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																										type:        "boolean"
																									}
																									secretFile: {
																										description: "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																										type:        "string"
																									}
																									secretRef: {
																										description: "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									user: {
																										description: "user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																										type:        "string"
																									}
																								}
																							}
																							cinder: {
																								description: "cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
																								type:        "object"
																								required: [
																									"volumeID",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef is optional: points to a secret object containing parameters used to connect to OpenStack."
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									volumeID: {
																										description: "volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
																										type:        "string"
																									}
																								}
																							}
																							configMap: {
																								description: "configMap represents a configMap that should populate this volume"
																								type:        "object"
																								properties: {
																									defaultMode: {
																										description: "defaultMode is optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																										type:        "integer"
																										format:      "int32"
																									}
																									items: {
																										description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																										type:        "array"
																										items: {
																											description: "Maps a string key to a path within a volume."
																											type:        "object"
																											required: [
																												"key",
																												"path",
																											]
																											properties: {
																												key: {
																													description: "key is the key to project."
																													type:        "string"
																												}
																												mode: {
																													description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																													type:        "integer"
																													format:      "int32"
																												}
																												path: {
																													description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																													type:        "string"
																												}
																											}
																										}
																									}
																									name: {
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "optional specify whether the ConfigMap or its keys must be defined"
																										type:        "boolean"
																									}
																								}
																							}
																							csi: {
																								description: "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature)."
																								type:        "object"
																								required: [
																									"driver",
																								]
																								properties: {
																									driver: {
																										description: "driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
																										type:        "string"
																									}
																									fsType: {
																										description: "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
																										type:        "string"
																									}
																									nodePublishSecretRef: {
																										description: "nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									readOnly: {
																										description: "readOnly specifies a read-only configuration for the volume. Defaults to false (read/write)."
																										type:        "boolean"
																									}
																									volumeAttributes: {
																										description: "volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
																										type:        "object"
																										additionalProperties: type: "string"
																									}
																								}
																							}
																							downwardAPI: {
																								description: "downwardAPI represents downward API about the pod that should populate this volume"
																								type:        "object"
																								properties: {
																									defaultMode: {
																										description: "Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																										type:        "integer"
																										format:      "int32"
																									}
																									items: {
																										description: "Items is a list of downward API volume file"
																										type:        "array"
																										items: {
																											description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																											type:        "object"
																											required: [
																												"path",
																											]
																											properties: {
																												fieldRef: {
																													description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																													type:        "object"
																													required: [
																														"fieldPath",
																													]
																													properties: {
																														apiVersion: {
																															description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																															type:        "string"
																														}
																														fieldPath: {
																															description: "Path of the field to select in the specified API version."
																															type:        "string"
																														}
																													}
																												}
																												mode: {
																													description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																													type:        "integer"
																													format:      "int32"
																												}
																												path: {
																													description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																													type:        "string"
																												}
																												resourceFieldRef: {
																													description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																													type:        "object"
																													required: [
																														"resource",
																													]
																													properties: {
																														containerName: {
																															description: "Container name: required for volumes, optional for env vars"
																															type:        "string"
																														}
																														divisor: {
																															description: "Specifies the output format of the exposed resources, defaults to \"1\""
																															pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																															anyOf: [{
																																type: "integer"
																															}, {
																																type: "string"
																															}]
																															"x-kubernetes-int-or-string": true
																														}
																														resource: {
																															description: "Required: resource to select"
																															type:        "string"
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							emptyDir: {
																								description: "emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
																								type:        "object"
																								properties: {
																									medium: {
																										description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
																										type:        "string"
																									}
																									sizeLimit: {
																										description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
																										pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																										anyOf: [{
																											type: "integer"
																										}, {
																											type: "string"
																										}]
																										"x-kubernetes-int-or-string": true
																									}
																								}
																							}
																							ephemeral: {
																								description: """
		ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed.
		 Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity tracking are needed, c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through a PersistentVolumeClaim (see EphemeralVolumeSource for more information on the connection between this volume type and PersistentVolumeClaim).
		 Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod.
		 Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information.
		 A pod can use both types of ephemeral volumes and persistent volumes at the same time.
		"""
																								type: "object"
																								properties: volumeClaimTemplate: {
																									description: """
		Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long).
		 An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster.
		 This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created.
		 Required, must not be nil.
		"""
																									type: "object"
																									required: [
																										"spec",
																									]
																									properties: {
																										metadata: {
																											description: "May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation."
																											type:        "object"
																										}
																										spec: {
																											description: "The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here."
																											type:        "object"
																											properties: {
																												accessModes: {
																													description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																													type:        "array"
																													items: type: "string"
																												}
																												dataSource: {
																													description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
																													type:        "object"
																													required: [
																														"kind",
																														"name",
																													]
																													properties: {
																														apiGroup: {
																															description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																															type:        "string"
																														}
																														kind: {
																															description: "Kind is the type of resource being referenced"
																															type:        "string"
																														}
																														name: {
																															description: "Name is the name of resource being referenced"
																															type:        "string"
																														}
																													}
																												}
																												dataSourceRef: {
																													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
																													type:        "object"
																													required: [
																														"kind",
																														"name",
																													]
																													properties: {
																														apiGroup: {
																															description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																															type:        "string"
																														}
																														kind: {
																															description: "Kind is the type of resource being referenced"
																															type:        "string"
																														}
																														name: {
																															description: "Name is the name of resource being referenced"
																															type:        "string"
																														}
																													}
																												}
																												resources: {
																													description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
																													type:        "object"
																													properties: {
																														limits: {
																															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																															type:        "object"
																															additionalProperties: {
																																pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																																anyOf: [{
																																	type: "integer"
																																}, {
																																	type: "string"
																																}]
																																"x-kubernetes-int-or-string": true
																															}
																														}
																														requests: {
																															description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																															type:        "object"
																															additionalProperties: {
																																pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																																anyOf: [{
																																	type: "integer"
																																}, {
																																	type: "string"
																																}]
																																"x-kubernetes-int-or-string": true
																															}
																														}
																													}
																												}
																												selector: {
																													description: "selector is a label query over volumes to consider for binding."
																													type:        "object"
																													properties: {
																														matchExpressions: {
																															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																															type:        "array"
																															items: {
																																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																																type:        "object"
																																required: [
																																	"key",
																																	"operator",
																																]
																																properties: {
																																	key: {
																																		description: "key is the label key that the selector applies to."
																																		type:        "string"
																																	}
																																	operator: {
																																		description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																																		type:        "string"
																																	}
																																	values: {
																																		description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																																		type:        "array"
																																		items: type: "string"
																																	}
																																}
																															}
																														}
																														matchLabels: {
																															description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																															type:        "object"
																															additionalProperties: type: "string"
																														}
																													}
																												}
																												storageClassName: {
																													description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																													type:        "string"
																												}
																												volumeMode: {
																													description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
																													type:        "string"
																												}
																												volumeName: {
																													description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																													type:        "string"
																												}
																											}
																										}
																									}
																								}
																							}
																							fc: {
																								description: "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
																								type:        "object"
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
																										type:        "string"
																									}
																									lun: {
																										description: "lun is Optional: FC target lun number"
																										type:        "integer"
																										format:      "int32"
																									}
																									readOnly: {
																										description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									targetWWNs: {
																										description: "targetWWNs is Optional: FC target worldwide names (WWNs)"
																										type:        "array"
																										items: type: "string"
																									}
																									wwids: {
																										description: "wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
																										type:        "array"
																										items: type: "string"
																									}
																								}
																							}
																							flexVolume: {
																								description: "flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
																								type:        "object"
																								required: [
																									"driver",
																								]
																								properties: {
																									driver: {
																										description: "driver is the name of the driver to use for this volume."
																										type:        "string"
																									}
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
																										type:        "string"
																									}
																									options: {
																										description: "options is Optional: this field holds extra command options if any."
																										type:        "object"
																										additionalProperties: type: "string"
																									}
																									readOnly: {
																										description: "readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																								}
																							}
																							flocker: {
																								description: "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
																								type:        "object"
																								properties: {
																									datasetName: {
																										description: "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
																										type:        "string"
																									}
																									datasetUUID: {
																										description: "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset"
																										type:        "string"
																									}
																								}
																							}
																							gcePersistentDisk: {
																								description: "gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																								type:        "object"
																								required: [
																									"pdName",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
																										type:        "string"
																									}
																									partition: {
																										description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																										type:        "integer"
																										format:      "int32"
																									}
																									pdName: {
																										description: "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																										type:        "boolean"
																									}
																								}
																							}
																							gitRepo: {
																								description: "gitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
																								type:        "object"
																								required: [
																									"repository",
																								]
																								properties: {
																									directory: {
																										description: "directory is the target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
																										type:        "string"
																									}
																									repository: {
																										description: "repository is the URL"
																										type:        "string"
																									}
																									revision: {
																										description: "revision is the commit hash for the specified revision."
																										type:        "string"
																									}
																								}
																							}
																							glusterfs: {
																								description: "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
																								type:        "object"
																								required: [
																									"endpoints",
																									"path",
																								]
																								properties: {
																									endpoints: {
																										description: "endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
																										type:        "string"
																									}
																									path: {
																										description: "path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
																										type:        "boolean"
																									}
																								}
																							}
																							hostPath: {
																								description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
																								type:        "object"
																								required: [
																									"path",
																								]
																								properties: {
																									path: {
																										description: "path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
																										type:        "string"
																									}
																									type: {
																										description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
																										type:        "string"
																									}
																								}
																							}
																							iscsi: {
																								description: "iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
																								type:        "object"
																								required: [
																									"iqn",
																									"lun",
																									"targetPortal",
																								]
																								properties: {
																									chapAuthDiscovery: {
																										description: "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication"
																										type:        "boolean"
																									}
																									chapAuthSession: {
																										description: "chapAuthSession defines whether support iSCSI Session CHAP authentication"
																										type:        "boolean"
																									}
																									fsType: {
																										description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
																										type:        "string"
																									}
																									initiatorName: {
																										description: "initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
																										type:        "string"
																									}
																									iqn: {
																										description: "iqn is the target iSCSI Qualified Name."
																										type:        "string"
																									}
																									iscsiInterface: {
																										description: "iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
																										type:        "string"
																									}
																									lun: {
																										description: "lun represents iSCSI Target Lun number."
																										type:        "integer"
																										format:      "int32"
																									}
																									portals: {
																										description: "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
																										type:        "array"
																										items: type: "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef is the CHAP Secret for iSCSI target and initiator authentication"
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									targetPortal: {
																										description: "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
																										type:        "string"
																									}
																								}
																							}
																							name: {
																								description: "name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																								type:        "string"
																							}
																							nfs: {
																								description: "nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
																								type:        "object"
																								required: [
																									"path",
																									"server",
																								]
																								properties: {
																									path: {
																										description: "path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
																										type:        "boolean"
																									}
																									server: {
																										description: "server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
																										type:        "string"
																									}
																								}
																							}
																							persistentVolumeClaim: {
																								description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																								type:        "object"
																								required: [
																									"claimName",
																								]
																								properties: {
																									claimName: {
																										description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly Will force the ReadOnly setting in VolumeMounts. Default false."
																										type:        "boolean"
																									}
																								}
																							}
																							photonPersistentDisk: {
																								description: "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
																								type:        "object"
																								required: [
																									"pdID",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
																										type:        "string"
																									}
																									pdID: {
																										description: "pdID is the ID that identifies Photon Controller persistent disk"
																										type:        "string"
																									}
																								}
																							}
																							portworxVolume: {
																								description: "portworxVolume represents a portworx volume attached and mounted on kubelets host machine"
																								type:        "object"
																								required: [
																									"volumeID",
																								]
																								properties: {
																									fsType: {
																										description: "fSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									volumeID: {
																										description: "volumeID uniquely identifies a Portworx volume"
																										type:        "string"
																									}
																								}
																							}
																							projected: {
																								description: "projected items for all in one resources secrets, configmaps, and downward API"
																								type:        "object"
																								properties: {
																									defaultMode: {
																										description: "defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																										type:        "integer"
																										format:      "int32"
																									}
																									sources: {
																										description: "sources is the list of volume projections"
																										type:        "array"
																										items: {
																											description: "Projection that may be projected along with other supported volume types"
																											type:        "object"
																											properties: {
																												configMap: {
																													description: "configMap information about the configMap data to project"
																													type:        "object"
																													properties: {
																														items: {
																															description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																															type:        "array"
																															items: {
																																description: "Maps a string key to a path within a volume."
																																type:        "object"
																																required: [
																																	"key",
																																	"path",
																																]
																																properties: {
																																	key: {
																																		description: "key is the key to project."
																																		type:        "string"
																																	}
																																	mode: {
																																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																																		type:        "integer"
																																		format:      "int32"
																																	}
																																	path: {
																																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																																		type:        "string"
																																	}
																																}
																															}
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "optional specify whether the ConfigMap or its keys must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																												downwardAPI: {
																													description: "downwardAPI information about the downwardAPI data to project"
																													type:        "object"
																													properties: items: {
																														description: "Items is a list of DownwardAPIVolume file"
																														type:        "array"
																														items: {
																															description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																															type:        "object"
																															required: [
																																"path",
																															]
																															properties: {
																																fieldRef: {
																																	description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																																	type:        "object"
																																	required: [
																																		"fieldPath",
																																	]
																																	properties: {
																																		apiVersion: {
																																			description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																																			type:        "string"
																																		}
																																		fieldPath: {
																																			description: "Path of the field to select in the specified API version."
																																			type:        "string"
																																		}
																																	}
																																}
																																mode: {
																																	description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																																	type:        "integer"
																																	format:      "int32"
																																}
																																path: {
																																	description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																																	type:        "string"
																																}
																																resourceFieldRef: {
																																	description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																																	type:        "object"
																																	required: [
																																		"resource",
																																	]
																																	properties: {
																																		containerName: {
																																			description: "Container name: required for volumes, optional for env vars"
																																			type:        "string"
																																		}
																																		divisor: {
																																			description: "Specifies the output format of the exposed resources, defaults to \"1\""
																																			pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																																			anyOf: [{
																																				type: "integer"
																																			}, {
																																				type: "string"
																																			}]
																																			"x-kubernetes-int-or-string": true
																																		}
																																		resource: {
																																			description: "Required: resource to select"
																																			type:        "string"
																																		}
																																	}
																																}
																															}
																														}
																													}
																												}
																												secret: {
																													description: "secret information about the secret data to project"
																													type:        "object"
																													properties: {
																														items: {
																															description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																															type:        "array"
																															items: {
																																description: "Maps a string key to a path within a volume."
																																type:        "object"
																																required: [
																																	"key",
																																	"path",
																																]
																																properties: {
																																	key: {
																																		description: "key is the key to project."
																																		type:        "string"
																																	}
																																	mode: {
																																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																																		type:        "integer"
																																		format:      "int32"
																																	}
																																	path: {
																																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																																		type:        "string"
																																	}
																																}
																															}
																														}
																														name: {
																															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																															type:        "string"
																														}
																														optional: {
																															description: "optional field specify whether the Secret or its key must be defined"
																															type:        "boolean"
																														}
																													}
																												}
																												serviceAccountToken: {
																													description: "serviceAccountToken is information about the serviceAccountToken data to project"
																													type:        "object"
																													required: [
																														"path",
																													]
																													properties: {
																														audience: {
																															description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																															type:        "string"
																														}
																														expirationSeconds: {
																															description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																															type:        "integer"
																															format:      "int64"
																														}
																														path: {
																															description: "path is the path relative to the mount point of the file to project the token into."
																															type:        "string"
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																							quobyte: {
																								description: "quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
																								type:        "object"
																								required: [
																									"registry",
																									"volume",
																								]
																								properties: {
																									group: {
																										description: "group to map volume access to Default is no group"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
																										type:        "boolean"
																									}
																									registry: {
																										description: "registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
																										type:        "string"
																									}
																									tenant: {
																										description: "tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
																										type:        "string"
																									}
																									user: {
																										description: "user to map volume access to Defaults to serivceaccount user"
																										type:        "string"
																									}
																									volume: {
																										description: "volume is a string that references an already created Quobyte volume by name."
																										type:        "string"
																									}
																								}
																							}
																							rbd: {
																								description: "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
																								type:        "object"
																								required: [
																									"image",
																									"monitors",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
																										type:        "string"
																									}
																									image: {
																										description: "image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "string"
																									}
																									keyring: {
																										description: "keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "string"
																									}
																									monitors: {
																										description: "monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "array"
																										items: type: "string"
																									}
																									pool: {
																										description: "pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									user: {
																										description: "user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																										type:        "string"
																									}
																								}
																							}
																							scaleIO: {
																								description: "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
																								type:        "object"
																								required: [
																									"gateway",
																									"secretRef",
																									"system",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
																										type:        "string"
																									}
																									gateway: {
																										description: "gateway is the host address of the ScaleIO API Gateway."
																										type:        "string"
																									}
																									protectionDomain: {
																										description: "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage."
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									sslEnabled: {
																										description: "sslEnabled Flag enable/disable SSL communication with Gateway, default false"
																										type:        "boolean"
																									}
																									storageMode: {
																										description: "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
																										type:        "string"
																									}
																									storagePool: {
																										description: "storagePool is the ScaleIO Storage Pool associated with the protection domain."
																										type:        "string"
																									}
																									system: {
																										description: "system is the name of the storage system as configured in ScaleIO."
																										type:        "string"
																									}
																									volumeName: {
																										description: "volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source."
																										type:        "string"
																									}
																								}
																							}
																							secret: {
																								description: "secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
																								type:        "object"
																								properties: {
																									defaultMode: {
																										description: "defaultMode is Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																										type:        "integer"
																										format:      "int32"
																									}
																									items: {
																										description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																										type:        "array"
																										items: {
																											description: "Maps a string key to a path within a volume."
																											type:        "object"
																											required: [
																												"key",
																												"path",
																											]
																											properties: {
																												key: {
																													description: "key is the key to project."
																													type:        "string"
																												}
																												mode: {
																													description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																													type:        "integer"
																													format:      "int32"
																												}
																												path: {
																													description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																													type:        "string"
																												}
																											}
																										}
																									}
																									optional: {
																										description: "optional field specify whether the Secret or its keys must be defined"
																										type:        "boolean"
																									}
																									secretName: {
																										description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
																										type:        "string"
																									}
																								}
																							}
																							storageos: {
																								description: "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
																								type:        "object"
																								properties: {
																									fsType: {
																										description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
																										type:        "string"
																									}
																									readOnly: {
																										description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																										type:        "boolean"
																									}
																									secretRef: {
																										description: "secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
																										type:        "object"
																										properties: name: {
																											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																											type:        "string"
																										}
																									}
																									volumeName: {
																										description: "volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
																										type:        "string"
																									}
																									volumeNamespace: {
																										description: "volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
																										type:        "string"
																									}
																								}
																							}
																							vsphereVolume: {
																								description: "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
																								type:        "object"
																								required: [
																									"volumePath",
																								]
																								properties: {
																									fsType: {
																										description: "fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
																										type:        "string"
																									}
																									storagePolicyID: {
																										description: "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
																										type:        "string"
																									}
																									storagePolicyName: {
																										description: "storagePolicyName is the storage Policy Based Management (SPBM) profile name."
																										type:        "string"
																									}
																									volumePath: {
																										description: "volumePath is the path that identifies vSphere volume vmdk"
																										type:        "string"
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
											permissions: {
												type: "array"
												items: {
													description: "StrategyDeploymentPermissions describe the rbac rules and service account needed by the install strategy"
													type:        "object"
													required: [
														"rules",
														"serviceAccountName",
													]
													properties: {
														rules: {
															type: "array"
															items: {
																description: "PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to."
																type:        "object"
																required: [
																	"verbs",
																]
																properties: {
																	apiGroups: {
																		description: "APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. \"\" represents the core API group and \"*\" represents all API groups."
																		type:        "array"
																		items: type: "string"
																	}
																	nonResourceURLs: {
																		description: "NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as \"pods\" or \"secrets\") or non-resource URL paths (such as \"/api\"),  but not both."
																		type:        "array"
																		items: type: "string"
																	}
																	resourceNames: {
																		description: "ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed."
																		type:        "array"
																		items: type: "string"
																	}
																	resources: {
																		description: "Resources is a list of resources this rule applies to. '*' represents all resources."
																		type:        "array"
																		items: type: "string"
																	}
																	verbs: {
																		description: "Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs."
																		type:        "array"
																		items: type: "string"
																	}
																}
															}
														}
														serviceAccountName: type: "string"
													}
												}
											}
										}
									}
									strategy: type: "string"
								}
							}
							installModes: {
								description: "InstallModes specify supported installation types"
								type:        "array"
								items: {
									description: "InstallMode associates an InstallModeType with a flag representing if the CSV supports it"
									type:        "object"
									required: [
										"supported",
										"type",
									]
									properties: {
										supported: type: "boolean"
										type: {
											description: "InstallModeType is a supported type of install mode for CSV installation"
											type:        "string"
										}
									}
								}
							}
							keywords: {
								type: "array"
								items: type: "string"
							}
							labels: {
								description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects."
								type:        "object"
								additionalProperties: type: "string"
							}
							links: {
								type: "array"
								items: {
									type: "object"
									properties: {
										name: type: "string"
										url: type:  "string"
									}
								}
							}
							maintainers: {
								type: "array"
								items: {
									type: "object"
									properties: {
										email: type: "string"
										name: type:  "string"
									}
								}
							}
							maturity: type:       "string"
							minKubeVersion: type: "string"
							nativeAPIs: {
								type: "array"
								items: {
									description: "GroupVersionKind unambiguously identifies a kind.  It doesn't anonymously include GroupVersion to avoid automatic coercion.  It doesn't use a GroupVersion to avoid custom marshalling"
									type:        "object"
									required: [
										"group",
										"kind",
										"version",
									]
									properties: {
										group: type:   "string"
										kind: type:    "string"
										version: type: "string"
									}
								}
							}
							provider: {
								type: "object"
								properties: {
									name: type: "string"
									url: type:  "string"
								}
							}
							relatedImages: {
								description: "List any related images, or other container images that your Operator might require to perform their functions. This list should also include operand images as well. All image references should be specified by digest (SHA) and not by tag. This field is only used during catalog creation and plays no part in cluster runtime."
								type:        "array"
								items: {
									type: "object"
									required: [
										"image",
										"name",
									]
									properties: {
										image: type: "string"
										name: type:  "string"
									}
								}
							}
							replaces: {
								description: "The name of a CSV this one replaces. Should match the `metadata.Name` field of the old CSV."
								type:        "string"
							}
							selector: {
								description: "Label selector for related resources."
								type:        "object"
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										type:        "array"
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											type:        "object"
											required: [
												"key",
												"operator",
											]
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													type:        "array"
													items: type: "string"
												}
											}
										}
									}
									matchLabels: {
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
										additionalProperties: type: "string"
									}
								}
							}
							skips: {
								description: "The name(s) of one or more CSV(s) that should be skipped in the upgrade graph. Should match the `metadata.Name` field of the CSV that should be skipped. This field is only used during catalog creation and plays no part in cluster runtime."
								type:        "array"
								items: type: "string"
							}
							version: type: "string"
							webhookdefinitions: {
								type: "array"
								items: {
									description: "WebhookDescription provides details to OLM about required webhooks"
									type:        "object"
									required: [
										"admissionReviewVersions",
										"generateName",
										"sideEffects",
										"type",
									]
									properties: {
										admissionReviewVersions: {
											type: "array"
											items: type: "string"
										}
										containerPort: {
											type:    "integer"
											format:  "int32"
											default: 443
											maximum: 65535
											minimum: 1
										}
										conversionCRDs: {
											type: "array"
											items: type: "string"
										}
										deploymentName: type: "string"
										failurePolicy: {
											description: "FailurePolicyType specifies a failure policy that defines how unrecognized errors from the admission endpoint are handled."
											type:        "string"
										}
										generateName: type: "string"
										matchPolicy: {
											description: "MatchPolicyType specifies the type of match policy."
											type:        "string"
										}
										objectSelector: {
											description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."
											type:        "object"
											properties: {
												matchExpressions: {
													description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
													type:        "array"
													items: {
														description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
														type:        "object"
														required: [
															"key",
															"operator",
														]
														properties: {
															key: {
																description: "key is the label key that the selector applies to."
																type:        "string"
															}
															operator: {
																description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																type:        "string"
															}
															values: {
																description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																type:        "array"
																items: type: "string"
															}
														}
													}
												}
												matchLabels: {
													description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
													type:        "object"
													additionalProperties: type: "string"
												}
											}
										}
										reinvocationPolicy: {
											description: "ReinvocationPolicyType specifies what type of policy the admission hook uses."
											type:        "string"
										}
										rules: {
											type: "array"
											items: {
												description: "RuleWithOperations is a tuple of Operations and Resources. It is recommended to make sure that all the tuple expansions are valid."
												type:        "object"
												properties: {
													apiGroups: {
														description: "APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required."
														type:        "array"
														items: type: "string"
													}
													apiVersions: {
														description: "APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required."
														type:        "array"
														items: type: "string"
													}
													operations: {
														description: "Operations is the operations the admission hook cares about - CREATE, UPDATE, DELETE, CONNECT or * for all of those operations and any future admission operations that are added. If '*' is present, the length of the slice must be one. Required."
														type:        "array"
														items: {
															description: "OperationType specifies an operation for a request."
															type:        "string"
														}
													}
													resources: {
														description: """
		Resources is a list of resources this rule applies to.
		 For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.
		 If wildcard is present, the validation rule will ensure resources do not overlap with each other.
		 Depending on the enclosing object, subresources might not be allowed. Required.
		"""
														type: "array"
														items: type: "string"
													}
													scope: {
														description: "scope specifies the scope of this rule. Valid values are \"Cluster\", \"Namespaced\", and \"*\" \"Cluster\" means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. \"Namespaced\" means that only namespaced resources will match this rule. \"*\" means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is \"*\"."
														type:        "string"
													}
												}
											}
										}
										sideEffects: {
											description: "SideEffectClass specifies the types of side effects a webhook may have."
											type:        "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											"x-kubernetes-int-or-string": true
										}
										timeoutSeconds: {
											type:   "integer"
											format: "int32"
										}
										type: {
											description: "WebhookAdmissionType is the type of admission webhooks supported by OLM"
											type:        "string"
											enum: [
												"ValidatingAdmissionWebhook",
												"MutatingAdmissionWebhook",
												"ConversionWebhook",
											]
										}
										webhookPath: type: "string"
									}
								}
							}
						}
					}
					status: {
						description: "ClusterServiceVersionStatus represents information about the status of a CSV. Status may trail the actual state of a system."
						type:        "object"
						properties: {
							certsLastUpdated: {
								description: "Last time the owned APIService certs were updated"
								type:        "string"
								format:      "date-time"
							}
							certsRotateAt: {
								description: "Time the owned APIService certs will rotate next"
								type:        "string"
								format:      "date-time"
							}
							cleanup: {
								description: "CleanupStatus represents information about the status of cleanup while a CSV is pending deletion"
								type:        "object"
								properties: pendingDeletion: {
									description: "PendingDeletion is the list of custom resource objects that are pending deletion and blocked on finalizers. This indicates the progress of cleanup that is blocking CSV deletion or operator uninstall."
									type:        "array"
									items: {
										description: "ResourceList represents a list of resources which are of the same Group/Kind"
										type:        "object"
										required: [
											"group",
											"instances",
											"kind",
										]
										properties: {
											group: type: "string"
											instances: {
												type: "array"
												items: {
													type: "object"
													required: [
														"name",
													]
													properties: {
														name: type: "string"
														namespace: {
															description: "Namespace can be empty for cluster-scoped resources"
															type:        "string"
														}
													}
												}
											}
											kind: type: "string"
										}
									}
								}
							}
							conditions: {
								description: "List of conditions, a history of state transitions"
								type:        "array"
								items: {
									description: "Conditions appear in the status as a record of state transitions on the ClusterServiceVersion"
									type:        "object"
									properties: {
										lastTransitionTime: {
											description: "Last time the status transitioned from one status to another."
											type:        "string"
											format:      "date-time"
										}
										lastUpdateTime: {
											description: "Last time we updated the status"
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "A human readable message indicating details about why the ClusterServiceVersion is in this condition."
											type:        "string"
										}
										phase: {
											description: "Condition of the ClusterServiceVersion"
											type:        "string"
										}
										reason: {
											description: "A brief CamelCase message indicating details about why the ClusterServiceVersion is in this state. e.g. 'RequirementsNotMet'"
											type:        "string"
										}
									}
								}
							}
							lastTransitionTime: {
								description: "Last time the status transitioned from one status to another."
								type:        "string"
								format:      "date-time"
							}
							lastUpdateTime: {
								description: "Last time we updated the status"
								type:        "string"
								format:      "date-time"
							}
							message: {
								description: "A human readable message indicating details about why the ClusterServiceVersion is in this condition."
								type:        "string"
							}
							phase: {
								description: "Current condition of the ClusterServiceVersion"
								type:        "string"
							}
							reason: {
								description: "A brief CamelCase message indicating details about why the ClusterServiceVersion is in this state. e.g. 'RequirementsNotMet'"
								type:        "string"
							}
							requirementStatus: {
								description: "The status of each requirement for this CSV"
								type:        "array"
								items: {
									type: "object"
									required: [
										"group",
										"kind",
										"message",
										"name",
										"status",
										"version",
									]
									properties: {
										dependents: {
											type: "array"
											items: {
												description: "DependentStatus is the status for a dependent requirement (to prevent infinite nesting)"
												type:        "object"
												required: [
													"group",
													"kind",
													"status",
													"version",
												]
												properties: {
													group: type:   "string"
													kind: type:    "string"
													message: type: "string"
													status: {
														description: "StatusReason is a camelcased reason for the status of a RequirementStatus or DependentStatus"
														type:        "string"
													}
													uuid: type:    "string"
													version: type: "string"
												}
											}
										}
										group: type:   "string"
										kind: type:    "string"
										message: type: "string"
										name: type:    "string"
										status: {
											description: "StatusReason is a camelcased reason for the status of a RequirementStatus or DependentStatus"
											type:        "string"
										}
										uuid: type:    "string"
										version: type: "string"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "installplans.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "InstallPlan"
			listKind: "InstallPlanList"
			plural:   "installplans"
			shortNames: [
				"ip",
			]
			singular: "installplan"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The first CSV in the list of clusterServiceVersionNames"
				jsonPath:    ".spec.clusterServiceVersionNames[0]"
				name:        "CSV"
				type:        "string"
			}, {
				description: "The approval mode"
				jsonPath:    ".spec.approval"
				name:        "Approval"
				type:        "string"
			}, {
				jsonPath: ".spec.approved"
				name:     "Approved"
				type:     "boolean"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "InstallPlan defines the installation of a set of operators."
				type:        "object"
				required: [
					"metadata",
					"spec",
				]
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
						description: "InstallPlanSpec defines a set of Application resources to be installed"
						type:        "object"
						required: [
							"approval",
							"approved",
							"clusterServiceVersionNames",
						]
						properties: {
							approval: {
								description: "Approval is the user approval policy for an InstallPlan. It must be one of \"Automatic\" or \"Manual\"."
								type:        "string"
							}
							approved: type: "boolean"
							clusterServiceVersionNames: {
								type: "array"
								items: type: "string"
							}
							generation: type:      "integer"
							source: type:          "string"
							sourceNamespace: type: "string"
						}
					}
					status: {
						description: """
		InstallPlanStatus represents the information about the status of steps required to complete installation.
		 Status may trail the actual state of a system.
		"""
						type: "object"
						required: [
							"catalogSources",
							"phase",
						]
						properties: {
							attenuatedServiceAccountRef: {
								description: "AttenuatedServiceAccountRef references the service account that is used to do scoped operator install."
								type:        "object"
								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									fieldPath: {
										description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
										type:        "string"
									}
									resourceVersion: {
										description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
										type:        "string"
									}
									uid: {
										description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
										type:        "string"
									}
								}
							}
							bundleLookups: {
								description: "BundleLookups is the set of in-progress requests to pull and unpackage bundle content to the cluster."
								type:        "array"
								items: {
									description: "BundleLookup is a request to pull and unpackage the content of a bundle to the cluster."
									type:        "object"
									required: [
										"catalogSourceRef",
										"identifier",
										"path",
										"replaces",
									]
									properties: {
										catalogSourceRef: {
											description: "CatalogSourceRef is a reference to the CatalogSource the bundle path was resolved from."
											type:        "object"
											properties: {
												apiVersion: {
													description: "API version of the referent."
													type:        "string"
												}
												fieldPath: {
													description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
													type:        "string"
												}
												kind: {
													description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
													type:        "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
													type:        "string"
												}
												namespace: {
													description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
													type:        "string"
												}
												resourceVersion: {
													description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
													type:        "string"
												}
												uid: {
													description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
													type:        "string"
												}
											}
										}
										conditions: {
											description: "Conditions represents the overall state of a BundleLookup."
											type:        "array"
											items: {
												type: "object"
												required: [
													"status",
													"type",
												]
												properties: {
													lastTransitionTime: {
														description: "Last time the condition transitioned from one status to another."
														type:        "string"
														format:      "date-time"
													}
													lastUpdateTime: {
														description: "Last time the condition was probed."
														type:        "string"
														format:      "date-time"
													}
													message: {
														description: "A human readable message indicating details about the transition."
														type:        "string"
													}
													reason: {
														description: "The reason for the condition's last transition."
														type:        "string"
													}
													status: {
														description: "Status of the condition, one of True, False, Unknown."
														type:        "string"
													}
													type: {
														description: "Type of condition."
														type:        "string"
													}
												}
											}
										}
										identifier: {
											description: "Identifier is the catalog-unique name of the operator (the name of the CSV for bundles that contain CSVs)"
											type:        "string"
										}
										path: {
											description: "Path refers to the location of a bundle to pull. It's typically an image reference."
											type:        "string"
										}
										properties: {
											description: "The effective properties of the unpacked bundle."
											type:        "string"
										}
										replaces: {
											description: "Replaces is the name of the bundle to replace with the one found at Path."
											type:        "string"
										}
									}
								}
							}
							catalogSources: {
								type: "array"
								items: type: "string"
							}
							conditions: {
								type: "array"
								items: {
									description: "InstallPlanCondition represents the overall status of the execution of an InstallPlan."
									type:        "object"
									properties: {
										lastTransitionTime: {
											type:   "string"
											format: "date-time"
										}
										lastUpdateTime: {
											type:   "string"
											format: "date-time"
										}
										message: type: "string"
										reason: {
											description: "ConditionReason is a camelcased reason for the state transition."
											type:        "string"
										}
										status: type: "string"
										type: {
											description: "InstallPlanConditionType describes the state of an InstallPlan at a certain point as a whole."
											type:        "string"
										}
									}
								}
							}
							message: {
								description: "Message is a human-readable message containing detailed information that may be important to understanding why the plan has its current status."
								type:        "string"
							}
							phase: {
								description: "InstallPlanPhase is the current status of a InstallPlan as a whole."
								type:        "string"
							}
							plan: {
								type: "array"
								items: {
									description: "Step represents the status of an individual step in an InstallPlan."
									type:        "object"
									required: [
										"resolving",
										"resource",
										"status",
									]
									properties: {
										optional: type:  "boolean"
										resolving: type: "string"
										resource: {
											description: "StepResource represents the status of a resource to be tracked by an InstallPlan."
											type:        "object"
											required: [
												"group",
												"kind",
												"name",
												"sourceName",
												"sourceNamespace",
												"version",
											]
											properties: {
												group: type:           "string"
												kind: type:            "string"
												manifest: type:        "string"
												name: type:            "string"
												sourceName: type:      "string"
												sourceNamespace: type: "string"
												version: type:         "string"
											}
										}
										status: {
											description: "StepStatus is the current status of a particular resource an in InstallPlan"
											type:        "string"
										}
									}
								}
							}
							startTime: {
								description: "StartTime is the time when the controller began applying the resources listed in the plan to the cluster."
								type:        "string"
								format:      "date-time"
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "olmconfigs.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "OLMConfig"
			listKind: "OLMConfigList"
			plural:   "olmconfigs"
			singular: "olmconfig"
		}
		scope: "Cluster"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "OLMConfig is a resource responsible for configuring OLM."
				type:        "object"
				required: [
					"metadata",
				]
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
						description: "OLMConfigSpec is the spec for an OLMConfig resource."
						type:        "object"
						properties: features: {
							description: "Features contains the list of configurable OLM features."
							type:        "object"
							properties: disableCopiedCSVs: {
								description: "DisableCopiedCSVs is used to disable OLM's \"Copied CSV\" feature for operators installed at the cluster scope, where a cluster scoped operator is one that has been installed in an OperatorGroup that targets all namespaces. When reenabled, OLM will recreate the \"Copied CSVs\" for each cluster scoped operator."
								type:        "boolean"
							}
						}
					}
					status: {
						description: "OLMConfigStatus is the status for an OLMConfig resource."
						type:        "object"
						properties: conditions: {
							type: "array"
							items: {
								description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
								type: "object"
								required: [
									"lastTransitionTime",
									"message",
									"reason",
									"status",
									"type",
								]
								properties: {
									lastTransitionTime: {
										description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
										type:        "string"
										format:      "date-time"
									}
									message: {
										description: "message is a human readable message indicating details about the transition. This may be an empty string."
										type:        "string"
										maxLength:   32768
									}
									observedGeneration: {
										description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
										type:        "integer"
										format:      "int64"
										minimum:     0
									}
									reason: {
										description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
										type:        "string"
										maxLength:   1024
										minLength:   1
										pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
									}
									status: {
										description: "status of the condition, one of True, False, Unknown."
										type:        "string"
										enum: [
											"True",
											"False",
											"Unknown",
										]
									}
									type: {
										description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
										type:        "string"
										maxLength:   316
										pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "operatorconditions.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "OperatorCondition"
			listKind: "OperatorConditionList"
			plural:   "operatorconditions"
			shortNames: [
				"condition",
			]
			singular: "operatorcondition"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "OperatorCondition is a Custom Resource of type `OperatorCondition` which is used to convey information to OLM about the state of an operator."
				type:        "object"
				required: [
					"metadata",
				]
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
						description: "OperatorConditionSpec allows a cluster admin to convey information about the state of an operator to OLM, potentially overriding state reported by the operator."
						type:        "object"
						properties: {
							deployments: {
								type: "array"
								items: type: "string"
							}
							overrides: {
								type: "array"
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									type: "object"
									required: [
										"message",
										"reason",
										"status",
										"type",
									]
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											type:        "string"
											maxLength:   32768
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											type:        "integer"
											format:      "int64"
											minimum:     0
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											type:        "string"
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											type:        "string"
											enum: [
												"True",
												"False",
												"Unknown",
											]
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											type:        "string"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
										}
									}
								}
							}
							serviceAccounts: {
								type: "array"
								items: type: "string"
							}
						}
					}
					status: {
						description: "OperatorConditionStatus allows an operator to convey information its state to OLM. The status may trail the actual state of a system."
						type:        "object"
						properties: conditions: {
							type: "array"
							items: {
								description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
								type: "object"
								required: [
									"lastTransitionTime",
									"message",
									"reason",
									"status",
									"type",
								]
								properties: {
									lastTransitionTime: {
										description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
										type:        "string"
										format:      "date-time"
									}
									message: {
										description: "message is a human readable message indicating details about the transition. This may be an empty string."
										type:        "string"
										maxLength:   32768
									}
									observedGeneration: {
										description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
										type:        "integer"
										format:      "int64"
										minimum:     0
									}
									reason: {
										description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
										type:        "string"
										maxLength:   1024
										minLength:   1
										pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
									}
									status: {
										description: "status of the condition, one of True, False, Unknown."
										type:        "string"
										enum: [
											"True",
											"False",
											"Unknown",
										]
									}
									type: {
										description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
										type:        "string"
										maxLength:   316
										pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			name: "v2"
			schema: openAPIV3Schema: {
				description: "OperatorCondition is a Custom Resource of type `OperatorCondition` which is used to convey information to OLM about the state of an operator."
				type:        "object"
				required: [
					"metadata",
				]
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
						description: "OperatorConditionSpec allows an operator to report state to OLM and provides cluster admin with the ability to manually override state reported by the operator."
						type:        "object"
						properties: {
							conditions: {
								type: "array"
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									type: "object"
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											type:        "string"
											maxLength:   32768
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											type:        "integer"
											format:      "int64"
											minimum:     0
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											type:        "string"
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											type:        "string"
											enum: [
												"True",
												"False",
												"Unknown",
											]
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											type:        "string"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
										}
									}
								}
							}
							deployments: {
								type: "array"
								items: type: "string"
							}
							overrides: {
								type: "array"
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									type: "object"
									required: [
										"message",
										"reason",
										"status",
										"type",
									]
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											type:        "string"
											maxLength:   32768
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											type:        "integer"
											format:      "int64"
											minimum:     0
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											type:        "string"
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											type:        "string"
											enum: [
												"True",
												"False",
												"Unknown",
											]
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											type:        "string"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
										}
									}
								}
							}
							serviceAccounts: {
								type: "array"
								items: type: "string"
							}
						}
					}
					status: {
						description: "OperatorConditionStatus allows OLM to convey which conditions have been observed."
						type:        "object"
						properties: conditions: {
							type: "array"
							items: {
								description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
								type: "object"
								required: [
									"lastTransitionTime",
									"message",
									"reason",
									"status",
									"type",
								]
								properties: {
									lastTransitionTime: {
										description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
										type:        "string"
										format:      "date-time"
									}
									message: {
										description: "message is a human readable message indicating details about the transition. This may be an empty string."
										type:        "string"
										maxLength:   32768
									}
									observedGeneration: {
										description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
										type:        "integer"
										format:      "int64"
										minimum:     0
									}
									reason: {
										description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
										type:        "string"
										maxLength:   1024
										minLength:   1
										pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
									}
									status: {
										description: "status of the condition, one of True, False, Unknown."
										type:        "string"
										enum: [
											"True",
											"False",
											"Unknown",
										]
									}
									type: {
										description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
										type:        "string"
										maxLength:   316
										pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "operatorgroups.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "OperatorGroup"
			listKind: "OperatorGroupList"
			plural:   "operatorgroups"
			shortNames: [
				"og",
			]
			singular: "operatorgroup"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "OperatorGroup is the unit of multitenancy for OLM managed operators. It constrains the installation of operators in its namespace to a specified set of target namespaces."
				type:        "object"
				required: [
					"metadata",
				]
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
						description: "OperatorGroupSpec is the spec for an OperatorGroup resource."
						type:        "object"
						default: upgradeStrategy: "Default"
						properties: {
							selector: {
								description: "Selector selects the OperatorGroup's target namespaces."
								type:        "object"
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										type:        "array"
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											type:        "object"
											required: [
												"key",
												"operator",
											]
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													type:        "array"
													items: type: "string"
												}
											}
										}
									}
									matchLabels: {
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
										additionalProperties: type: "string"
									}
								}
							}
							serviceAccountName: {
								description: "ServiceAccountName is the admin specified service account which will be used to deploy operator(s) in this operator group."
								type:        "string"
							}
							staticProvidedAPIs: {
								description: "Static tells OLM not to update the OperatorGroup's providedAPIs annotation"
								type:        "boolean"
							}
							targetNamespaces: {
								description: "TargetNamespaces is an explicit set of namespaces to target. If it is set, Selector is ignored."
								type:        "array"
								items: type: "string"
								"x-kubernetes-list-type": "set"
							}
							upgradeStrategy: {
								description: """
		UpgradeStrategy defines the upgrade strategy for operators in the namespace. There are currently two supported upgrade strategies:
		 Default: OLM will only allow clusterServiceVersions to move to the replacing phase from the succeeded phase. This effectively means that OLM will not allow operators to move to the next version if an installation or upgrade has failed.
		 TechPreviewUnsafeFailForward: OLM will allow clusterServiceVersions to move to the replacing phase from the succeeded phase or from the failed phase. Additionally, OLM will generate new installPlans when a subscription references a failed installPlan and the catalog has been updated with a new upgrade for the existing set of operators.
		 WARNING: The TechPreviewUnsafeFailForward upgrade strategy is unsafe and may result in unexpected behavior or unrecoverable data loss unless you have deep understanding of the set of operators being managed in the namespace.
		"""
								type:    "string"
								default: "Default"
								enum: [
									"Default",
									"TechPreviewUnsafeFailForward",
								]
							}
						}
					}
					status: {
						description: "OperatorGroupStatus is the status for an OperatorGroupResource."
						type:        "object"
						required: [
							"lastUpdated",
						]
						properties: {
							conditions: {
								description: "Conditions is an array of the OperatorGroup's conditions."
								type:        "array"
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									type: "object"
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											type:        "string"
											maxLength:   32768
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											type:        "integer"
											format:      "int64"
											minimum:     0
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											type:        "string"
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											type:        "string"
											enum: [
												"True",
												"False",
												"Unknown",
											]
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											type:        "string"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
										}
									}
								}
							}
							lastUpdated: {
								description: "LastUpdated is a timestamp of the last time the OperatorGroup's status was Updated."
								type:        "string"
								format:      "date-time"
							}
							namespaces: {
								description: "Namespaces is the set of target namespaces for the OperatorGroup."
								type:        "array"
								items: type: "string"
								"x-kubernetes-list-type": "set"
							}
							serviceAccountRef: {
								description: "ServiceAccountRef references the service account object specified."
								type:        "object"
								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									fieldPath: {
										description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
										type:        "string"
									}
									resourceVersion: {
										description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
										type:        "string"
									}
									uid: {
										description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
										type:        "string"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: "OperatorGroup is the unit of multitenancy for OLM managed operators. It constrains the installation of operators in its namespace to a specified set of target namespaces."
				type:        "object"
				required: [
					"metadata",
				]
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
						description: "OperatorGroupSpec is the spec for an OperatorGroup resource."
						type:        "object"
						properties: {
							selector: {
								description: "Selector selects the OperatorGroup's target namespaces."
								type:        "object"
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										type:        "array"
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											type:        "object"
											required: [
												"key",
												"operator",
											]
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													type:        "array"
													items: type: "string"
												}
											}
										}
									}
									matchLabels: {
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
										additionalProperties: type: "string"
									}
								}
							}
							serviceAccountName: {
								description: "ServiceAccountName is the admin specified service account which will be used to deploy operator(s) in this operator group."
								type:        "string"
							}
							staticProvidedAPIs: {
								description: "Static tells OLM not to update the OperatorGroup's providedAPIs annotation"
								type:        "boolean"
							}
							targetNamespaces: {
								description: "TargetNamespaces is an explicit set of namespaces to target. If it is set, Selector is ignored."
								type:        "array"
								items: type: "string"
							}
						}
					}
					status: {
						description: "OperatorGroupStatus is the status for an OperatorGroupResource."
						type:        "object"
						required: [
							"lastUpdated",
						]
						properties: {
							lastUpdated: {
								description: "LastUpdated is a timestamp of the last time the OperatorGroup's status was Updated."
								type:        "string"
								format:      "date-time"
							}
							namespaces: {
								description: "Namespaces is the set of target namespaces for the OperatorGroup."
								type:        "array"
								items: type: "string"
							}
							serviceAccountRef: {
								description: "ServiceAccountRef references the service account object specified."
								type:        "object"
								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									fieldPath: {
										description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
										type:        "string"
									}
									resourceVersion: {
										description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
										type:        "string"
									}
									uid: {
										description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
										type:        "string"
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "operators.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "Operator"
			listKind: "OperatorList"
			plural:   "operators"
			singular: "operator"
		}
		scope: "Cluster"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Operator represents a cluster operator."
				type:        "object"
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
						description: "OperatorSpec defines the desired state of Operator"
						type:        "object"
					}
					status: {
						description: "OperatorStatus defines the observed state of an Operator and its components"
						type:        "object"
						properties: components: {
							description: "Components describes resources that compose the operator."
							type:        "object"
							required: [
								"labelSelector",
							]
							properties: {
								labelSelector: {
									description: "LabelSelector is a label query over a set of resources used to select the operator's components"
									type:        "object"
									properties: {
										matchExpressions: {
											description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
											type:        "array"
											items: {
												description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
												type:        "object"
												required: [
													"key",
													"operator",
												]
												properties: {
													key: {
														description: "key is the label key that the selector applies to."
														type:        "string"
													}
													operator: {
														description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
														type:        "string"
													}
													values: {
														description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
														type:        "array"
														items: type: "string"
													}
												}
											}
										}
										matchLabels: {
											description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
											type:        "object"
											additionalProperties: type: "string"
										}
									}
								}
								refs: {
									description: "Refs are a set of references to the operator's component resources, selected with LabelSelector."
									type:        "array"
									items: {
										description: "RichReference is a reference to a resource, enriched with its status conditions."
										type:        "object"
										properties: {
											apiVersion: {
												description: "API version of the referent."
												type:        "string"
											}
											conditions: {
												description: "Conditions represents the latest state of the component."
												type:        "array"
												items: {
													description: "Condition represent the latest available observations of an component's state."
													type:        "object"
													required: [
														"status",
														"type",
													]
													properties: {
														lastTransitionTime: {
															description: "Last time the condition transitioned from one status to another."
															type:        "string"
															format:      "date-time"
														}
														lastUpdateTime: {
															description: "Last time the condition was probed"
															type:        "string"
															format:      "date-time"
														}
														message: {
															description: "A human readable message indicating details about the transition."
															type:        "string"
														}
														reason: {
															description: "The reason for the condition's last transition."
															type:        "string"
														}
														status: {
															description: "Status of the condition, one of True, False, Unknown."
															type:        "string"
														}
														type: {
															description: "Type of condition."
															type:        "string"
														}
													}
												}
											}
											fieldPath: {
												description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
												type:        "string"
											}
											kind: {
												description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
												type:        "string"
											}
											namespace: {
												description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
												type:        "string"
											}
											resourceVersion: {
												description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
												type:        "string"
											}
											uid: {
												description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
												type:        "string"
											}
										}
									}
								}
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		name: "subscriptions.operators.coreos.com"
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.0"
	}
	spec: {
		group: "operators.coreos.com"
		names: {
			categories: [
				"olm",
			]
			kind:     "Subscription"
			listKind: "SubscriptionList"
			plural:   "subscriptions"
			shortNames: [
				"sub",
				"subs",
			]
			singular: "subscription"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The package subscribed to"
				jsonPath:    ".spec.name"
				name:        "Package"
				type:        "string"
			}, {
				description: "The catalog source for the specified package"
				jsonPath:    ".spec.source"
				name:        "Source"
				type:        "string"
			}, {
				description: "The channel of updates to subscribe to"
				jsonPath:    ".spec.channel"
				name:        "Channel"
				type:        "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Subscription keeps operators up to date by tracking changes to Catalogs."
				type:        "object"
				required: [
					"metadata",
					"spec",
				]
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
						description: "SubscriptionSpec defines an Application that can be installed"
						type:        "object"
						required: [
							"name",
							"source",
							"sourceNamespace",
						]
						properties: {
							channel: type: "string"
							config: {
								description: "SubscriptionConfig contains configuration specified for a subscription."
								type:        "object"
								properties: {
									affinity: {
										description: "If specified, overrides the pod's scheduling constraints. nil sub-attributes will *not* override the original values in the pod.spec for those sub-attributes. Use empty object ({}) to erase original sub-attribute values."
										type:        "object"
										properties: {
											nodeAffinity: {
												description: "Describes node affinity scheduling rules for the pod."
												type:        "object"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
														type:        "array"
														items: {
															description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
															type:        "object"
															required: [
																"preference",
																"weight",
															]
															properties: {
																preference: {
																	description: "A node selector term, associated with the corresponding weight."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			type:        "array"
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchFields: {
																			description: "A list of node selector requirements by node's fields."
																			type:        "array"
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																	}
																}
																weight: {
																	description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																	type:        "integer"
																	format:      "int32"
																}
															}
														}
													}
													requiredDuringSchedulingIgnoredDuringExecution: {
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
														type:        "object"
														required: [
															"nodeSelectorTerms",
														]
														properties: nodeSelectorTerms: {
															description: "Required. A list of node selector terms. The terms are ORed."
															type:        "array"
															items: {
																description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																type:        "object"
																properties: {
																	matchExpressions: {
																		description: "A list of node selector requirements by node's labels."
																		type:        "array"
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																			type:        "object"
																			required: [
																				"key",
																				"operator",
																			]
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																					type:        "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchFields: {
																		description: "A list of node selector requirements by node's fields."
																		type:        "array"
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																			type:        "object"
																			required: [
																				"key",
																				"operator",
																			]
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																					type:        "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
											podAffinity: {
												description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
												type:        "object"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
														type:        "array"
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
															type:        "object"
															required: [
																"podAffinityTerm",
																"weight",
															]
															properties: {
																podAffinityTerm: {
																	description: "Required. A pod affinity term, associated with the corresponding weight."
																	type:        "object"
																	required: [
																		"topologyKey",
																	]
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			type:        "object"
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					type:        "array"
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																						type:        "object"
																						required: [
																							"key",
																							"operator",
																						]
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																								type:        "array"
																								items: type: "string"
																							}
																						}
																					}
																				}
																				matchLabels: {
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																					additionalProperties: type: "string"
																				}
																			}
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			type:        "object"
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					type:        "array"
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																						type:        "object"
																						required: [
																							"key",
																							"operator",
																						]
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																								type:        "array"
																								items: type: "string"
																							}
																						}
																					}
																				}
																				matchLabels: {
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																					additionalProperties: type: "string"
																				}
																			}
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			type:        "array"
																			items: type: "string"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																}
																weight: {
																	description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																	type:        "integer"
																	format:      "int32"
																}
															}
														}
													}
													requiredDuringSchedulingIgnoredDuringExecution: {
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
														type:        "array"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
															type:        "object"
															required: [
																"topologyKey",
															]
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			type:        "array"
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchLabels: {
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																			additionalProperties: type: "string"
																		}
																	}
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			type:        "array"
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchLabels: {
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																			additionalProperties: type: "string"
																		}
																	}
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																	type:        "array"
																	items: type: "string"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
														}
													}
												}
											}
											podAntiAffinity: {
												description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
												type:        "object"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
														type:        "array"
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
															type:        "object"
															required: [
																"podAffinityTerm",
																"weight",
															]
															properties: {
																podAffinityTerm: {
																	description: "Required. A pod affinity term, associated with the corresponding weight."
																	type:        "object"
																	required: [
																		"topologyKey",
																	]
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			type:        "object"
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					type:        "array"
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																						type:        "object"
																						required: [
																							"key",
																							"operator",
																						]
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																								type:        "array"
																								items: type: "string"
																							}
																						}
																					}
																				}
																				matchLabels: {
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																					additionalProperties: type: "string"
																				}
																			}
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			type:        "object"
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					type:        "array"
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																						type:        "object"
																						required: [
																							"key",
																							"operator",
																						]
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																								type:        "array"
																								items: type: "string"
																							}
																						}
																					}
																				}
																				matchLabels: {
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																					additionalProperties: type: "string"
																				}
																			}
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			type:        "array"
																			items: type: "string"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																}
																weight: {
																	description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																	type:        "integer"
																	format:      "int32"
																}
															}
														}
													}
													requiredDuringSchedulingIgnoredDuringExecution: {
														description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
														type:        "array"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
															type:        "object"
															required: [
																"topologyKey",
															]
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			type:        "array"
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchLabels: {
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																			additionalProperties: type: "string"
																		}
																	}
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																	type:        "object"
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			type:        "array"
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				type:        "object"
																				required: [
																					"key",
																					"operator",
																				]
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						type:        "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchLabels: {
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																			additionalProperties: type: "string"
																		}
																	}
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																	type:        "array"
																	items: type: "string"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
														}
													}
												}
											}
										}
									}
									env: {
										description: "Env is a list of environment variables to set in the container. Cannot be updated."
										type:        "array"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											type:        "object"
											required: [
												"name",
											]
											properties: {
												name: {
													description: "Name of the environment variable. Must be a C_IDENTIFIER."
													type:        "string"
												}
												value: {
													description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
													type:        "string"
												}
												valueFrom: {
													description: "Source for the environment variable's value. Cannot be used if value is not empty."
													type:        "object"
													properties: {
														configMapKeyRef: {
															description: "Selects a key of a ConfigMap."
															type:        "object"
															required: [
																"key",
															]
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
														}
														fieldRef: {
															description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
															type:        "object"
															required: [
																"fieldPath",
															]
															properties: {
																apiVersion: {
																	description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																	type:        "string"
																}
																fieldPath: {
																	description: "Path of the field to select in the specified API version."
																	type:        "string"
																}
															}
														}
														resourceFieldRef: {
															description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
															type:        "object"
															required: [
																"resource",
															]
															properties: {
																containerName: {
																	description: "Container name: required for volumes, optional for env vars"
																	type:        "string"
																}
																divisor: {
																	description: "Specifies the output format of the exposed resources, defaults to \"1\""
																	pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																resource: {
																	description: "Required: resource to select"
																	type:        "string"
																}
															}
														}
														secretKeyRef: {
															description: "Selects a key of a secret in the pod's namespace"
															type:        "object"
															required: [
																"key",
															]
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
														}
													}
												}
											}
										}
									}
									envFrom: {
										description: "EnvFrom is a list of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Immutable."
										type:        "array"
										items: {
											description: "EnvFromSource represents the source of a set of ConfigMaps"
											type:        "object"
											properties: {
												configMapRef: {
													description: "The ConfigMap to select from"
													type:        "object"
													properties: {
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the ConfigMap must be defined"
															type:        "boolean"
														}
													}
												}
												prefix: {
													description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
													type:        "string"
												}
												secretRef: {
													description: "The Secret to select from"
													type:        "object"
													properties: {
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret must be defined"
															type:        "boolean"
														}
													}
												}
											}
										}
									}
									nodeSelector: {
										description: "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
										type:        "object"
										additionalProperties: type: "string"
									}
									resources: {
										description: "Resources represents compute resources required by this container. Immutable. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
										properties: {
											limits: {
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
												type:        "object"
												additionalProperties: {
													pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													"x-kubernetes-int-or-string": true
												}
											}
											requests: {
												description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
												type:        "object"
												additionalProperties: {
													pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													"x-kubernetes-int-or-string": true
												}
											}
										}
									}
									selector: {
										description: "Selector is the label selector for pods to be configured. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels."
										type:        "object"
										properties: {
											matchExpressions: {
												description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
												type:        "array"
												items: {
													description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
													type:        "object"
													required: [
														"key",
														"operator",
													]
													properties: {
														key: {
															description: "key is the label key that the selector applies to."
															type:        "string"
														}
														operator: {
															description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
															type:        "string"
														}
														values: {
															description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
															type:        "array"
															items: type: "string"
														}
													}
												}
											}
											matchLabels: {
												description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
												type:        "object"
												additionalProperties: type: "string"
											}
										}
									}
									tolerations: {
										description: "Tolerations are the pod's tolerations."
										type:        "array"
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
											type:        "object"
											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
													type:        "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
													type:        "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
													type:        "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
													type:        "integer"
													format:      "int64"
												}
												value: {
													description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
													type:        "string"
												}
											}
										}
									}
									volumeMounts: {
										description: "List of VolumeMounts to set in the container."
										type:        "array"
										items: {
											description: "VolumeMount describes a mounting of a Volume within a container."
											type:        "object"
											required: [
												"mountPath",
												"name",
											]
											properties: {
												mountPath: {
													description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
													type:        "string"
												}
												mountPropagation: {
													description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
													type:        "string"
												}
												name: {
													description: "This must match the Name of a Volume."
													type:        "string"
												}
												readOnly: {
													description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
													type:        "boolean"
												}
												subPath: {
													description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
													type:        "string"
												}
												subPathExpr: {
													description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
													type:        "string"
												}
											}
										}
									}
									volumes: {
										description: "List of Volumes to set in the podSpec."
										type:        "array"
										items: {
											description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
											type:        "object"
											required: [
												"name",
											]
											properties: {
												awsElasticBlockStore: {
													description: "awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "object"
													required: [
														"volumeID",
													]
													properties: {
														fsType: {
															description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
															type:        "string"
														}
														partition: {
															description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
															type:        "integer"
															format:      "int32"
														}
														readOnly: {
															description: "readOnly value true will force the readOnly setting in VolumeMounts. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
															type:        "boolean"
														}
														volumeID: {
															description: "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
															type:        "string"
														}
													}
												}
												azureDisk: {
													description: "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
													type:        "object"
													required: [
														"diskName",
														"diskURI",
													]
													properties: {
														cachingMode: {
															description: "cachingMode is the Host Caching mode: None, Read Only, Read Write."
															type:        "string"
														}
														diskName: {
															description: "diskName is the Name of the data disk in the blob storage"
															type:        "string"
														}
														diskURI: {
															description: "diskURI is the URI of data disk in the blob storage"
															type:        "string"
														}
														fsType: {
															description: "fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
															type:        "string"
														}
														kind: {
															description: "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
															type:        "string"
														}
														readOnly: {
															description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
													}
												}
												azureFile: {
													description: "azureFile represents an Azure File Service mount on the host and bind mount to the pod."
													type:        "object"
													required: [
														"secretName",
														"shareName",
													]
													properties: {
														readOnly: {
															description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														secretName: {
															description: "secretName is the  name of secret that contains Azure Storage Account Name and Key"
															type:        "string"
														}
														shareName: {
															description: "shareName is the azure share Name"
															type:        "string"
														}
													}
												}
												cephfs: {
													description: "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
													type:        "object"
													required: [
														"monitors",
													]
													properties: {
														monitors: {
															description: "monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
															type:        "array"
															items: type: "string"
														}
														path: {
															description: "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
															type:        "string"
														}
														readOnly: {
															description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
															type:        "boolean"
														}
														secretFile: {
															description: "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
															type:        "string"
														}
														secretRef: {
															description: "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														user: {
															description: "user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
															type:        "string"
														}
													}
												}
												cinder: {
													description: "cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "object"
													required: [
														"volumeID",
													]
													properties: {
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
															type:        "string"
														}
														readOnly: {
															description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef is optional: points to a secret object containing parameters used to connect to OpenStack."
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														volumeID: {
															description: "volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
															type:        "string"
														}
													}
												}
												configMap: {
													description: "configMap represents a configMap that should populate this volume"
													type:        "object"
													properties: {
														defaultMode: {
															description: "defaultMode is optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
															type:        "integer"
															format:      "int32"
														}
														items: {
															description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
															type:        "array"
															items: {
																description: "Maps a string key to a path within a volume."
																type:        "object"
																required: [
																	"key",
																	"path",
																]
																properties: {
																	key: {
																		description: "key is the key to project."
																		type:        "string"
																	}
																	mode: {
																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		type:        "integer"
																		format:      "int32"
																	}
																	path: {
																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																		type:        "string"
																	}
																}
															}
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "optional specify whether the ConfigMap or its keys must be defined"
															type:        "boolean"
														}
													}
												}
												csi: {
													description: "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature)."
													type:        "object"
													required: [
														"driver",
													]
													properties: {
														driver: {
															description: "driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
															type:        "string"
														}
														fsType: {
															description: "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
															type:        "string"
														}
														nodePublishSecretRef: {
															description: "nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														readOnly: {
															description: "readOnly specifies a read-only configuration for the volume. Defaults to false (read/write)."
															type:        "boolean"
														}
														volumeAttributes: {
															description: "volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
															type:        "object"
															additionalProperties: type: "string"
														}
													}
												}
												downwardAPI: {
													description: "downwardAPI represents downward API about the pod that should populate this volume"
													type:        "object"
													properties: {
														defaultMode: {
															description: "Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
															type:        "integer"
															format:      "int32"
														}
														items: {
															description: "Items is a list of downward API volume file"
															type:        "array"
															items: {
																description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																type:        "object"
																required: [
																	"path",
																]
																properties: {
																	fieldRef: {
																		description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																		type:        "object"
																		required: [
																			"fieldPath",
																		]
																		properties: {
																			apiVersion: {
																				description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																				type:        "string"
																			}
																			fieldPath: {
																				description: "Path of the field to select in the specified API version."
																				type:        "string"
																			}
																		}
																	}
																	mode: {
																		description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		type:        "integer"
																		format:      "int32"
																	}
																	path: {
																		description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																		type:        "string"
																	}
																	resourceFieldRef: {
																		description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																		type:        "object"
																		required: [
																			"resource",
																		]
																		properties: {
																			containerName: {
																				description: "Container name: required for volumes, optional for env vars"
																				type:        "string"
																			}
																			divisor: {
																				description: "Specifies the output format of the exposed resources, defaults to \"1\""
																				pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				"x-kubernetes-int-or-string": true
																			}
																			resource: {
																				description: "Required: resource to select"
																				type:        "string"
																			}
																		}
																	}
																}
															}
														}
													}
												}
												emptyDir: {
													description: "emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
													type:        "object"
													properties: {
														medium: {
															description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
															type:        "string"
														}
														sizeLimit: {
															description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
															pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
												}
												ephemeral: {
													description: """
		ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed.
		 Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity tracking are needed, c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through a PersistentVolumeClaim (see EphemeralVolumeSource for more information on the connection between this volume type and PersistentVolumeClaim).
		 Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod.
		 Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information.
		 A pod can use both types of ephemeral volumes and persistent volumes at the same time.
		"""
													type: "object"
													properties: volumeClaimTemplate: {
														description: """
		Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long).
		 An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster.
		 This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created.
		 Required, must not be nil.
		"""
														type: "object"
														required: [
															"spec",
														]
														properties: {
															metadata: {
																description: "May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation."
																type:        "object"
															}
															spec: {
																description: "The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here."
																type:        "object"
																properties: {
																	accessModes: {
																		description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																		type:        "array"
																		items: type: "string"
																	}
																	dataSource: {
																		description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
																		type:        "object"
																		required: [
																			"kind",
																			"name",
																		]
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																				type:        "string"
																			}
																			kind: {
																				description: "Kind is the type of resource being referenced"
																				type:        "string"
																			}
																			name: {
																				description: "Name is the name of resource being referenced"
																				type:        "string"
																			}
																		}
																	}
																	dataSourceRef: {
																		description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
																		type:        "object"
																		required: [
																			"kind",
																			"name",
																		]
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																				type:        "string"
																			}
																			kind: {
																				description: "Kind is the type of resource being referenced"
																				type:        "string"
																			}
																			name: {
																				description: "Name is the name of resource being referenced"
																				type:        "string"
																			}
																		}
																	}
																	resources: {
																		description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
																		type:        "object"
																		properties: {
																			limits: {
																				description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																				type:        "object"
																				additionalProperties: {
																					pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					"x-kubernetes-int-or-string": true
																				}
																			}
																			requests: {
																				description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																				type:        "object"
																				additionalProperties: {
																					pattern: "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					"x-kubernetes-int-or-string": true
																				}
																			}
																		}
																	}
																	selector: {
																		description: "selector is a label query over volumes to consider for binding."
																		type:        "object"
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				type:        "array"
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																					type:        "object"
																					required: [
																						"key",
																						"operator",
																					]
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																							type:        "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: {
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																				additionalProperties: type: "string"
																			}
																		}
																	}
																	storageClassName: {
																		description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																		type:        "string"
																	}
																	volumeMode: {
																		description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
																		type:        "string"
																	}
																	volumeName: {
																		description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																		type:        "string"
																	}
																}
															}
														}
													}
												}
												fc: {
													description: "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
													type:        "object"
													properties: {
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
															type:        "string"
														}
														lun: {
															description: "lun is Optional: FC target lun number"
															type:        "integer"
															format:      "int32"
														}
														readOnly: {
															description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														targetWWNs: {
															description: "targetWWNs is Optional: FC target worldwide names (WWNs)"
															type:        "array"
															items: type: "string"
														}
														wwids: {
															description: "wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
															type:        "array"
															items: type: "string"
														}
													}
												}
												flexVolume: {
													description: "flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
													type:        "object"
													required: [
														"driver",
													]
													properties: {
														driver: {
															description: "driver is the name of the driver to use for this volume."
															type:        "string"
														}
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
															type:        "string"
														}
														options: {
															description: "options is Optional: this field holds extra command options if any."
															type:        "object"
															additionalProperties: type: "string"
														}
														readOnly: {
															description: "readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
													}
												}
												flocker: {
													description: "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
													type:        "object"
													properties: {
														datasetName: {
															description: "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
															type:        "string"
														}
														datasetUUID: {
															description: "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset"
															type:        "string"
														}
													}
												}
												gcePersistentDisk: {
													description: "gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "object"
													required: [
														"pdName",
													]
													properties: {
														fsType: {
															description: "fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
															type:        "string"
														}
														partition: {
															description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
															type:        "integer"
															format:      "int32"
														}
														pdName: {
															description: "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
															type:        "string"
														}
														readOnly: {
															description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
															type:        "boolean"
														}
													}
												}
												gitRepo: {
													description: "gitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
													type:        "object"
													required: [
														"repository",
													]
													properties: {
														directory: {
															description: "directory is the target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
															type:        "string"
														}
														repository: {
															description: "repository is the URL"
															type:        "string"
														}
														revision: {
															description: "revision is the commit hash for the specified revision."
															type:        "string"
														}
													}
												}
												glusterfs: {
													description: "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
													type:        "object"
													required: [
														"endpoints",
														"path",
													]
													properties: {
														endpoints: {
															description: "endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
															type:        "string"
														}
														path: {
															description: "path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
															type:        "string"
														}
														readOnly: {
															description: "readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
															type:        "boolean"
														}
													}
												}
												hostPath: {
													description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
													type:        "object"
													required: [
														"path",
													]
													properties: {
														path: {
															description: "path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
															type:        "string"
														}
														type: {
															description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
															type:        "string"
														}
													}
												}
												iscsi: {
													description: "iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
													type:        "object"
													required: [
														"iqn",
														"lun",
														"targetPortal",
													]
													properties: {
														chapAuthDiscovery: {
															description: "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication"
															type:        "boolean"
														}
														chapAuthSession: {
															description: "chapAuthSession defines whether support iSCSI Session CHAP authentication"
															type:        "boolean"
														}
														fsType: {
															description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
															type:        "string"
														}
														initiatorName: {
															description: "initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
															type:        "string"
														}
														iqn: {
															description: "iqn is the target iSCSI Qualified Name."
															type:        "string"
														}
														iscsiInterface: {
															description: "iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
															type:        "string"
														}
														lun: {
															description: "lun represents iSCSI Target Lun number."
															type:        "integer"
															format:      "int32"
														}
														portals: {
															description: "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
															type:        "array"
															items: type: "string"
														}
														readOnly: {
															description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef is the CHAP Secret for iSCSI target and initiator authentication"
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														targetPortal: {
															description: "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
															type:        "string"
														}
													}
												}
												name: {
													description: "name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
													type:        "string"
												}
												nfs: {
													description: "nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "object"
													required: [
														"path",
														"server",
													]
													properties: {
														path: {
															description: "path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
															type:        "string"
														}
														readOnly: {
															description: "readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
															type:        "boolean"
														}
														server: {
															description: "server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
															type:        "string"
														}
													}
												}
												persistentVolumeClaim: {
													description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													type:        "object"
													required: [
														"claimName",
													]
													properties: {
														claimName: {
															description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
															type:        "string"
														}
														readOnly: {
															description: "readOnly Will force the ReadOnly setting in VolumeMounts. Default false."
															type:        "boolean"
														}
													}
												}
												photonPersistentDisk: {
													description: "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
													type:        "object"
													required: [
														"pdID",
													]
													properties: {
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
															type:        "string"
														}
														pdID: {
															description: "pdID is the ID that identifies Photon Controller persistent disk"
															type:        "string"
														}
													}
												}
												portworxVolume: {
													description: "portworxVolume represents a portworx volume attached and mounted on kubelets host machine"
													type:        "object"
													required: [
														"volumeID",
													]
													properties: {
														fsType: {
															description: "fSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
															type:        "string"
														}
														readOnly: {
															description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														volumeID: {
															description: "volumeID uniquely identifies a Portworx volume"
															type:        "string"
														}
													}
												}
												projected: {
													description: "projected items for all in one resources secrets, configmaps, and downward API"
													type:        "object"
													properties: {
														defaultMode: {
															description: "defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
															type:        "integer"
															format:      "int32"
														}
														sources: {
															description: "sources is the list of volume projections"
															type:        "array"
															items: {
																description: "Projection that may be projected along with other supported volume types"
																type:        "object"
																properties: {
																	configMap: {
																		description: "configMap information about the configMap data to project"
																		type:        "object"
																		properties: {
																			items: {
																				description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																				type:        "array"
																				items: {
																					description: "Maps a string key to a path within a volume."
																					type:        "object"
																					required: [
																						"key",
																						"path",
																					]
																					properties: {
																						key: {
																							description: "key is the key to project."
																							type:        "string"
																						}
																						mode: {
																							description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																							type:        "integer"
																							format:      "int32"
																						}
																						path: {
																							description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																							type:        "string"
																						}
																					}
																				}
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "optional specify whether the ConfigMap or its keys must be defined"
																				type:        "boolean"
																			}
																		}
																	}
																	downwardAPI: {
																		description: "downwardAPI information about the downwardAPI data to project"
																		type:        "object"
																		properties: items: {
																			description: "Items is a list of DownwardAPIVolume file"
																			type:        "array"
																			items: {
																				description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																				type:        "object"
																				required: [
																					"path",
																				]
																				properties: {
																					fieldRef: {
																						description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																						type:        "object"
																						required: [
																							"fieldPath",
																						]
																						properties: {
																							apiVersion: {
																								description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																								type:        "string"
																							}
																							fieldPath: {
																								description: "Path of the field to select in the specified API version."
																								type:        "string"
																							}
																						}
																					}
																					mode: {
																						description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																						type:        "integer"
																						format:      "int32"
																					}
																					path: {
																						description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																						type:        "string"
																					}
																					resourceFieldRef: {
																						description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																						type:        "object"
																						required: [
																							"resource",
																						]
																						properties: {
																							containerName: {
																								description: "Container name: required for volumes, optional for env vars"
																								type:        "string"
																							}
																							divisor: {
																								description: "Specifies the output format of the exposed resources, defaults to \"1\""
																								pattern:     "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																								anyOf: [{
																									type: "integer"
																								}, {
																									type: "string"
																								}]
																								"x-kubernetes-int-or-string": true
																							}
																							resource: {
																								description: "Required: resource to select"
																								type:        "string"
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																	secret: {
																		description: "secret information about the secret data to project"
																		type:        "object"
																		properties: {
																			items: {
																				description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																				type:        "array"
																				items: {
																					description: "Maps a string key to a path within a volume."
																					type:        "object"
																					required: [
																						"key",
																						"path",
																					]
																					properties: {
																						key: {
																							description: "key is the key to project."
																							type:        "string"
																						}
																						mode: {
																							description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																							type:        "integer"
																							format:      "int32"
																						}
																						path: {
																							description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																							type:        "string"
																						}
																					}
																				}
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "optional field specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																	}
																	serviceAccountToken: {
																		description: "serviceAccountToken is information about the serviceAccountToken data to project"
																		type:        "object"
																		required: [
																			"path",
																		]
																		properties: {
																			audience: {
																				description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																				type:        "string"
																			}
																			expirationSeconds: {
																				description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																				type:        "integer"
																				format:      "int64"
																			}
																			path: {
																				description: "path is the path relative to the mount point of the file to project the token into."
																				type:        "string"
																			}
																		}
																	}
																}
															}
														}
													}
												}
												quobyte: {
													description: "quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
													type:        "object"
													required: [
														"registry",
														"volume",
													]
													properties: {
														group: {
															description: "group to map volume access to Default is no group"
															type:        "string"
														}
														readOnly: {
															description: "readOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
															type:        "boolean"
														}
														registry: {
															description: "registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
															type:        "string"
														}
														tenant: {
															description: "tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
															type:        "string"
														}
														user: {
															description: "user to map volume access to Defaults to serivceaccount user"
															type:        "string"
														}
														volume: {
															description: "volume is a string that references an already created Quobyte volume by name."
															type:        "string"
														}
													}
												}
												rbd: {
													description: "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
													type:        "object"
													required: [
														"image",
														"monitors",
													]
													properties: {
														fsType: {
															description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
															type:        "string"
														}
														image: {
															description: "image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "string"
														}
														keyring: {
															description: "keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "string"
														}
														monitors: {
															description: "monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "array"
															items: type: "string"
														}
														pool: {
															description: "pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "string"
														}
														readOnly: {
															description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														user: {
															description: "user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
															type:        "string"
														}
													}
												}
												scaleIO: {
													description: "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
													type:        "object"
													required: [
														"gateway",
														"secretRef",
														"system",
													]
													properties: {
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
															type:        "string"
														}
														gateway: {
															description: "gateway is the host address of the ScaleIO API Gateway."
															type:        "string"
														}
														protectionDomain: {
															description: "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage."
															type:        "string"
														}
														readOnly: {
															description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														sslEnabled: {
															description: "sslEnabled Flag enable/disable SSL communication with Gateway, default false"
															type:        "boolean"
														}
														storageMode: {
															description: "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
															type:        "string"
														}
														storagePool: {
															description: "storagePool is the ScaleIO Storage Pool associated with the protection domain."
															type:        "string"
														}
														system: {
															description: "system is the name of the storage system as configured in ScaleIO."
															type:        "string"
														}
														volumeName: {
															description: "volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source."
															type:        "string"
														}
													}
												}
												secret: {
													description: "secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
													type:        "object"
													properties: {
														defaultMode: {
															description: "defaultMode is Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
															type:        "integer"
															format:      "int32"
														}
														items: {
															description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
															type:        "array"
															items: {
																description: "Maps a string key to a path within a volume."
																type:        "object"
																required: [
																	"key",
																	"path",
																]
																properties: {
																	key: {
																		description: "key is the key to project."
																		type:        "string"
																	}
																	mode: {
																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		type:        "integer"
																		format:      "int32"
																	}
																	path: {
																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																		type:        "string"
																	}
																}
															}
														}
														optional: {
															description: "optional field specify whether the Secret or its keys must be defined"
															type:        "boolean"
														}
														secretName: {
															description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
															type:        "string"
														}
													}
												}
												storageos: {
													description: "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
													type:        "object"
													properties: {
														fsType: {
															description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
															type:        "string"
														}
														readOnly: {
															description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
															type:        "boolean"
														}
														secretRef: {
															description: "secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
															type:        "object"
															properties: name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
														}
														volumeName: {
															description: "volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
															type:        "string"
														}
														volumeNamespace: {
															description: "volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
															type:        "string"
														}
													}
												}
												vsphereVolume: {
													description: "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
													type:        "object"
													required: [
														"volumePath",
													]
													properties: {
														fsType: {
															description: "fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
															type:        "string"
														}
														storagePolicyID: {
															description: "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
															type:        "string"
														}
														storagePolicyName: {
															description: "storagePolicyName is the storage Policy Based Management (SPBM) profile name."
															type:        "string"
														}
														volumePath: {
															description: "volumePath is the path that identifies vSphere volume vmdk"
															type:        "string"
														}
													}
												}
											}
										}
									}
								}
							}
							installPlanApproval: {
								description: "Approval is the user approval policy for an InstallPlan. It must be one of \"Automatic\" or \"Manual\"."
								type:        "string"
							}
							name: type:            "string"
							source: type:          "string"
							sourceNamespace: type: "string"
							startingCSV: type:     "string"
						}
					}
					status: {
						type: "object"
						required: [
							"lastUpdated",
						]
						properties: {
							catalogHealth: {
								description: "CatalogHealth contains the Subscription's view of its relevant CatalogSources' status. It is used to determine SubscriptionStatusConditions related to CatalogSources."
								type:        "array"
								items: {
									description: "SubscriptionCatalogHealth describes the health of a CatalogSource the Subscription knows about."
									type:        "object"
									required: [
										"catalogSourceRef",
										"healthy",
										"lastUpdated",
									]
									properties: {
										catalogSourceRef: {
											description: "CatalogSourceRef is a reference to a CatalogSource."
											type:        "object"
											properties: {
												apiVersion: {
													description: "API version of the referent."
													type:        "string"
												}
												fieldPath: {
													description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
													type:        "string"
												}
												kind: {
													description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
													type:        "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
													type:        "string"
												}
												namespace: {
													description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
													type:        "string"
												}
												resourceVersion: {
													description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
													type:        "string"
												}
												uid: {
													description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
													type:        "string"
												}
											}
										}
										healthy: {
											description: "Healthy is true if the CatalogSource is healthy; false otherwise."
											type:        "boolean"
										}
										lastUpdated: {
											description: "LastUpdated represents the last time that the CatalogSourceHealth changed"
											type:        "string"
											format:      "date-time"
										}
									}
								}
							}
							conditions: {
								description: "Conditions is a list of the latest available observations about a Subscription's current state."
								type:        "array"
								items: {
									description: "SubscriptionCondition represents the latest available observations of a Subscription's state."
									type:        "object"
									required: [
										"status",
										"type",
									]
									properties: {
										lastHeartbeatTime: {
											description: "LastHeartbeatTime is the last time we got an update on a given condition"
											type:        "string"
											format:      "date-time"
										}
										lastTransitionTime: {
											description: "LastTransitionTime is the last time the condition transit from one status to another"
											type:        "string"
											format:      "date-time"
										}
										message: {
											description: "Message is a human-readable message indicating details about last transition."
											type:        "string"
										}
										reason: {
											description: "Reason is a one-word CamelCase reason for the condition's last transition."
											type:        "string"
										}
										status: {
											description: "Status is the status of the condition, one of True, False, Unknown."
											type:        "string"
										}
										type: {
											description: "Type is the type of Subscription condition."
											type:        "string"
										}
									}
								}
							}
							currentCSV: {
								description: "CurrentCSV is the CSV the Subscription is progressing to."
								type:        "string"
							}
							installPlanGeneration: {
								description: "InstallPlanGeneration is the current generation of the installplan"
								type:        "integer"
							}
							installPlanRef: {
								description: "InstallPlanRef is a reference to the latest InstallPlan that contains the Subscription's current CSV."
								type:        "object"
								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									fieldPath: {
										description: "If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered the event) or if no container name is specified \"spec.containers[2]\" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. TODO: this design is not final and this field is subject to change in the future."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"
										type:        "string"
									}
									resourceVersion: {
										description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency"
										type:        "string"
									}
									uid: {
										description: "UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids"
										type:        "string"
									}
								}
							}
							installedCSV: {
								description: "InstalledCSV is the CSV currently installed by the Subscription."
								type:        "string"
							}
							installplan: {
								description: "Install is a reference to the latest InstallPlan generated for the Subscription. DEPRECATED: InstallPlanRef"
								type:        "object"
								required: [
									"apiVersion",
									"kind",
									"name",
									"uuid",
								]
								properties: {
									apiVersion: type: "string"
									kind: type:       "string"
									name: type:       "string"
									uuid: {
										description: "UID is a type that holds unique ID values, including UUIDs.  Because we don't ONLY use UUIDs, this is an alias to string.  Being a type captures intent and helps make sure that UIDs and names do not get conflated."
										type:        "string"
									}
								}
							}
							lastUpdated: {
								description: "LastUpdated represents the last time that the Subscription status was updated."
								type:        "string"
								format:      "date-time"
							}
							reason: {
								description: "Reason is the reason the Subscription was transitioned to its current state."
								type:        "string"
							}
							state: {
								description: "State represents the current state of the Subscription"
								type:        "string"
							}
						}
					}
				}
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
