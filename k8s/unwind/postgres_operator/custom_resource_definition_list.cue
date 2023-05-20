package postgres_operator

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
	metadata: name: "pgupgrades.postgres-operator.crunchydata.com"
	spec: {
		group: "postgres-operator.crunchydata.com"
		names: {
			kind:     "PGUpgrade"
			listKind: "PGUpgradeList"
			plural:   "pgupgrades"
			singular: "pgupgrade"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "PGUpgrade is the Schema for the pgupgrades API"
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
						description: "PGUpgradeSpec defines the desired state of PGUpgrade"
						properties: {
							affinity: {
								description: "Scheduling constraints of the PGUpgrade pod. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
								properties: {
									nodeAffinity: {
										description: "Describes node affinity scheduling rules for the pod."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	description: "A list of node selector requirements by node's fields."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														weight: {
															description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																description: "A list of node selector requirements by node's fields."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													type: "array"
												}
												required: [
													"nodeSelectorTerms",
												]
												type: "object"
											}
										}
										type: "object"
									}
									podAffinity: {
										description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							fromPostgresVersion: {
								description: "The major version of PostgreSQL before the upgrade."
								maximum:     15
								minimum:     10
								type:        "integer"
							}
							image: {
								description: "The image name to use for major PostgreSQL upgrades."
								type:        "string"
							}
							imagePullPolicy: {
								description: "ImagePullPolicy is used to determine when Kubernetes will attempt to pull (download) container images. More info: https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy"
								enum: [
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								description: "The image pull secrets used to pull from a private registry. Changing this value causes all running PGUpgrade pods to restart. https://k8s.io/docs/tasks/configure-pod-container/pull-image-private-registry/"
								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									type: "object"
								}
								type: "array"
							}
							metadata: {
								description: "Metadata contains metadata for custom resources"
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type: "object"
							}
							postgresClusterName: {
								description: "The name of the cluster to be updated"
								minLength:   1
								type:        "string"
							}
							priorityClassName: {
								description: "Priority class name for the PGUpgrade pod. Changing this value causes PGUpgrade pod to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
								type:        "string"
							}
							resources: {
								description: "Resource requirements for the PGUpgrade container."
								properties: {
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
							toPostgresImage: {
								description: "The image name to use for PostgreSQL containers after upgrade. When omitted, the value comes from an operator environment variable."
								type:        "string"
							}
							toPostgresVersion: {
								description: "The major version of PostgreSQL to be upgraded to."
								maximum:     15
								minimum:     10
								type:        "integer"
							}
							tolerations: {
								description: "Tolerations of the PGUpgrade pod. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
											format:      "int64"
											type:        "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"fromPostgresVersion",
							"postgresClusterName",
							"toPostgresVersion",
						]
						type: "object"
					}
					status: {
						description: "PGUpgradeStatus defines the observed state of PGUpgrade"
						properties: {
							conditions: {
								description: "conditions represent the observations of PGUpgrade's current state."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
		 // other fields }
		"""
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											format:      "date-time"
											type:        "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											maxLength:   32768
											type:        "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											format:      "int64"
											minimum:     0
											type:        "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:        "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							observedGeneration: {
								description: "observedGeneration represents the .metadata.generation on which the status was based."
								format:      "int64"
								minimum:     0
								type:        "integer"
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
}, {
	metadata: name: "postgresclusters.postgres-operator.crunchydata.com"
	spec: {
		group: "postgres-operator.crunchydata.com"
		names: {
			kind:     "PostgresCluster"
			listKind: "PostgresClusterList"
			plural:   "postgresclusters"
			singular: "postgrescluster"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "PostgresCluster is the Schema for the postgresclusters API"
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
						description: "PostgresClusterSpec defines the desired state of PostgresCluster"
						properties: {
							backups: {
								description: "PostgreSQL backup configuration"
								properties: pgbackrest: {
									description: "pgBackRest archive configuration"
									properties: {
										configuration: {
											description: "Projected volumes containing custom pgBackRest configuration.  These files are mounted under \"/etc/pgbackrest/conf.d\" alongside any pgBackRest configuration generated by the PostgreSQL Operator: https://pgbackrest.org/configuration.html"
											items: {
												description: "Projection that may be projected along with other supported volume types"
												properties: {
													configMap: {
														description: "configMap information about the configMap data to project"
														properties: {
															items: {
																description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																items: {
																	description: "Maps a string key to a path within a volume."
																	properties: {
																		key: {
																			description: "key is the key to project."
																			type:        "string"
																		}
																		mode: {
																			description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																			format:      "int32"
																			type:        "integer"
																		}
																		path: {
																			description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																			type:        "string"
																		}
																	}
																	required: [
																		"key",
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																type:        "string"
															}
															optional: {
																description: "optional specify whether the ConfigMap or its keys must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													downwardAPI: {
														description: "downwardAPI information about the downwardAPI data to project"
														properties: items: {
															description: "Items is a list of DownwardAPIVolume file"
															items: {
																description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																properties: {
																	fieldRef: {
																		description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																		required: [
																			"fieldPath",
																		]
																		type: "object"
																	}
																	mode: {
																		description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		format:      "int32"
																		type:        "integer"
																	}
																	path: {
																		description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																		type:        "string"
																	}
																	resourceFieldRef: {
																		description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																		properties: {
																			containerName: {
																				description: "Container name: required for volumes, optional for env vars"
																				type:        "string"
																			}
																			divisor: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																				pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																				"x-kubernetes-int-or-string": true
																			}
																			resource: {
																				description: "Required: resource to select"
																				type:        "string"
																			}
																		}
																		required: [
																			"resource",
																		]
																		type: "object"
																	}
																}
																required: [
																	"path",
																]
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													secret: {
														description: "secret information about the secret data to project"
														properties: {
															items: {
																description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																items: {
																	description: "Maps a string key to a path within a volume."
																	properties: {
																		key: {
																			description: "key is the key to project."
																			type:        "string"
																		}
																		mode: {
																			description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																			format:      "int32"
																			type:        "integer"
																		}
																		path: {
																			description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																			type:        "string"
																		}
																	}
																	required: [
																		"key",
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																type:        "string"
															}
															optional: {
																description: "optional field specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													serviceAccountToken: {
														description: "serviceAccountToken is information about the serviceAccountToken data to project"
														properties: {
															audience: {
																description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																type:        "string"
															}
															expirationSeconds: {
																description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																format:      "int64"
																type:        "integer"
															}
															path: {
																description: "path is the path relative to the mount point of the file to project the token into."
																type:        "string"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										global: {
											additionalProperties: type: "string"
											description: "Global pgBackRest configuration settings.  These settings are included in the \"global\" section of the pgBackRest configuration generated by the PostgreSQL Operator, and then mounted under \"/etc/pgbackrest/conf.d\": https://pgbackrest.org/configuration.html"
											type:        "object"
										}
										image: {
											description: "The image name to use for pgBackRest containers.  Utilized to run pgBackRest repository hosts and backups. The image may also be set using the RELATED_IMAGE_PGBACKREST environment variable"
											type:        "string"
										}
										jobs: {
											description: "Jobs field allows configuration for all backup jobs"
											properties: {
												affinity: {
													description: "Scheduling constraints of pgBackRest backup Job pods. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
													properties: {
														nodeAffinity: {
															description: "Describes node affinity scheduling rules for the pod."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																		properties: {
																			preference: {
																				description: "A node selector term, associated with the corresponding weight."
																				properties: {
																					matchExpressions: {
																						description: "A list of node selector requirements by node's labels."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchFields: {
																						description: "A list of node selector requirements by node's fields."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			weight: {
																				description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"preference",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																	properties: nodeSelectorTerms: {
																		description: "Required. A list of node selector terms. The terms are ORed."
																		items: {
																			description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchFields: {
																					description: "A list of node selector requirements by node's fields."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	required: [
																		"nodeSelectorTerms",
																	]
																	type: "object"
																}
															}
															type: "object"
														}
														podAffinity: {
															description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														podAntiAffinity: {
															description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												priorityClassName: {
													description: "Priority class name for the pgBackRest backup Job pods. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
													type:        "string"
												}
												resources: {
													description: "Resource limits for backup jobs. Includes manual, scheduled and replica create backups"
													properties: {
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
												tolerations: {
													description: "Tolerations of pgBackRest backup Job pods. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
													items: {
														description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
																format:      "int64"
																type:        "integer"
															}
															value: {
																description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
																type:        "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												ttlSecondsAfterFinished: {
													description: "Limit the lifetime of a Job that has finished. More info: https://kubernetes.io/docs/concepts/workloads/controllers/job"
													format:      "int32"
													minimum:     60
													type:        "integer"
												}
											}
											type: "object"
										}
										manual: {
											description: "Defines details for manual pgBackRest backup Jobs"
											properties: {
												options: {
													description: "Command line options to include when running the pgBackRest backup command. https://pgbackrest.org/command.html#command-backup"
													items: type: "string"
													type: "array"
												}
												repoName: {
													description: "The name of the pgBackRest repo to run the backup command against."
													pattern:     "^repo[1-4]"
													type:        "string"
												}
											}
											required: [
												"repoName",
											]
											type: "object"
										}
										metadata: {
											description: "Metadata contains metadata for custom resources"
											properties: {
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
										repoHost: {
											description: "Defines configuration for a pgBackRest dedicated repository host.  This section is only applicable if at least one \"volume\" (i.e. PVC-based) repository is defined in the \"repos\" section, therefore enabling a dedicated repository host Deployment."
											properties: {
												affinity: {
													description: "Scheduling constraints of the Dedicated repo host pod. Changing this value causes repo host to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
													properties: {
														nodeAffinity: {
															description: "Describes node affinity scheduling rules for the pod."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																		properties: {
																			preference: {
																				description: "A node selector term, associated with the corresponding weight."
																				properties: {
																					matchExpressions: {
																						description: "A list of node selector requirements by node's labels."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchFields: {
																						description: "A list of node selector requirements by node's fields."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			weight: {
																				description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"preference",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																	properties: nodeSelectorTerms: {
																		description: "Required. A list of node selector terms. The terms are ORed."
																		items: {
																			description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchFields: {
																					description: "A list of node selector requirements by node's fields."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	required: [
																		"nodeSelectorTerms",
																	]
																	type: "object"
																}
															}
															type: "object"
														}
														podAffinity: {
															description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														podAntiAffinity: {
															description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												priorityClassName: {
													description: "Priority class name for the pgBackRest repo host pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
													type:        "string"
												}
												resources: {
													description: "Resource requirements for a pgBackRest repository host"
													properties: {
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
												sshConfigMap: {
													description: "ConfigMap containing custom SSH configuration. Deprecated: Repository hosts use mTLS for encryption, authentication, and authorization."
													properties: {
														items: {
															description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
															items: {
																description: "Maps a string key to a path within a volume."
																properties: {
																	key: {
																		description: "key is the key to project."
																		type:        "string"
																	}
																	mode: {
																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		format:      "int32"
																		type:        "integer"
																	}
																	path: {
																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																		type:        "string"
																	}
																}
																required: [
																	"key",
																	"path",
																]
																type: "object"
															}
															type: "array"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
															type:        "string"
														}
														optional: {
															description: "optional specify whether the ConfigMap or its keys must be defined"
															type:        "boolean"
														}
													}
													type: "object"
												}
												sshSecret: {
													description: "Secret containing custom SSH keys. Deprecated: Repository hosts use mTLS for encryption, authentication, and authorization."
													properties: {
														items: {
															description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
															items: {
																description: "Maps a string key to a path within a volume."
																properties: {
																	key: {
																		description: "key is the key to project."
																		type:        "string"
																	}
																	mode: {
																		description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																		format:      "int32"
																		type:        "integer"
																	}
																	path: {
																		description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																		type:        "string"
																	}
																}
																required: [
																	"key",
																	"path",
																]
																type: "object"
															}
															type: "array"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
															type:        "string"
														}
														optional: {
															description: "optional field specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													type: "object"
												}
												tolerations: {
													description: "Tolerations of a PgBackRest repo host pod. Changing this value causes a restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
													items: {
														description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
																format:      "int64"
																type:        "integer"
															}
															value: {
																description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
																type:        "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												topologySpreadConstraints: {
													description: "Topology spread constraints of a Dedicated repo host pod. Changing this value causes the repo host to restart. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"
													items: {
														description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
														properties: {
															labelSelector: {
																description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
																properties: {
																	matchExpressions: {
																		description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																		items: {
																			description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																		type:        "object"
																	}
																}
																type: "object"
															}
															maxSkew: {
																description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
																format:      "int32"
																type:        "integer"
															}
															minDomains: {
																description: """
		MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
		 For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
		 This is an alpha field and requires enabling MinDomainsInPodTopologySpread feature gate.
		"""
																format: "int32"
																type:   "integer"
															}
															topologyKey: {
																description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes match the node selector. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field."
																type:        "string"
															}
															whenUnsatisfiable: {
																description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location, but giving higher precedence to topologies that would help reduce the skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
																type:        "string"
															}
														}
														required: [
															"maxSkew",
															"topologyKey",
															"whenUnsatisfiable",
														]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										repos: {
											description: "Defines a pgBackRest repository"
											items: {
												description: "PGBackRestRepo represents a pgBackRest repository.  Only one of its members may be specified."
												properties: {
													azure: {
														description: "Represents a pgBackRest repository that is created using Azure storage"
														properties: container: {
															description: "The Azure container utilized for the repository"
															type:        "string"
														}
														required: [
															"container",
														]
														type: "object"
													}
													gcs: {
														description: "Represents a pgBackRest repository that is created using Google Cloud Storage"
														properties: bucket: {
															description: "The GCS bucket utilized for the repository"
															type:        "string"
														}
														required: [
															"bucket",
														]
														type: "object"
													}
													name: {
														description: "The name of the the repository"
														pattern:     "^repo[1-4]"
														type:        "string"
													}
													s3: {
														description: "RepoS3 represents a pgBackRest repository that is created using AWS S3 (or S3-compatible) storage"
														properties: {
															bucket: {
																description: "The S3 bucket utilized for the repository"
																type:        "string"
															}
															endpoint: {
																description: "A valid endpoint corresponding to the specified region"
																type:        "string"
															}
															region: {
																description: "The region corresponding to the S3 bucket"
																type:        "string"
															}
														}
														required: [
															"bucket",
															"endpoint",
															"region",
														]
														type: "object"
													}
													schedules: {
														description: "Defines the schedules for the pgBackRest backups Full, Differential and Incremental backup types are supported: https://pgbackrest.org/user-guide.html#concept/backup"
														properties: {
															differential: {
																description: "Defines the Cron schedule for a differential pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
															full: {
																description: "Defines the Cron schedule for a full pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
															incremental: {
																description: "Defines the Cron schedule for an incremental pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
														}
														type: "object"
													}
													volume: {
														description: "Represents a pgBackRest repository that is created using a PersistentVolumeClaim"
														properties: volumeClaimSpec: {
															description: "Defines a PersistentVolumeClaim spec used to create and/or bind a volume"
															properties: {
																accessModes: {
																	description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																	items: type: "string"
																	minItems: 1
																	type:     "array"
																}
																dataSource: {
																	description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
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
																	required: [
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																dataSourceRef: {
																	description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
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
																	required: [
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																resources: {
																	description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
																	properties: {
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
																			required: [
																				"storage",
																			]
																			type: "object"
																		}
																	}
																	required: [
																		"requests",
																	]
																	type: "object"
																}
																selector: {
																	description: "selector is a label query over volumes to consider for binding."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
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
															required: [
																"accessModes",
																"resources",
															]
															type: "object"
														}
														required: [
															"volumeClaimSpec",
														]
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											minItems: 1
											type:     "array"
											"x-kubernetes-list-map-keys": [
												"name",
											]
											"x-kubernetes-list-type": "map"
										}
										restore: {
											description: "Defines details for performing an in-place restore using pgBackRest"
											properties: {
												affinity: {
													description: "Scheduling constraints of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
													properties: {
														nodeAffinity: {
															description: "Describes node affinity scheduling rules for the pod."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																		properties: {
																			preference: {
																				description: "A node selector term, associated with the corresponding weight."
																				properties: {
																					matchExpressions: {
																						description: "A list of node selector requirements by node's labels."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchFields: {
																						description: "A list of node selector requirements by node's fields."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																				}
																				type: "object"
																			}
																			weight: {
																				description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"preference",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																	properties: nodeSelectorTerms: {
																		description: "Required. A list of node selector terms. The terms are ORed."
																		items: {
																			description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchFields: {
																					description: "A list of node selector requirements by node's fields."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	required: [
																		"nodeSelectorTerms",
																	]
																	type: "object"
																}
															}
															type: "object"
														}
														podAffinity: {
															description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														podAntiAffinity: {
															description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																		properties: {
																			podAffinityTerm: {
																				description: "Required. A pod affinity term, associated with the corresponding weight."
																				properties: {
																					labelSelector: {
																						description: "A label query over a set of resources, in this case pods."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																											items: type: "string"
																											type: "array"
																										}
																									}
																									required: [
																										"key",
																										"operator",
																									]
																									type: "object"
																								}
																								type: "array"
																							}
																							matchLabels: {
																								additionalProperties: type: "string"
																								description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																								type:        "object"
																							}
																						}
																						type: "object"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																						type:        "string"
																					}
																				}
																				required: [
																					"topologyKey",
																				]
																				type: "object"
																			}
																			weight: {
																				description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																				format:      "int32"
																				type:        "integer"
																			}
																		}
																		required: [
																			"podAffinityTerm",
																			"weight",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																requiredDuringSchedulingIgnoredDuringExecution: {
																	description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												clusterName: {
													description: "The name of an existing PostgresCluster to use as the data source for the new PostgresCluster. Defaults to the name of the PostgresCluster being created if not provided."
													type:        "string"
												}
												clusterNamespace: {
													description: "The namespace of the cluster specified as the data source using the clusterName field. Defaults to the namespace of the PostgresCluster being created if not provided."
													type:        "string"
												}
												enabled: {
													default:     false
													description: "Whether or not in-place pgBackRest restores are enabled for this PostgresCluster."
													type:        "boolean"
												}
												options: {
													description: "Command line options to include when running the pgBackRest restore command. https://pgbackrest.org/command.html#command-restore"
													items: type: "string"
													type: "array"
												}
												priorityClassName: {
													description: "Priority class name for the pgBackRest restore Job pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
													type:        "string"
												}
												repoName: {
													description: "The name of the pgBackRest repo within the source PostgresCluster that contains the backups that should be utilized to perform a pgBackRest restore when initializing the data source for the new PostgresCluster."
													pattern:     "^repo[1-4]"
													type:        "string"
												}
												resources: {
													description: "Resource requirements for the pgBackRest restore Job."
													properties: {
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
												tolerations: {
													description: "Tolerations of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
													items: {
														description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
																format:      "int64"
																type:        "integer"
															}
															value: {
																description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
																type:        "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: [
												"enabled",
												"repoName",
											]
											type: "object"
										}
										sidecars: {
											description: "Configuration for pgBackRest sidecar containers"
											properties: {
												pgbackrest: {
													description: "Defines the configuration for the pgBackRest sidecar container"
													properties: resources: {
														description: "Resource requirements for a sidecar container"
														properties: {
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
													type: "object"
												}
												pgbackrestConfig: {
													description: "Defines the configuration for the pgBackRest config sidecar container"
													properties: resources: {
														description: "Resource requirements for a sidecar container"
														properties: {
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
													type: "object"
												}
											}
											type: "object"
										}
									}
									required: [
										"repos",
									]
									type: "object"
								}
								required: [
									"pgbackrest",
								]
								type: "object"
							}
							config: {
								properties: files: {
									items: {
										description: "Projection that may be projected along with other supported volume types"
										properties: {
											configMap: {
												description: "configMap information about the configMap data to project"
												properties: {
													items: {
														description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
														items: {
															description: "Maps a string key to a path within a volume."
															properties: {
																key: {
																	description: "key is the key to project."
																	type:        "string"
																}
																mode: {
																	description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																	format:      "int32"
																	type:        "integer"
																}
																path: {
																	description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																	type:        "string"
																}
															}
															required: [
																"key",
																"path",
															]
															type: "object"
														}
														type: "array"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
														type:        "string"
													}
													optional: {
														description: "optional specify whether the ConfigMap or its keys must be defined"
														type:        "boolean"
													}
												}
												type: "object"
											}
											downwardAPI: {
												description: "downwardAPI information about the downwardAPI data to project"
												properties: items: {
													description: "Items is a list of DownwardAPIVolume file"
													items: {
														description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
														properties: {
															fieldRef: {
																description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																required: [
																	"fieldPath",
																]
																type: "object"
															}
															mode: {
																description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																type:        "string"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: [
																	"resource",
																]
																type: "object"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
											secret: {
												description: "secret information about the secret data to project"
												properties: {
													items: {
														description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
														items: {
															description: "Maps a string key to a path within a volume."
															properties: {
																key: {
																	description: "key is the key to project."
																	type:        "string"
																}
																mode: {
																	description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																	format:      "int32"
																	type:        "integer"
																}
																path: {
																	description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																	type:        "string"
																}
															}
															required: [
																"key",
																"path",
															]
															type: "object"
														}
														type: "array"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
														type:        "string"
													}
													optional: {
														description: "optional field specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												type: "object"
											}
											serviceAccountToken: {
												description: "serviceAccountToken is information about the serviceAccountToken data to project"
												properties: {
													audience: {
														description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
														type:        "string"
													}
													expirationSeconds: {
														description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
														format:      "int64"
														type:        "integer"
													}
													path: {
														description: "path is the path relative to the mount point of the file to project the token into."
														type:        "string"
													}
												}
												required: [
													"path",
												]
												type: "object"
											}
										}
										type: "object"
									}
									type: "array"
								}
								type: "object"
							}
							customReplicationTLSSecret: {
								description: "The secret containing the replication client certificates and keys for secure connections to the PostgreSQL server. It will need to contain the client TLS certificate, TLS key and the Certificate Authority certificate with the data keys set to tls.crt, tls.key and ca.crt, respectively. NOTE: If CustomReplicationClientTLSSecret is provided, CustomTLSSecret MUST be provided and the ca.crt provided must be the same."
								properties: {
									items: {
										description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
										items: {
											description: "Maps a string key to a path within a volume."
											properties: {
												key: {
													description: "key is the key to project."
													type:        "string"
												}
												mode: {
													description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												path: {
													description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
													type:        "string"
												}
											}
											required: [
												"key",
												"path",
											]
											type: "object"
										}
										type: "array"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									optional: {
										description: "optional field specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								type: "object"
							}
							customTLSSecret: {
								description: "The secret containing the Certificates and Keys to encrypt PostgreSQL traffic will need to contain the server TLS certificate, TLS key and the Certificate Authority certificate with the data keys set to tls.crt, tls.key and ca.crt, respectively. It will then be mounted as a volume projection to the '/pgconf/tls' directory. For more information on Kubernetes secret projections, please see https://k8s.io/docs/concepts/configuration/secret/#projection-of-secret-keys-to-specific-paths NOTE: If CustomTLSSecret is provided, CustomReplicationClientTLSSecret MUST be provided and the ca.crt provided must be the same."
								properties: {
									items: {
										description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
										items: {
											description: "Maps a string key to a path within a volume."
											properties: {
												key: {
													description: "key is the key to project."
													type:        "string"
												}
												mode: {
													description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												path: {
													description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
													type:        "string"
												}
											}
											required: [
												"key",
												"path",
											]
											type: "object"
										}
										type: "array"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									optional: {
										description: "optional field specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								type: "object"
							}
							dataSource: {
								description: "Specifies a data source for bootstrapping the PostgreSQL cluster."
								properties: {
									pgbackrest: {
										description: "Defines a pgBackRest cloud-based data source that can be used to pre-populate the the PostgreSQL data directory for a new PostgreSQL cluster using a pgBackRest restore. The PGBackRest field is incompatible with the PostgresCluster field: only one data source can be used for pre-populating a new PostgreSQL cluster"
										properties: {
											affinity: {
												description: "Scheduling constraints of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
												properties: {
													nodeAffinity: {
														description: "Describes node affinity scheduling rules for the pod."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																	properties: {
																		preference: {
																			description: "A node selector term, associated with the corresponding weight."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchFields: {
																					description: "A list of node selector requirements by node's fields."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		weight: {
																			description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"preference",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																properties: nodeSelectorTerms: {
																	description: "Required. A list of node selector terms. The terms are ORed."
																	items: {
																		description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																		properties: {
																			matchExpressions: {
																				description: "A list of node selector requirements by node's labels."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchFields: {
																				description: "A list of node selector requirements by node's fields."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	type: "array"
																}
																required: [
																	"nodeSelectorTerms",
																]
																type: "object"
															}
														}
														type: "object"
													}
													podAffinity: {
														description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																	properties: {
																		podAffinityTerm: {
																			description: "Required. A pod affinity term, associated with the corresponding weight."
																			properties: {
																				labelSelector: {
																					description: "A label query over a set of resources, in this case pods."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																					type:        "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"podAffinityTerm",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																items: {
																	description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																	required: [
																		"topologyKey",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													podAntiAffinity: {
														description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																	properties: {
																		podAffinityTerm: {
																			description: "Required. A pod affinity term, associated with the corresponding weight."
																			properties: {
																				labelSelector: {
																					description: "A label query over a set of resources, in this case pods."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																					type:        "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"podAffinityTerm",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																items: {
																	description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																	required: [
																		"topologyKey",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											configuration: {
												description: "Projected volumes containing custom pgBackRest configuration.  These files are mounted under \"/etc/pgbackrest/conf.d\" alongside any pgBackRest configuration generated by the PostgreSQL Operator: https://pgbackrest.org/configuration.html"
												items: {
													description: "Projection that may be projected along with other supported volume types"
													properties: {
														configMap: {
															description: "configMap information about the configMap data to project"
															properties: {
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																				type:        "string"
																			}
																		}
																		required: [
																			"key",
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																	type:        "string"
																}
																optional: {
																	description: "optional specify whether the ConfigMap or its keys must be defined"
																	type:        "boolean"
																}
															}
															type: "object"
														}
														downwardAPI: {
															description: "downwardAPI information about the downwardAPI data to project"
															properties: items: {
																description: "Items is a list of DownwardAPIVolume file"
																items: {
																	description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																	properties: {
																		fieldRef: {
																			description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																			required: [
																				"fieldPath",
																			]
																			type: "object"
																		}
																		mode: {
																			description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																			format:      "int32"
																			type:        "integer"
																		}
																		path: {
																			description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																			type:        "string"
																		}
																		resourceFieldRef: {
																			description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																			properties: {
																				containerName: {
																					description: "Container name: required for volumes, optional for env vars"
																					type:        "string"
																				}
																				divisor: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																				resource: {
																					description: "Required: resource to select"
																					type:        "string"
																				}
																			}
																			required: [
																				"resource",
																			]
																			type: "object"
																		}
																	}
																	required: [
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															type: "object"
														}
														secret: {
															description: "secret information about the secret data to project"
															properties: {
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																				type:        "string"
																			}
																		}
																		required: [
																			"key",
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																	type:        "string"
																}
																optional: {
																	description: "optional field specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															type: "object"
														}
														serviceAccountToken: {
															description: "serviceAccountToken is information about the serviceAccountToken data to project"
															properties: {
																audience: {
																	description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																	type:        "string"
																}
																expirationSeconds: {
																	description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																	format:      "int64"
																	type:        "integer"
																}
																path: {
																	description: "path is the path relative to the mount point of the file to project the token into."
																	type:        "string"
																}
															}
															required: [
																"path",
															]
															type: "object"
														}
													}
													type: "object"
												}
												type: "array"
											}
											global: {
												additionalProperties: type: "string"
												description: "Global pgBackRest configuration settings.  These settings are included in the \"global\" section of the pgBackRest configuration generated by the PostgreSQL Operator, and then mounted under \"/etc/pgbackrest/conf.d\": https://pgbackrest.org/configuration.html"
												type:        "object"
											}
											options: {
												description: "Command line options to include when running the pgBackRest restore command. https://pgbackrest.org/command.html#command-restore"
												items: type: "string"
												type: "array"
											}
											priorityClassName: {
												description: "Priority class name for the pgBackRest restore Job pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
												type:        "string"
											}
											repo: {
												description: "Defines a pgBackRest repository"
												properties: {
													azure: {
														description: "Represents a pgBackRest repository that is created using Azure storage"
														properties: container: {
															description: "The Azure container utilized for the repository"
															type:        "string"
														}
														required: [
															"container",
														]
														type: "object"
													}
													gcs: {
														description: "Represents a pgBackRest repository that is created using Google Cloud Storage"
														properties: bucket: {
															description: "The GCS bucket utilized for the repository"
															type:        "string"
														}
														required: [
															"bucket",
														]
														type: "object"
													}
													name: {
														description: "The name of the the repository"
														pattern:     "^repo[1-4]"
														type:        "string"
													}
													s3: {
														description: "RepoS3 represents a pgBackRest repository that is created using AWS S3 (or S3-compatible) storage"
														properties: {
															bucket: {
																description: "The S3 bucket utilized for the repository"
																type:        "string"
															}
															endpoint: {
																description: "A valid endpoint corresponding to the specified region"
																type:        "string"
															}
															region: {
																description: "The region corresponding to the S3 bucket"
																type:        "string"
															}
														}
														required: [
															"bucket",
															"endpoint",
															"region",
														]
														type: "object"
													}
													schedules: {
														description: "Defines the schedules for the pgBackRest backups Full, Differential and Incremental backup types are supported: https://pgbackrest.org/user-guide.html#concept/backup"
														properties: {
															differential: {
																description: "Defines the Cron schedule for a differential pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
															full: {
																description: "Defines the Cron schedule for a full pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
															incremental: {
																description: "Defines the Cron schedule for an incremental pgBackRest backup. Follows the standard Cron schedule syntax: https://k8s.io/docs/concepts/workloads/controllers/cron-jobs/#cron-schedule-syntax"
																minLength:   6
																type:        "string"
															}
														}
														type: "object"
													}
													volume: {
														description: "Represents a pgBackRest repository that is created using a PersistentVolumeClaim"
														properties: volumeClaimSpec: {
															description: "Defines a PersistentVolumeClaim spec used to create and/or bind a volume"
															properties: {
																accessModes: {
																	description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																	items: type: "string"
																	type: "array"
																}
																dataSource: {
																	description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
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
																	required: [
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																dataSourceRef: {
																	description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
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
																	required: [
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																resources: {
																	description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
																	properties: {
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
																selector: {
																	description: "selector is a label query over volumes to consider for binding."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
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
															type: "object"
														}
														required: [
															"volumeClaimSpec",
														]
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											resources: {
												description: "Resource requirements for the pgBackRest restore Job."
												properties: {
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
											stanza: {
												default:     "db"
												description: "The name of an existing pgBackRest stanza to use as the data source for the new PostgresCluster. Defaults to `db` if not provided."
												type:        "string"
											}
											tolerations: {
												description: "Tolerations of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
												items: {
													description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
															format:      "int64"
															type:        "integer"
														}
														value: {
															description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
										}
										required: [
											"repo",
											"stanza",
										]
										type: "object"
									}
									postgresCluster: {
										description: "Defines a pgBackRest data source that can be used to pre-populate the PostgreSQL data directory for a new PostgreSQL cluster using a pgBackRest restore. The PGBackRest field is incompatible with the PostgresCluster field: only one data source can be used for pre-populating a new PostgreSQL cluster"
										properties: {
											affinity: {
												description: "Scheduling constraints of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
												properties: {
													nodeAffinity: {
														description: "Describes node affinity scheduling rules for the pod."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																	properties: {
																		preference: {
																			description: "A node selector term, associated with the corresponding weight."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchFields: {
																					description: "A list of node selector requirements by node's fields."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		weight: {
																			description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"preference",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
																properties: nodeSelectorTerms: {
																	description: "Required. A list of node selector terms. The terms are ORed."
																	items: {
																		description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																		properties: {
																			matchExpressions: {
																				description: "A list of node selector requirements by node's labels."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchFields: {
																				description: "A list of node selector requirements by node's fields."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	type: "array"
																}
																required: [
																	"nodeSelectorTerms",
																]
																type: "object"
															}
														}
														type: "object"
													}
													podAffinity: {
														description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																	properties: {
																		podAffinityTerm: {
																			description: "Required. A pod affinity term, associated with the corresponding weight."
																			properties: {
																				labelSelector: {
																					description: "A label query over a set of resources, in this case pods."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																					type:        "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"podAffinityTerm",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																items: {
																	description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																	required: [
																		"topologyKey",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													podAntiAffinity: {
														description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
														properties: {
															preferredDuringSchedulingIgnoredDuringExecution: {
																description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
																items: {
																	description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																	properties: {
																		podAffinityTerm: {
																			description: "Required. A pod affinity term, associated with the corresponding weight."
																			properties: {
																				labelSelector: {
																					description: "A label query over a set of resources, in this case pods."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																					properties: {
																						matchExpressions: {
																							description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																							items: {
																								description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																										items: type: "string"
																										type: "array"
																									}
																								}
																								required: [
																									"key",
																									"operator",
																								]
																								type: "object"
																							}
																							type: "array"
																						}
																						matchLabels: {
																							additionalProperties: type: "string"
																							description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																							type:        "object"
																						}
																					}
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																					type:        "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																			format:      "int32"
																			type:        "integer"
																		}
																	}
																	required: [
																		"podAffinityTerm",
																		"weight",
																	]
																	type: "object"
																}
																type: "array"
															}
															requiredDuringSchedulingIgnoredDuringExecution: {
																description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
																items: {
																	description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																	properties: {
																		labelSelector: {
																			description: "A label query over a set of resources, in this case pods."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																			type:        "string"
																		}
																	}
																	required: [
																		"topologyKey",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											clusterName: {
												description: "The name of an existing PostgresCluster to use as the data source for the new PostgresCluster. Defaults to the name of the PostgresCluster being created if not provided."
												type:        "string"
											}
											clusterNamespace: {
												description: "The namespace of the cluster specified as the data source using the clusterName field. Defaults to the namespace of the PostgresCluster being created if not provided."
												type:        "string"
											}
											options: {
												description: "Command line options to include when running the pgBackRest restore command. https://pgbackrest.org/command.html#command-restore"
												items: type: "string"
												type: "array"
											}
											priorityClassName: {
												description: "Priority class name for the pgBackRest restore Job pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
												type:        "string"
											}
											repoName: {
												description: "The name of the pgBackRest repo within the source PostgresCluster that contains the backups that should be utilized to perform a pgBackRest restore when initializing the data source for the new PostgresCluster."
												pattern:     "^repo[1-4]"
												type:        "string"
											}
											resources: {
												description: "Resource requirements for the pgBackRest restore Job."
												properties: {
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
											tolerations: {
												description: "Tolerations of the pgBackRest restore Job. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
												items: {
													description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
															format:      "int64"
															type:        "integer"
														}
														value: {
															description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
										}
										required: [
											"repoName",
										]
										type: "object"
									}
									volumes: {
										description: "Defines any existing volumes to reuse for this PostgresCluster."
										properties: {
											pgBackRestVolume: {
												description: "Defines the existing pgBackRest repo volume and directory to use in the current PostgresCluster."
												properties: {
													directory: {
														description: "The existing directory. When not set, a move Job is not created for the associated volume."
														type:        "string"
													}
													pvcName: {
														description: "The existing PVC name."
														type:        "string"
													}
												}
												required: [
													"pvcName",
												]
												type: "object"
											}
											pgDataVolume: {
												description: "Defines the existing pgData volume and directory to use in the current PostgresCluster."
												properties: {
													directory: {
														description: "The existing directory. When not set, a move Job is not created for the associated volume."
														type:        "string"
													}
													pvcName: {
														description: "The existing PVC name."
														type:        "string"
													}
												}
												required: [
													"pvcName",
												]
												type: "object"
											}
											pgWALVolume: {
												description: "Defines the existing pg_wal volume and directory to use in the current PostgresCluster. Note that a defined pg_wal volume MUST be accompanied by a pgData volume."
												properties: {
													directory: {
														description: "The existing directory. When not set, a move Job is not created for the associated volume."
														type:        "string"
													}
													pvcName: {
														description: "The existing PVC name."
														type:        "string"
													}
												}
												required: [
													"pvcName",
												]
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							databaseInitSQL: {
								description: "DatabaseInitSQL defines a ConfigMap containing custom SQL that will be run after the cluster is initialized. This ConfigMap must be in the same namespace as the cluster."
								properties: {
									key: {
										description: "Key is the ConfigMap data key that points to a SQL string"
										type:        "string"
									}
									name: {
										description: "Name is the name of a ConfigMap"
										type:        "string"
									}
								}
								required: [
									"key",
									"name",
								]
								type: "object"
							}
							disableDefaultPodScheduling: {
								description: "Whether or not the PostgreSQL cluster should use the defined default scheduling constraints. If the field is unset or false, the default scheduling constraints will be used in addition to any custom constraints provided."
								type:        "boolean"
							}
							image: {
								description: "The image name to use for PostgreSQL containers. When omitted, the value comes from an operator environment variable. For standard PostgreSQL images, the format is RELATED_IMAGE_POSTGRES_{postgresVersion}, e.g. RELATED_IMAGE_POSTGRES_13. For PostGIS enabled PostgreSQL images, the format is RELATED_IMAGE_POSTGRES_{postgresVersion}_GIS_{postGISVersion}, e.g. RELATED_IMAGE_POSTGRES_13_GIS_3.1."
								type:        "string"
							}
							imagePullPolicy: {
								description: "ImagePullPolicy is used to determine when Kubernetes will attempt to pull (download) container images. More info: https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy"
								enum: [
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								description: "The image pull secrets used to pull from a private registry Changing this value causes all running pods to restart. https://k8s.io/docs/tasks/configure-pod-container/pull-image-private-registry/"
								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
										type:        "string"
									}
									type: "object"
								}
								type: "array"
							}
							instances: {
								description: "Specifies one or more sets of PostgreSQL pods that replicate data for this cluster."
								items: {
									properties: {
										affinity: {
											description: "Scheduling constraints of a PostgreSQL pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
											properties: {
												nodeAffinity: {
													description: "Describes node affinity scheduling rules for the pod."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
															items: {
																description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																properties: {
																	preference: {
																		description: "A node selector term, associated with the corresponding weight."
																		properties: {
																			matchExpressions: {
																				description: "A list of node selector requirements by node's labels."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchFields: {
																				description: "A list of node selector requirements by node's fields."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	weight: {
																		description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"preference",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
															properties: nodeSelectorTerms: {
																description: "Required. A list of node selector terms. The terms are ORed."
																items: {
																	description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchFields: {
																			description: "A list of node selector requirements by node's fields."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															required: [
																"nodeSelectorTerms",
															]
															type: "object"
														}
													}
													type: "object"
												}
												podAffinity: {
													description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												podAntiAffinity: {
													description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										containers: {
											description: "Custom sidecars for PostgreSQL instance pods. Changing this value causes PostgreSQL to restart."
											items: {
												description: "A single application container that you want to run within a pod."
												properties: {
													args: {
														description: "Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
														items: type: "string"
														type: "array"
													}
													command: {
														description: "Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
														items: type: "string"
														type: "array"
													}
													env: {
														description: "List of environment variables to set in the container. Cannot be updated."
														items: {
															description: "EnvVar represents an environment variable present in a Container."
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
																	properties: {
																		configMapKeyRef: {
																			description: "Selects a key of a ConfigMap."
																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																					type:        "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"
																					type:        "boolean"
																				}
																			}
																			required: [
																				"key",
																			]
																			type: "object"
																		}
																		fieldRef: {
																			description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
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
																			required: [
																				"fieldPath",
																			]
																			type: "object"
																		}
																		resourceFieldRef: {
																			description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																			properties: {
																				containerName: {
																					description: "Container name: required for volumes, optional for env vars"
																					type:        "string"
																				}
																				divisor: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																				resource: {
																					description: "Required: resource to select"
																					type:        "string"
																				}
																			}
																			required: [
																				"resource",
																			]
																			type: "object"
																		}
																		secretKeyRef: {
																			description: "Selects a key of a secret in the pod's namespace"
																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																					type:        "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"
																					type:        "boolean"
																				}
																			}
																			required: [
																				"key",
																			]
																			type: "object"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													envFrom: {
														description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
														items: {
															description: "EnvFromSource represents the source of a set of ConfigMaps"
															properties: {
																configMapRef: {
																	description: "The ConfigMap to select from"
																	properties: {
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																			type:        "string"
																		}
																		optional: {
																			description: "Specify whether the ConfigMap must be defined"
																			type:        "boolean"
																		}
																	}
																	type: "object"
																}
																prefix: {
																	description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																	type:        "string"
																}
																secretRef: {
																	description: "The Secret to select from"
																	properties: {
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																			type:        "string"
																		}
																		optional: {
																			description: "Specify whether the Secret must be defined"
																			type:        "boolean"
																		}
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														type: "array"
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
														properties: {
															postStart: {
																description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																properties: {
																	exec: {
																		description: "Exec specifies the action to take."
																		properties: command: {
																			description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	httpGet: {
																		description: "HTTPGet specifies the http request to perform."
																		properties: {
																			host: {
																				description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																				type:        "string"
																			}
																			httpHeaders: {
																				description: "Custom headers to set in the request. HTTP allows repeated headers."
																				items: {
																					description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																					required: [
																						"name",
																						"value",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			path: {
																				description: "Path to access on the HTTP server."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																			scheme: {
																				description: "Scheme to use for connecting to the host. Defaults to HTTP."
																				type:        "string"
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																	tcpSocket: {
																		description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																		properties: {
																			host: {
																				description: "Optional: Host name to connect to, defaults to the pod IP."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															preStop: {
																description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																properties: {
																	exec: {
																		description: "Exec specifies the action to take."
																		properties: command: {
																			description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	httpGet: {
																		description: "HTTPGet specifies the http request to perform."
																		properties: {
																			host: {
																				description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																				type:        "string"
																			}
																			httpHeaders: {
																				description: "Custom headers to set in the request. HTTP allows repeated headers."
																				items: {
																					description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																					required: [
																						"name",
																						"value",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			path: {
																				description: "Path to access on the HTTP server."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																			scheme: {
																				description: "Scheme to use for connecting to the host. Defaults to HTTP."
																				type:        "string"
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																	tcpSocket: {
																		description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																		properties: {
																			host: {
																				description: "Optional: Host name to connect to, defaults to the pod IP."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													livenessProbe: {
														description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
													}
													name: {
														description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
														type:        "string"
													}
													ports: {
														description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
														items: {
															description: "ContainerPort represents a network port in a single container."
															properties: {
																containerPort: {
																	description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
																	format:      "int32"
																	type:        "integer"
																}
																hostIP: {
																	description: "What host IP to bind the external port to."
																	type:        "string"
																}
																hostPort: {
																	description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
																	format:      "int32"
																	type:        "integer"
																}
																name: {
																	description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
																	type:        "string"
																}
																protocol: {
																	default:     "TCP"
																	description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
																	type:        "string"
																}
															}
															required: [
																"containerPort",
															]
															type: "object"
														}
														type: "array"
														"x-kubernetes-list-map-keys": [
															"containerPort",
															"protocol",
														]
														"x-kubernetes-list-type": "map"
													}
													readinessProbe: {
														description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
													}
													resources: {
														description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
														properties: {
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
													securityContext: {
														description: "SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
														properties: {
															allowPrivilegeEscalation: {
																description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
																type:        "boolean"
															}
															capabilities: {
																description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
																properties: {
																	add: {
																		description: "Added capabilities"
																		items: {
																			description: "Capability represent POSIX capabilities type"
																			type:        "string"
																		}
																		type: "array"
																	}
																	drop: {
																		description: "Removed capabilities"
																		items: {
																			description: "Capability represent POSIX capabilities type"
																			type:        "string"
																		}
																		type: "array"
																	}
																}
																type: "object"
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
																format:      "int64"
																type:        "integer"
															}
															runAsNonRoot: {
																description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																type:        "boolean"
															}
															runAsUser: {
																description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																format:      "int64"
																type:        "integer"
															}
															seLinuxOptions: {
																description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
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
																type: "object"
															}
															seccompProfile: {
																description: "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
																properties: {
																	localhostProfile: {
																		description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																		type:        "string"
																	}
																	type: {
																		description: "type indicates which kind of seccomp profile will be applied. Valid options are: Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied."
																		type:        "string"
																	}
																}
																required: [
																	"type",
																]
																type: "object"
															}
															windowsOptions: {
																description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
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
																type: "object"
															}
														}
														type: "object"
													}
													startupProbe: {
														description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
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
														items: {
															description: "volumeDevice describes a mapping of a raw block device within a container."
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
															required: [
																"devicePath",
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													volumeMounts: {
														description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
														items: {
															description: "VolumeMount describes a mounting of a Volume within a container."
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
															required: [
																"mountPath",
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													workingDir: {
														description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
														type:        "string"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										dataVolumeClaimSpec: {
											description: "Defines a PersistentVolumeClaim for PostgreSQL data. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes"
											properties: {
												accessModes: {
													description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
													items: type: "string"
													minItems: 1
													type:     "array"
												}
												dataSource: {
													description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												dataSourceRef: {
													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												resources: {
													description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
													properties: {
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
															required: [
																"storage",
															]
															type: "object"
														}
													}
													required: [
														"requests",
													]
													type: "object"
												}
												selector: {
													description: "selector is a label query over volumes to consider for binding."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																		items: type: "string"
																		type: "array"
																	}
																}
																required: [
																	"key",
																	"operator",
																]
																type: "object"
															}
															type: "array"
														}
														matchLabels: {
															additionalProperties: type: "string"
															description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
															type:        "object"
														}
													}
													type: "object"
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
											required: [
												"accessModes",
												"resources",
											]
											type: "object"
										}
										metadata: {
											description: "Metadata contains metadata for custom resources"
											properties: {
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
										minAvailable: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description:                  "Minimum number of pods that should be available at a time. Defaults to one when the replicas field is greater than one."
											"x-kubernetes-int-or-string": true
										}
										name: {
											default:     ""
											description: "Name that associates this set of PostgreSQL pods. This field is optional when only one instance set is defined. Each instance set in a cluster must have a unique name. The combined length of this and the cluster name must be 46 characters or less."
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?)?$"
											type:        "string"
										}
										priorityClassName: {
											description: "Priority class name for the PostgreSQL pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
											type:        "string"
										}
										replicas: {
											default:     1
											description: "Number of desired PostgreSQL pods."
											format:      "int32"
											minimum:     1
											type:        "integer"
										}
										resources: {
											description: "Compute resources of a PostgreSQL container."
											properties: {
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
										sidecars: {
											description: "Configuration for instance sidecar containers"
											properties: replicaCertCopy: {
												description: "Defines the configuration for the replica cert copy sidecar container"
												properties: resources: {
													description: "Resource requirements for a sidecar container"
													properties: {
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
												type: "object"
											}
											type: "object"
										}
										tolerations: {
											description: "Tolerations of a PostgreSQL pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
											items: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
														format:      "int64"
														type:        "integer"
													}
													value: {
														description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										topologySpreadConstraints: {
											description: "Topology spread constraints of a PostgreSQL pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"
											items: {
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
												properties: {
													labelSelector: {
														description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													maxSkew: {
														description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
														format:      "int32"
														type:        "integer"
													}
													minDomains: {
														description: """
		MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
		 For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
		 This is an alpha field and requires enabling MinDomainsInPodTopologySpread feature gate.
		"""
														format: "int32"
														type:   "integer"
													}
													topologyKey: {
														description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes match the node selector. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field."
														type:        "string"
													}
													whenUnsatisfiable: {
														description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location, but giving higher precedence to topologies that would help reduce the skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
														type:        "string"
													}
												}
												required: [
													"maxSkew",
													"topologyKey",
													"whenUnsatisfiable",
												]
												type: "object"
											}
											type: "array"
										}
										walVolumeClaimSpec: {
											description: "Defines a separate PersistentVolumeClaim for PostgreSQL's write-ahead log. More info: https://www.postgresql.org/docs/current/wal.html"
											properties: {
												accessModes: {
													description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
													items: type: "string"
													minItems: 1
													type:     "array"
												}
												dataSource: {
													description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												dataSourceRef: {
													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												resources: {
													description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
													properties: {
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
															required: [
																"storage",
															]
															type: "object"
														}
													}
													required: [
														"requests",
													]
													type: "object"
												}
												selector: {
													description: "selector is a label query over volumes to consider for binding."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																		items: type: "string"
																		type: "array"
																	}
																}
																required: [
																	"key",
																	"operator",
																]
																type: "object"
															}
															type: "array"
														}
														matchLabels: {
															additionalProperties: type: "string"
															description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
															type:        "object"
														}
													}
													type: "object"
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
											required: [
												"accessModes",
												"resources",
											]
											type: "object"
										}
									}
									required: [
										"dataVolumeClaimSpec",
									]
									type: "object"
								}
								minItems: 1
								type:     "array"
								"x-kubernetes-list-map-keys": [
									"name",
								]
								"x-kubernetes-list-type": "map"
							}
							metadata: {
								description: "Metadata contains metadata for custom resources"
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type: "object"
							}
							monitoring: {
								description: "The specification of monitoring tools that connect to PostgreSQL"
								properties: pgmonitor: {
									description: "PGMonitorSpec defines the desired state of the pgMonitor tool suite"
									properties: exporter: {
										properties: {
											configuration: {
												description: "Projected volumes containing custom PostgreSQL Exporter configuration.  Currently supports the customization of PostgreSQL Exporter queries. If a \"queries.yml\" file is detected in any volume projected using this field, it will be loaded using the \"extend.query-path\" flag: https://github.com/prometheus-community/postgres_exporter#flags Changing the values of field causes PostgreSQL and the exporter to restart."
												items: {
													description: "Projection that may be projected along with other supported volume types"
													properties: {
														configMap: {
															description: "configMap information about the configMap data to project"
															properties: {
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																				type:        "string"
																			}
																		}
																		required: [
																			"key",
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																	type:        "string"
																}
																optional: {
																	description: "optional specify whether the ConfigMap or its keys must be defined"
																	type:        "boolean"
																}
															}
															type: "object"
														}
														downwardAPI: {
															description: "downwardAPI information about the downwardAPI data to project"
															properties: items: {
																description: "Items is a list of DownwardAPIVolume file"
																items: {
																	description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																	properties: {
																		fieldRef: {
																			description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																			required: [
																				"fieldPath",
																			]
																			type: "object"
																		}
																		mode: {
																			description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																			format:      "int32"
																			type:        "integer"
																		}
																		path: {
																			description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																			type:        "string"
																		}
																		resourceFieldRef: {
																			description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																			properties: {
																				containerName: {
																					description: "Container name: required for volumes, optional for env vars"
																					type:        "string"
																				}
																				divisor: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																				resource: {
																					description: "Required: resource to select"
																					type:        "string"
																				}
																			}
																			required: [
																				"resource",
																			]
																			type: "object"
																		}
																	}
																	required: [
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															type: "object"
														}
														secret: {
															description: "secret information about the secret data to project"
															properties: {
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																				type:        "string"
																			}
																		}
																		required: [
																			"key",
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																	type:        "string"
																}
																optional: {
																	description: "optional field specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															type: "object"
														}
														serviceAccountToken: {
															description: "serviceAccountToken is information about the serviceAccountToken data to project"
															properties: {
																audience: {
																	description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																	type:        "string"
																}
																expirationSeconds: {
																	description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																	format:      "int64"
																	type:        "integer"
																}
																path: {
																	description: "path is the path relative to the mount point of the file to project the token into."
																	type:        "string"
																}
															}
															required: [
																"path",
															]
															type: "object"
														}
													}
													type: "object"
												}
												type: "array"
											}
											customTLSSecret: {
												description: "Projected secret containing custom TLS certificates to encrypt output from the exporter web server"
												properties: {
													items: {
														description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
														items: {
															description: "Maps a string key to a path within a volume."
															properties: {
																key: {
																	description: "key is the key to project."
																	type:        "string"
																}
																mode: {
																	description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																	format:      "int32"
																	type:        "integer"
																}
																path: {
																	description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																	type:        "string"
																}
															}
															required: [
																"key",
																"path",
															]
															type: "object"
														}
														type: "array"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
														type:        "string"
													}
													optional: {
														description: "optional field specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												type: "object"
											}
											image: {
												description: "The image name to use for crunchy-postgres-exporter containers. The image may also be set using the RELATED_IMAGE_PGEXPORTER environment variable."
												type:        "string"
											}
											resources: {
												description: "Changing this value causes PostgreSQL and the exporter to restart. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers"
												properties: {
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
									type: "object"
								}
								type: "object"
							}
							openshift: {
								description: "Whether or not the PostgreSQL cluster is being deployed to an OpenShift environment. If the field is unset, the operator will automatically detect the environment."
								type:        "boolean"
							}
							patroni: {
								properties: {
									dynamicConfiguration: {
										description:                            "Patroni dynamic configuration settings. Changes to this value will be automatically reloaded without validation. Changes to certain PostgreSQL parameters cause PostgreSQL to restart. More info: https://patroni.readthedocs.io/en/latest/SETTINGS.html"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									leaderLeaseDurationSeconds: {
										default:     30
										description: "TTL of the cluster leader lock. \"Think of it as the length of time before initiation of the automatic failover process.\" Changing this value causes PostgreSQL to restart."
										format:      "int32"
										minimum:     3
										type:        "integer"
									}
									port: {
										default:     8008
										description: "The port on which Patroni should listen. Changing this value causes PostgreSQL to restart."
										format:      "int32"
										minimum:     1024
										type:        "integer"
									}
									switchover: {
										description: "Switchover gives options to perform ad hoc switchovers in a PostgresCluster."
										properties: {
											enabled: {
												description: "Whether or not the operator should allow switchovers in a PostgresCluster"
												type:        "boolean"
											}
											targetInstance: {
												description: "The instance that should become primary during a switchover. This field is optional when Type is \"Switchover\" and required when Type is \"Failover\". When it is not specified, a healthy replica is automatically selected."
												type:        "string"
											}
											type: {
												default:     "Switchover"
												description: "Type of switchover to perform. Valid options are Switchover and Failover. \"Switchover\" changes the primary instance of a healthy PostgresCluster. \"Failover\" forces a particular instance to be primary, regardless of other factors. A TargetInstance must be specified to failover. NOTE: The Failover type is reserved as the \"last resort\" case."
												enum: [
													"Switchover",
													"Failover",
												]
												type: "string"
											}
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									syncPeriodSeconds: {
										default:     10
										description: "The interval for refreshing the leader lock and applying dynamicConfiguration. Must be less than leaderLeaseDurationSeconds. Changing this value causes PostgreSQL to restart."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
								}
								type: "object"
							}
							paused: {
								description: "Suspends the rollout and reconciliation of changes made to the PostgresCluster spec."
								type:        "boolean"
							}
							port: {
								default:     5432
								description: "The port on which PostgreSQL should listen."
								format:      "int32"
								minimum:     1024
								type:        "integer"
							}
							postGISVersion: {
								description: "The PostGIS extension version installed in the PostgreSQL image. When image is not set, indicates a PostGIS enabled image will be used."
								type:        "string"
							}
							postgresVersion: {
								description: "The major version of PostgreSQL installed in the PostgreSQL image"
								maximum:     15
								minimum:     10
								type:        "integer"
							}
							proxy: {
								description: "The specification of a proxy that connects to PostgreSQL."
								properties: pgBouncer: {
									description: "Defines a PgBouncer proxy and connection pooler."
									properties: {
										affinity: {
											description: "Scheduling constraints of a PgBouncer pod. Changing this value causes PgBouncer to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
											properties: {
												nodeAffinity: {
													description: "Describes node affinity scheduling rules for the pod."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
															items: {
																description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																properties: {
																	preference: {
																		description: "A node selector term, associated with the corresponding weight."
																		properties: {
																			matchExpressions: {
																				description: "A list of node selector requirements by node's labels."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchFields: {
																				description: "A list of node selector requirements by node's fields."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	weight: {
																		description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"preference",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
															properties: nodeSelectorTerms: {
																description: "Required. A list of node selector terms. The terms are ORed."
																items: {
																	description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchFields: {
																			description: "A list of node selector requirements by node's fields."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															required: [
																"nodeSelectorTerms",
															]
															type: "object"
														}
													}
													type: "object"
												}
												podAffinity: {
													description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												podAntiAffinity: {
													description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										config: {
											description: "Configuration settings for the PgBouncer process. Changes to any of these values will be automatically reloaded without validation. Be careful, as you may put PgBouncer into an unusable state. More info: https://www.pgbouncer.org/usage.html#reload"
											properties: {
												databases: {
													additionalProperties: type: "string"
													description: "PgBouncer database definitions. The key is the database requested by a client while the value is a libpq-styled connection string. The special key \"*\" acts as a fallback. When this field is empty, PgBouncer is configured with a single \"*\" entry that connects to the primary PostgreSQL instance. More info: https://www.pgbouncer.org/config.html#section-databases"
													type:        "object"
												}
												files: {
													description: "Files to mount under \"/etc/pgbouncer\". When specified, settings in the \"pgbouncer.ini\" file are loaded before all others. From there, other files may be included by absolute path. Changing these references causes PgBouncer to restart, but changes to the file contents are automatically reloaded. More info: https://www.pgbouncer.org/config.html#include-directive"
													items: {
														description: "Projection that may be projected along with other supported volume types"
														properties: {
															configMap: {
																description: "configMap information about the configMap data to project"
																properties: {
																	items: {
																		description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																		type:        "string"
																	}
																	optional: {
																		description: "optional specify whether the ConfigMap or its keys must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															downwardAPI: {
																description: "downwardAPI information about the downwardAPI data to project"
																properties: items: {
																	description: "Items is a list of DownwardAPIVolume file"
																	items: {
																		description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																		properties: {
																			fieldRef: {
																				description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																				required: [
																					"fieldPath",
																				]
																				type: "object"
																			}
																			mode: {
																				description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																				type:        "string"
																			}
																			resourceFieldRef: {
																				description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																				properties: {
																					containerName: {
																						description: "Container name: required for volumes, optional for env vars"
																						type:        "string"
																					}
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: {
																						description: "Required: resource to select"
																						type:        "string"
																					}
																				}
																				required: [
																					"resource",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																description: "secret information about the secret data to project"
																properties: {
																	items: {
																		description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																		type:        "string"
																	}
																	optional: {
																		description: "optional field specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															serviceAccountToken: {
																description: "serviceAccountToken is information about the serviceAccountToken data to project"
																properties: {
																	audience: {
																		description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																		type:        "string"
																	}
																	expirationSeconds: {
																		description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																		format:      "int64"
																		type:        "integer"
																	}
																	path: {
																		description: "path is the path relative to the mount point of the file to project the token into."
																		type:        "string"
																	}
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												global: {
													additionalProperties: type: "string"
													description: "Settings that apply to the entire PgBouncer process. More info: https://www.pgbouncer.org/config.html"
													type:        "object"
												}
												users: {
													additionalProperties: type: "string"
													description: "Connection settings specific to particular users. More info: https://www.pgbouncer.org/config.html#section-users"
													type:        "object"
												}
											}
											type: "object"
										}
										containers: {
											description: "Custom sidecars for a PgBouncer pod. Changing this value causes PgBouncer to restart."
											items: {
												description: "A single application container that you want to run within a pod."
												properties: {
													args: {
														description: "Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
														items: type: "string"
														type: "array"
													}
													command: {
														description: "Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
														items: type: "string"
														type: "array"
													}
													env: {
														description: "List of environment variables to set in the container. Cannot be updated."
														items: {
															description: "EnvVar represents an environment variable present in a Container."
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
																	properties: {
																		configMapKeyRef: {
																			description: "Selects a key of a ConfigMap."
																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																					type:        "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"
																					type:        "boolean"
																				}
																			}
																			required: [
																				"key",
																			]
																			type: "object"
																		}
																		fieldRef: {
																			description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
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
																			required: [
																				"fieldPath",
																			]
																			type: "object"
																		}
																		resourceFieldRef: {
																			description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																			properties: {
																				containerName: {
																					description: "Container name: required for volumes, optional for env vars"
																					type:        "string"
																				}
																				divisor: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																				resource: {
																					description: "Required: resource to select"
																					type:        "string"
																				}
																			}
																			required: [
																				"resource",
																			]
																			type: "object"
																		}
																		secretKeyRef: {
																			description: "Selects a key of a secret in the pod's namespace"
																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																					type:        "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"
																					type:        "boolean"
																				}
																			}
																			required: [
																				"key",
																			]
																			type: "object"
																		}
																	}
																	type: "object"
																}
															}
															required: [
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													envFrom: {
														description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
														items: {
															description: "EnvFromSource represents the source of a set of ConfigMaps"
															properties: {
																configMapRef: {
																	description: "The ConfigMap to select from"
																	properties: {
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																			type:        "string"
																		}
																		optional: {
																			description: "Specify whether the ConfigMap must be defined"
																			type:        "boolean"
																		}
																	}
																	type: "object"
																}
																prefix: {
																	description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																	type:        "string"
																}
																secretRef: {
																	description: "The Secret to select from"
																	properties: {
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																			type:        "string"
																		}
																		optional: {
																			description: "Specify whether the Secret must be defined"
																			type:        "boolean"
																		}
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														type: "array"
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
														properties: {
															postStart: {
																description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																properties: {
																	exec: {
																		description: "Exec specifies the action to take."
																		properties: command: {
																			description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	httpGet: {
																		description: "HTTPGet specifies the http request to perform."
																		properties: {
																			host: {
																				description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																				type:        "string"
																			}
																			httpHeaders: {
																				description: "Custom headers to set in the request. HTTP allows repeated headers."
																				items: {
																					description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																					required: [
																						"name",
																						"value",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			path: {
																				description: "Path to access on the HTTP server."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																			scheme: {
																				description: "Scheme to use for connecting to the host. Defaults to HTTP."
																				type:        "string"
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																	tcpSocket: {
																		description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																		properties: {
																			host: {
																				description: "Optional: Host name to connect to, defaults to the pod IP."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
															preStop: {
																description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
																properties: {
																	exec: {
																		description: "Exec specifies the action to take."
																		properties: command: {
																			description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	httpGet: {
																		description: "HTTPGet specifies the http request to perform."
																		properties: {
																			host: {
																				description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																				type:        "string"
																			}
																			httpHeaders: {
																				description: "Custom headers to set in the request. HTTP allows repeated headers."
																				items: {
																					description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																					required: [
																						"name",
																						"value",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			path: {
																				description: "Path to access on the HTTP server."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																			scheme: {
																				description: "Scheme to use for connecting to the host. Defaults to HTTP."
																				type:        "string"
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																	tcpSocket: {
																		description: "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified."
																		properties: {
																			host: {
																				description: "Optional: Host name to connect to, defaults to the pod IP."
																				type:        "string"
																			}
																			port: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																				"x-kubernetes-int-or-string": true
																			}
																		}
																		required: [
																			"port",
																		]
																		type: "object"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													livenessProbe: {
														description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
													}
													name: {
														description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
														type:        "string"
													}
													ports: {
														description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
														items: {
															description: "ContainerPort represents a network port in a single container."
															properties: {
																containerPort: {
																	description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
																	format:      "int32"
																	type:        "integer"
																}
																hostIP: {
																	description: "What host IP to bind the external port to."
																	type:        "string"
																}
																hostPort: {
																	description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
																	format:      "int32"
																	type:        "integer"
																}
																name: {
																	description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
																	type:        "string"
																}
																protocol: {
																	default:     "TCP"
																	description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
																	type:        "string"
																}
															}
															required: [
																"containerPort",
															]
															type: "object"
														}
														type: "array"
														"x-kubernetes-list-map-keys": [
															"containerPort",
															"protocol",
														]
														"x-kubernetes-list-type": "map"
													}
													readinessProbe: {
														description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
													}
													resources: {
														description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
														properties: {
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
													securityContext: {
														description: "SecurityContext defines the security options the container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
														properties: {
															allowPrivilegeEscalation: {
																description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows."
																type:        "boolean"
															}
															capabilities: {
																description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime. Note that this field cannot be set when spec.os.name is windows."
																properties: {
																	add: {
																		description: "Added capabilities"
																		items: {
																			description: "Capability represent POSIX capabilities type"
																			type:        "string"
																		}
																		type: "array"
																	}
																	drop: {
																		description: "Removed capabilities"
																		items: {
																			description: "Capability represent POSIX capabilities type"
																			type:        "string"
																		}
																		type: "array"
																	}
																}
																type: "object"
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
																format:      "int64"
																type:        "integer"
															}
															runAsNonRoot: {
																description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																type:        "boolean"
															}
															runAsUser: {
																description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
																format:      "int64"
																type:        "integer"
															}
															seLinuxOptions: {
																description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows."
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
																type: "object"
															}
															seccompProfile: {
																description: "The seccomp options to use by this container. If seccomp options are provided at both the pod & container level, the container options override the pod options. Note that this field cannot be set when spec.os.name is windows."
																properties: {
																	localhostProfile: {
																		description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \"Localhost\"."
																		type:        "string"
																	}
																	type: {
																		description: "type indicates which kind of seccomp profile will be applied. Valid options are: Localhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied."
																		type:        "string"
																	}
																}
																required: [
																	"type",
																]
																type: "object"
															}
															windowsOptions: {
																description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
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
																type: "object"
															}
														}
														type: "object"
													}
													startupProbe: {
														description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														properties: {
															exec: {
																description: "Exec specifies the action to take."
																properties: command: {
																	description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															failureThreshold: {
																description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															grpc: {
																description: "GRPC specifies an action involving a GRPC port. This is a beta field and requires enabling GRPCContainerProbe feature gate."
																properties: {
																	port: {
																		description: "Port number of the gRPC service. Number must be in the range 1 to 65535."
																		format:      "int32"
																		type:        "integer"
																	}
																	service: {
																		description: """
		Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
		 If this is not specified, the default behavior is defined by gRPC.
		"""
																		type: "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															httpGet: {
																description: "HTTPGet specifies the http request to perform."
																properties: {
																	host: {
																		description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																		type:        "string"
																	}
																	httpHeaders: {
																		description: "Custom headers to set in the request. HTTP allows repeated headers."
																		items: {
																			description: "HTTPHeader describes a custom header to be used in HTTP probes"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	path: {
																		description: "Path to access on the HTTP server."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																	scheme: {
																		description: "Scheme to use for connecting to the host. Defaults to HTTP."
																		type:        "string"
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															initialDelaySeconds: {
																description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
															periodSeconds: {
																description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															successThreshold: {
																description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
																format:      "int32"
																type:        "integer"
															}
															tcpSocket: {
																description: "TCPSocket specifies an action involving a TCP port."
																properties: {
																	host: {
																		description: "Optional: Host name to connect to, defaults to the pod IP."
																		type:        "string"
																	}
																	port: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																		"x-kubernetes-int-or-string": true
																	}
																}
																required: [
																	"port",
																]
																type: "object"
															}
															terminationGracePeriodSeconds: {
																description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset."
																format:      "int64"
																type:        "integer"
															}
															timeoutSeconds: {
																description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
																format:      "int32"
																type:        "integer"
															}
														}
														type: "object"
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
														items: {
															description: "volumeDevice describes a mapping of a raw block device within a container."
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
															required: [
																"devicePath",
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													volumeMounts: {
														description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
														items: {
															description: "VolumeMount describes a mounting of a Volume within a container."
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
															required: [
																"mountPath",
																"name",
															]
															type: "object"
														}
														type: "array"
													}
													workingDir: {
														description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
														type:        "string"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										customTLSSecret: {
											description: "A secret projection containing a certificate and key with which to encrypt connections to PgBouncer. The \"tls.crt\", \"tls.key\", and \"ca.crt\" paths must be PEM-encoded certificates and keys. Changing this value causes PgBouncer to restart. More info: https://kubernetes.io/docs/concepts/configuration/secret/#projection-of-secret-keys-to-specific-paths"
											properties: {
												items: {
													description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "key is the key to project."
																type:        "string"
															}
															mode: {
																description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
													type:        "string"
												}
												optional: {
													description: "optional field specify whether the Secret or its key must be defined"
													type:        "boolean"
												}
											}
											type: "object"
										}
										image: {
											description: "Name of a container image that can run PgBouncer 1.15 or newer. Changing this value causes PgBouncer to restart. The image may also be set using the RELATED_IMAGE_PGBOUNCER environment variable. More info: https://kubernetes.io/docs/concepts/containers/images"
											type:        "string"
										}
										metadata: {
											description: "Metadata contains metadata for custom resources"
											properties: {
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
										minAvailable: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description:                  "Minimum number of pods that should be available at a time. Defaults to one when the replicas field is greater than one."
											"x-kubernetes-int-or-string": true
										}
										port: {
											default:     5432
											description: "Port on which PgBouncer should listen for client connections. Changing this value causes PgBouncer to restart."
											format:      "int32"
											minimum:     1024
											type:        "integer"
										}
										priorityClassName: {
											description: "Priority class name for the pgBouncer pod. Changing this value causes PostgreSQL to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
											type:        "string"
										}
										replicas: {
											default:     1
											description: "Number of desired PgBouncer pods."
											format:      "int32"
											minimum:     0
											type:        "integer"
										}
										resources: {
											description: "Compute resources of a PgBouncer container. Changing this value causes PgBouncer to restart. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers"
											properties: {
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
										service: {
											description: "Specification of the service that exposes PgBouncer."
											properties: {
												metadata: {
													description: "Metadata contains metadata for custom resources"
													properties: {
														annotations: {
															additionalProperties: type: "string"
															type: "object"
														}
														labels: {
															additionalProperties: type: "string"
															type: "object"
														}
													}
													type: "object"
												}
												nodePort: {
													description: "The port on which this service is exposed when type is NodePort or LoadBalancer. Value must be in-range and not in use or the operation will fail. If unspecified, a port will be allocated if this Service requires one. - https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport"
													format:      "int32"
													type:        "integer"
												}
												type: {
													default:     "ClusterIP"
													description: "More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types"
													enum: [
														"ClusterIP",
														"NodePort",
														"LoadBalancer",
													]
													type: "string"
												}
											}
											type: "object"
										}
										sidecars: {
											description: "Configuration for pgBouncer sidecar containers"
											properties: pgbouncerConfig: {
												description: "Defines the configuration for the pgBouncer config sidecar container"
												properties: resources: {
													description: "Resource requirements for a sidecar container"
													properties: {
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
												type: "object"
											}
											type: "object"
										}
										tolerations: {
											description: "Tolerations of a PgBouncer pod. Changing this value causes PgBouncer to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
											items: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
														format:      "int64"
														type:        "integer"
													}
													value: {
														description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										topologySpreadConstraints: {
											description: "Topology spread constraints of a PgBouncer pod. Changing this value causes PgBouncer to restart. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"
											items: {
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
												properties: {
													labelSelector: {
														description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													maxSkew: {
														description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
														format:      "int32"
														type:        "integer"
													}
													minDomains: {
														description: """
		MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
		 For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
		 This is an alpha field and requires enabling MinDomainsInPodTopologySpread feature gate.
		"""
														format: "int32"
														type:   "integer"
													}
													topologyKey: {
														description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes match the node selector. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field."
														type:        "string"
													}
													whenUnsatisfiable: {
														description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location, but giving higher precedence to topologies that would help reduce the skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
														type:        "string"
													}
												}
												required: [
													"maxSkew",
													"topologyKey",
													"whenUnsatisfiable",
												]
												type: "object"
											}
											type: "array"
										}
									}
									type: "object"
								}
								required: [
									"pgBouncer",
								]
								type: "object"
							}
							service: {
								description: "Specification of the service that exposes the PostgreSQL primary instance."
								properties: {
									metadata: {
										description: "Metadata contains metadata for custom resources"
										properties: {
											annotations: {
												additionalProperties: type: "string"
												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												type: "object"
											}
										}
										type: "object"
									}
									nodePort: {
										description: "The port on which this service is exposed when type is NodePort or LoadBalancer. Value must be in-range and not in use or the operation will fail. If unspecified, a port will be allocated if this Service requires one. - https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport"
										format:      "int32"
										type:        "integer"
									}
									type: {
										default:     "ClusterIP"
										description: "More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types"
										enum: [
											"ClusterIP",
											"NodePort",
											"LoadBalancer",
										]
										type: "string"
									}
								}
								type: "object"
							}
							shutdown: {
								description: "Whether or not the PostgreSQL cluster should be stopped. When this is true, workloads are scaled to zero and CronJobs are suspended. Other resources, such as Services and Volumes, remain in place."
								type:        "boolean"
							}
							standby: {
								description: "Run this cluster as a read-only copy of an existing cluster or archive."
								properties: {
									enabled: {
										default:     true
										description: "Whether or not the PostgreSQL cluster should be read-only. When this is true, WAL files are applied from a pgBackRest repository or another PostgreSQL server."
										type:        "boolean"
									}
									host: {
										description: "Network address of the PostgreSQL server to follow via streaming replication."
										type:        "string"
									}
									port: {
										description: "Network port of the PostgreSQL server to follow via streaming replication."
										format:      "int32"
										minimum:     1024
										type:        "integer"
									}
									repoName: {
										description: "The name of the pgBackRest repository to follow for WAL files."
										pattern:     "^repo[1-4]"
										type:        "string"
									}
								}
								type: "object"
							}
							supplementalGroups: {
								description: "A list of group IDs applied to the process of a container. These can be useful when accessing shared file systems with constrained permissions. More info: https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context"
								items: {
									format:  "int64"
									maximum: 2147483647
									minimum: 1
									type:    "integer"
								}
								type: "array"
							}
							userInterface: {
								description: "The specification of a user interface that connects to PostgreSQL."
								properties: pgAdmin: {
									description: "Defines a pgAdmin user interface."
									properties: {
										affinity: {
											description: "Scheduling constraints of a pgAdmin pod. Changing this value causes pgAdmin to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node"
											properties: {
												nodeAffinity: {
													description: "Describes node affinity scheduling rules for the pod."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
															items: {
																description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
																properties: {
																	preference: {
																		description: "A node selector term, associated with the corresponding weight."
																		properties: {
																			matchExpressions: {
																				description: "A list of node selector requirements by node's labels."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchFields: {
																				description: "A list of node selector requirements by node's fields."
																				items: {
																					description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	weight: {
																		description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"preference",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
															properties: nodeSelectorTerms: {
																description: "Required. A list of node selector terms. The terms are ORed."
																items: {
																	description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchFields: {
																			description: "A list of node selector requirements by node's fields."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															required: [
																"nodeSelectorTerms",
															]
															type: "object"
														}
													}
													type: "object"
												}
												podAffinity: {
													description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												podAntiAffinity: {
													description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
															items: {
																description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
																properties: {
																	podAffinityTerm: {
																		description: "Required. A pod affinity term, associated with the corresponding weight."
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																									items: type: "string"
																									type: "array"
																								}
																							}
																							required: [
																								"key",
																								"operator",
																							]
																							type: "object"
																						}
																						type: "array"
																					}
																					matchLabels: {
																						additionalProperties: type: "string"
																						description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																						type:        "object"
																					}
																				}
																				type: "object"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																				type:        "string"
																			}
																		}
																		required: [
																			"topologyKey",
																		]
																		type: "object"
																	}
																	weight: {
																		description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																required: [
																	"podAffinityTerm",
																	"weight",
																]
																type: "object"
															}
															type: "array"
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
															items: {
																description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
																properties: {
																	labelSelector: {
																		description: "A label query over a set of resources, in this case pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\"."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																		type:        "string"
																	}
																}
																required: [
																	"topologyKey",
																]
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										config: {
											description: "Configuration settings for the pgAdmin process. Changes to any of these values will be loaded without validation. Be careful, as you may put pgAdmin into an unusable state."
											properties: {
												files: {
													description: "Files allows the user to mount projected volumes into the pgAdmin container so that files can be referenced by pgAdmin as needed."
													items: {
														description: "Projection that may be projected along with other supported volume types"
														properties: {
															configMap: {
																description: "configMap information about the configMap data to project"
																properties: {
																	items: {
																		description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																		type:        "string"
																	}
																	optional: {
																		description: "optional specify whether the ConfigMap or its keys must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															downwardAPI: {
																description: "downwardAPI information about the downwardAPI data to project"
																properties: items: {
																	description: "Items is a list of DownwardAPIVolume file"
																	items: {
																		description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																		properties: {
																			fieldRef: {
																				description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
																				required: [
																					"fieldPath",
																				]
																				type: "object"
																			}
																			mode: {
																				description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																				type:        "string"
																			}
																			resourceFieldRef: {
																				description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																				properties: {
																					containerName: {
																						description: "Container name: required for volumes, optional for env vars"
																						type:        "string"
																					}
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: {
																						description: "Required: resource to select"
																						type:        "string"
																					}
																				}
																				required: [
																					"resource",
																				]
																				type: "object"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																description: "secret information about the secret data to project"
																properties: {
																	items: {
																		description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																		type:        "string"
																	}
																	optional: {
																		description: "optional field specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															serviceAccountToken: {
																description: "serviceAccountToken is information about the serviceAccountToken data to project"
																properties: {
																	audience: {
																		description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																		type:        "string"
																	}
																	expirationSeconds: {
																		description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																		format:      "int64"
																		type:        "integer"
																	}
																	path: {
																		description: "path is the path relative to the mount point of the file to project the token into."
																		type:        "string"
																	}
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												ldapBindPassword: {
													description: "A Secret containing the value for the LDAP_BIND_PASSWORD setting. More info: https://www.pgadmin.org/docs/pgadmin4/latest/ldap.html"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: [
														"key",
													]
													type: "object"
												}
												settings: {
													description:                            "Settings for the pgAdmin server process. Keys should be uppercase and values must be constants. More info: https://www.pgadmin.org/docs/pgadmin4/latest/config_py.html"
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
											}
											type: "object"
										}
										dataVolumeClaimSpec: {
											description: "Defines a PersistentVolumeClaim for pgAdmin data. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes"
											properties: {
												accessModes: {
													description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
													items: type: "string"
													type: "array"
												}
												dataSource: {
													description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												dataSourceRef: {
													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."
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
													required: [
														"kind",
														"name",
													]
													type: "object"
												}
												resources: {
													description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
													properties: {
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
												selector: {
													description: "selector is a label query over volumes to consider for binding."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																		items: type: "string"
																		type: "array"
																	}
																}
																required: [
																	"key",
																	"operator",
																]
																type: "object"
															}
															type: "array"
														}
														matchLabels: {
															additionalProperties: type: "string"
															description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
															type:        "object"
														}
													}
													type: "object"
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
											type: "object"
										}
										image: {
											description: "Name of a container image that can run pgAdmin 4. Changing this value causes pgAdmin to restart. The image may also be set using the RELATED_IMAGE_PGADMIN environment variable. More info: https://kubernetes.io/docs/concepts/containers/images"
											type:        "string"
										}
										metadata: {
											description: "Metadata contains metadata for custom resources"
											properties: {
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type: "object"
										}
										priorityClassName: {
											description: "Priority class name for the pgAdmin pod. Changing this value causes pgAdmin to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/"
											type:        "string"
										}
										replicas: {
											default:     1
											description: "Number of desired pgAdmin pods."
											format:      "int32"
											maximum:     1
											minimum:     0
											type:        "integer"
										}
										resources: {
											description: "Compute resources of a pgAdmin container. Changing this value causes pgAdmin to restart. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers"
											properties: {
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
										service: {
											description: "Specification of the service that exposes pgAdmin."
											properties: {
												metadata: {
													description: "Metadata contains metadata for custom resources"
													properties: {
														annotations: {
															additionalProperties: type: "string"
															type: "object"
														}
														labels: {
															additionalProperties: type: "string"
															type: "object"
														}
													}
													type: "object"
												}
												nodePort: {
													description: "The port on which this service is exposed when type is NodePort or LoadBalancer. Value must be in-range and not in use or the operation will fail. If unspecified, a port will be allocated if this Service requires one. - https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport"
													format:      "int32"
													type:        "integer"
												}
												type: {
													default:     "ClusterIP"
													description: "More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types"
													enum: [
														"ClusterIP",
														"NodePort",
														"LoadBalancer",
													]
													type: "string"
												}
											}
											type: "object"
										}
										tolerations: {
											description: "Tolerations of a pgAdmin pod. Changing this value causes pgAdmin to restart. More info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration"
											items: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
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
														format:      "int64"
														type:        "integer"
													}
													value: {
														description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										topologySpreadConstraints: {
											description: "Topology spread constraints of a pgAdmin pod. Changing this value causes pgAdmin to restart. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"
											items: {
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
												properties: {
													labelSelector: {
														description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
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
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													maxSkew: {
														description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
														format:      "int32"
														type:        "integer"
													}
													minDomains: {
														description: """
		MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
		 For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.
		 This is an alpha field and requires enabling MinDomainsInPodTopologySpread feature gate.
		"""
														format: "int32"
														type:   "integer"
													}
													topologyKey: {
														description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes match the node selector. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field."
														type:        "string"
													}
													whenUnsatisfiable: {
														description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location, but giving higher precedence to topologies that would help reduce the skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
														type:        "string"
													}
												}
												required: [
													"maxSkew",
													"topologyKey",
													"whenUnsatisfiable",
												]
												type: "object"
											}
											type: "array"
										}
									}
									required: [
										"dataVolumeClaimSpec",
									]
									type: "object"
								}
								required: [
									"pgAdmin",
								]
								type: "object"
							}
							users: {
								description: "Users to create inside PostgreSQL and the databases they should access. The default creates one user that can access one database matching the PostgresCluster name. An empty list creates no users. Removing a user from this list does NOT drop the user nor revoke their access."
								items: {
									properties: {
										databases: {
											description: "Databases to which this user can connect and create objects. Removing a database from this list does NOT revoke access. This field is ignored for the \"postgres\" user."
											items: {
												description: "PostgreSQL identifiers are limited in length but may contain any character. More info: https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS"
												maxLength:   63
												minLength:   1
												type:        "string"
											}
											type:                     "array"
											"x-kubernetes-list-type": "set"
										}
										name: {
											description: "The name of this PostgreSQL user. The value may contain only lowercase letters, numbers, and hyphen so that it fits into Kubernetes metadata."
											maxLength:   63
											minLength:   1
											pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:        "string"
										}
										options: {
											description: "ALTER ROLE options except for PASSWORD. This field is ignored for the \"postgres\" user. More info: https://www.postgresql.org/docs/current/role-attributes.html"
											pattern:     "^[^;]*$"
											type:        "string"
										}
										password: {
											description: "Properties of the password generated for this user."
											properties: type: {
												default:     "ASCII"
												description: "Type of password to generate. Defaults to ASCII. Valid options are ASCII and AlphaNumeric. \"ASCII\" passwords contain letters, numbers, and symbols from the US-ASCII character set. \"AlphaNumeric\" passwords contain letters and numbers from the US-ASCII character set."
												enum: [
													"ASCII",
													"AlphaNumeric",
												]
												type: "string"
											}
											required: [
												"type",
											]
											type: "object"
										}
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
						}
						required: [
							"backups",
							"instances",
							"postgresVersion",
						]
						type: "object"
					}
					status: {
						description: "PostgresClusterStatus defines the observed state of PostgresCluster"
						properties: {
							conditions: {
								description: "conditions represent the observations of postgrescluster's current state. Known .status.conditions.type are: \"PersistentVolumeResizing\", \"Progressing\", \"ProxyAvailable\""
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
											format:      "date-time"
											type:        "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."
											maxLength:   32768
											type:        "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
											format:      "int64"
											minimum:     0
											type:        "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
											maxLength:   1024
											minLength:   1
											pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:        "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							databaseInitSQL: {
								description: "DatabaseInitSQL state of custom database initialization in the cluster"
								type:        "string"
							}
							databaseRevision: {
								description: "Identifies the databases that have been installed into PostgreSQL."
								type:        "string"
							}
							instances: {
								description: "Current state of PostgreSQL instances."
								items: {
									properties: {
										name: type: "string"
										readyReplicas: {
											description: "Total number of ready pods."
											format:      "int32"
											type:        "integer"
										}
										replicas: {
											description: "Total number of pods."
											format:      "int32"
											type:        "integer"
										}
										updatedReplicas: {
											description: "Total number of pods that have the desired specification."
											format:      "int32"
											type:        "integer"
										}
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
							monitoring: {
								description: "Current state of PostgreSQL cluster monitoring tool configuration"
								properties: exporterConfiguration: type: "string"
								type: "object"
							}
							observedGeneration: {
								description: "observedGeneration represents the .metadata.generation on which the status was based."
								format:      "int64"
								minimum:     0
								type:        "integer"
							}
							patroni: {
								properties: {
									switchover: {
										description: "Tracks the execution of the switchover requests."
										type:        "string"
									}
									switchoverTimeline: {
										description: "Tracks the current timeline during switchovers"
										format:      "int64"
										type:        "integer"
									}
									systemIdentifier: {
										description: "The PostgreSQL system identifier reported by Patroni."
										type:        "string"
									}
								}
								type: "object"
							}
							pgbackrest: {
								description: "Status information for pgBackRest"
								properties: {
									manualBackup: {
										description: "Status information for manual backups"
										properties: {
											active: {
												description: "The number of actively running manual backup Pods."
												format:      "int32"
												type:        "integer"
											}
											completionTime: {
												description: "Represents the time the manual backup Job was determined by the Job controller to be completed.  This field is only set if the backup completed successfully. Additionally, it is represented in RFC3339 form and is in UTC."
												format:      "date-time"
												type:        "string"
											}
											failed: {
												description: "The number of Pods for the manual backup Job that reached the \"Failed\" phase."
												format:      "int32"
												type:        "integer"
											}
											finished: {
												description: "Specifies whether or not the Job is finished executing (does not indicate success or failure)."
												type:        "boolean"
											}
											id: {
												description: "A unique identifier for the manual backup as provided using the \"pgbackrest-backup\" annotation when initiating a backup."
												type:        "string"
											}
											startTime: {
												description: "Represents the time the manual backup Job was acknowledged by the Job controller. It is represented in RFC3339 form and is in UTC."
												format:      "date-time"
												type:        "string"
											}
											succeeded: {
												description: "The number of Pods for the manual backup Job that reached the \"Succeeded\" phase."
												format:      "int32"
												type:        "integer"
											}
										}
										required: [
											"finished",
											"id",
										]
										type: "object"
									}
									repoHost: {
										description: "Status information for the pgBackRest dedicated repository host"
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											ready: {
												description: "Whether or not the pgBackRest repository host is ready for use"
												type:        "boolean"
											}
										}
										type: "object"
									}
									repos: {
										description: "Status information for pgBackRest repositories"
										items: {
											description: "RepoStatus the status of a pgBackRest repository"
											properties: {
												bound: {
													description: "Whether or not the pgBackRest repository PersistentVolumeClaim is bound to a volume"
													type:        "boolean"
												}
												name: {
													description: "The name of the pgBackRest repository"
													type:        "string"
												}
												replicaCreateBackupComplete: {
													description: "ReplicaCreateBackupReady indicates whether a backup exists in the repository as needed to bootstrap replicas."
													type:        "boolean"
												}
												repoOptionsHash: {
													description: "A hash of the required fields in the spec for defining an Azure, GCS or S3 repository, Utilizd to detect changes to these fields and then execute pgBackRest stanza-create commands accordingly."
													type:        "string"
												}
												stanzaCreated: {
													description: "Specifies whether or not a stanza has been successfully created for the repository"
													type:        "boolean"
												}
												volume: {
													description: "The name of the volume the containing the pgBackRest repository"
													type:        "string"
												}
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
									restore: {
										description: "Status information for in-place restores"
										properties: {
											active: {
												description: "The number of actively running manual backup Pods."
												format:      "int32"
												type:        "integer"
											}
											completionTime: {
												description: "Represents the time the manual backup Job was determined by the Job controller to be completed.  This field is only set if the backup completed successfully. Additionally, it is represented in RFC3339 form and is in UTC."
												format:      "date-time"
												type:        "string"
											}
											failed: {
												description: "The number of Pods for the manual backup Job that reached the \"Failed\" phase."
												format:      "int32"
												type:        "integer"
											}
											finished: {
												description: "Specifies whether or not the Job is finished executing (does not indicate success or failure)."
												type:        "boolean"
											}
											id: {
												description: "A unique identifier for the manual backup as provided using the \"pgbackrest-backup\" annotation when initiating a backup."
												type:        "string"
											}
											startTime: {
												description: "Represents the time the manual backup Job was acknowledged by the Job controller. It is represented in RFC3339 form and is in UTC."
												format:      "date-time"
												type:        "string"
											}
											succeeded: {
												description: "The number of Pods for the manual backup Job that reached the \"Succeeded\" phase."
												format:      "int32"
												type:        "integer"
											}
										}
										required: [
											"finished",
											"id",
										]
										type: "object"
									}
									scheduledBackups: {
										description: "Status information for scheduled backups"
										items: {
											properties: {
												active: {
													description: "The number of actively running manual backup Pods."
													format:      "int32"
													type:        "integer"
												}
												completionTime: {
													description: "Represents the time the manual backup Job was determined by the Job controller to be completed.  This field is only set if the backup completed successfully. Additionally, it is represented in RFC3339 form and is in UTC."
													format:      "date-time"
													type:        "string"
												}
												cronJobName: {
													description: "The name of the associated pgBackRest scheduled backup CronJob"
													type:        "string"
												}
												failed: {
													description: "The number of Pods for the manual backup Job that reached the \"Failed\" phase."
													format:      "int32"
													type:        "integer"
												}
												repo: {
													description: "The name of the associated pgBackRest repository"
													type:        "string"
												}
												startTime: {
													description: "Represents the time the manual backup Job was acknowledged by the Job controller. It is represented in RFC3339 form and is in UTC."
													format:      "date-time"
													type:        "string"
												}
												succeeded: {
													description: "The number of Pods for the manual backup Job that reached the \"Succeeded\" phase."
													format:      "int32"
													type:        "integer"
												}
												type: {
													description: "The pgBackRest backup type for this Job"
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
							postgresVersion: {
								description: "Stores the current PostgreSQL major version following a successful major PostgreSQL upgrade."
								type:        "integer"
							}
							proxy: {
								description: "Current state of the PostgreSQL proxy."
								properties: pgBouncer: {
									properties: {
										postgresRevision: {
											description: "Identifies the revision of PgBouncer assets that have been installed into PostgreSQL."
											type:        "string"
										}
										readyReplicas: {
											description: "Total number of ready pods."
											format:      "int32"
											type:        "integer"
										}
										replicas: {
											description: "Total number of non-terminated pods."
											format:      "int32"
											type:        "integer"
										}
									}
									type: "object"
								}
								type: "object"
							}
							startupInstance: {
								description: "The instance that should be started first when bootstrapping and/or starting a PostgresCluster."
								type:        "string"
							}
							startupInstanceSet: {
								description: "The instance set associated with the startupInstance"
								type:        "string"
							}
							userInterface: {
								description: "Current state of the PostgreSQL user interface."
								properties: pgAdmin: {
									description: "The state of the pgAdmin user interface."
									properties: usersRevision: {
										description: "Hash that indicates which users have been installed into pgAdmin."
										type:        "string"
									}
									type: "object"
								}
								type: "object"
							}
							usersRevision: {
								description: "Identifies the users that have been installed into PostgreSQL."
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
