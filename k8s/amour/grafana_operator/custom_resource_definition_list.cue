package grafana_operator

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
	metadata: name: "grafanaalertrulegroups.grafana.integreatly.org"
	spec: {
		group: "grafana.integreatly.org"
		names: {
			kind:     "GrafanaAlertRuleGroup"
			listKind: "GrafanaAlertRuleGroupList"
			plural:   "grafanaalertrulegroups"
			singular: "grafanaalertrulegroup"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "GrafanaAlertRuleGroup is the Schema for the grafanaalertrulegroups API"
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
						description: "GrafanaAlertRuleGroupSpec defines the desired state of GrafanaAlertRuleGroup"
						properties: {
							allowCrossNamespaceImport: type: "boolean"
							folderRef: {
								description: "Match GrafanaFolders CRs to infer the uid"
								type:        "string"
							}
							folderUID: {
								description: "UID of the folder containing this rule group Overrides the FolderSelector"
								type:        "string"
							}
							instanceSelector: {
								description: "selects Grafanas for import"
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
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							interval: {
								format:  "duration"
								pattern: "^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
								type:    "string"
							}
							resyncPeriod: {
								default: "10m"
								format:  "duration"
								pattern: "^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
								type:    "string"
							}
							rules: {
								items: {
									description: "AlertRule defines a specific rule to be evaluated. It is based on the upstream model with some k8s specific type mappings"
									properties: {
										annotations: {
											additionalProperties: type: "string"
											type: "object"
										}
										condition: type: "string"
										data: {
											items: {
												properties: {
													datasourceUid: {
														description: "Grafana data source unique identifier; it should be '__expr__' for a Server Side Expression operation."
														type:        "string"
													}
													model: {
														description:                            "JSON is the raw JSON query and includes the above properties as well as custom properties."
														"x-kubernetes-preserve-unknown-fields": true
													}
													queryType: {
														description: "QueryType is an optional identifier for the type of query. It can be used to distinguish different types of queries."
														type:        "string"
													}
													refId: {
														description: "RefID is the unique identifier of the query, set by the frontend call."
														type:        "string"
													}
													relativeTimeRange: {
														description: "relative time range"
														properties: {
															from: {
																description: "from"
																format:      "int64"
																type:        "integer"
															}
															to: {
																description: "to"
																format:      "int64"
																type:        "integer"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										execErrState: {
											enum: [
												"OK",
												"Alerting",
												"Error",
											]
											type: "string"
										}
										for: {
											format:  "duration"
											pattern: "^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
											type:    "string"
										}
										isPaused: type: "boolean"
										labels: {
											additionalProperties: type: "string"
											type: "object"
										}
										noDataState: {
											enum: [
												"Alerting",
												"NoData",
												"OK",
											]
											type: "string"
										}
										title: {
											example:   "Always firing"
											maxLength: 190
											minLength: 1
											type:      "string"
										}
										uid: {
											pattern: "^[a-zA-Z0-9-_]+$"
											type:    "string"
										}
									}
									required: [
										"condition",
										"data",
										"execErrState",
										"for",
										"noDataState",
										"title",
										"uid",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"instanceSelector",
							"interval",
							"rules",
						]
						type: "object"
						"x-kubernetes-validations": [{
							message: "Only one of FolderUID or FolderRef can be set"
							rule:    "(has(self.folderUID) && !(has(self.folderRef))) || (has(self.folderRef) && !(has(self.folderUID)))"
						}]
					}
					status: {
						description: "GrafanaAlertRuleGroupStatus defines the observed state of GrafanaAlertRuleGroup"
						properties: conditions: {
							items: {
								description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example,
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
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
						}
						required: ["conditions"]
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
	metadata: name: "grafanadashboards.grafana.integreatly.org"
	spec: {
		group: "grafana.integreatly.org"
		names: {
			kind:     "GrafanaDashboard"
			listKind: "GrafanaDashboardList"
			plural:   "grafanadashboards"
			singular: "grafanadashboard"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.NoMatchingInstances"
				name:     "No matching instances"
				type:     "boolean"
			}, {
				format:   "date-time"
				jsonPath: ".status.lastResync"
				name:     "Last resync"
				type:     "date"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "GrafanaDashboard is the Schema for the grafanadashboards API"
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
						description: "GrafanaDashboardSpec defines the desired state of GrafanaDashboard"
						properties: {
							allowCrossNamespaceImport: {
								description: "allow to import this resources from an operator in a different namespace"
								type:        "boolean"
							}
							configMapRef: {
								description: "dashboard from configmap"
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
								required: ["key"]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							contentCacheDuration: {
								description: "Cache duration for dashboards fetched from URLs"
								type:        "string"
							}
							datasources: {
								description: "maps required data sources to existing ones"
								items: {
									properties: {
										datasourceName: type: "string"
										inputName: type:      "string"
									}
									required: [
										"datasourceName",
										"inputName",
									]
									type: "object"
								}
								type: "array"
							}
							envFrom: {
								description: "environments variables from secrets or config maps"
								items: {
									properties: {
										configMapKeyRef: {
											description: "Selects a key of a ConfigMap."
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
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										secretKeyRef: {
											description: "Selects a key of a Secret."
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
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
									}
									type: "object"
								}
								type: "array"
							}
							envs: {
								description: "environments variables as a map"
								items: {
									properties: {
										name: type: "string"
										value: {
											description: "Inline evn value"
											type:        "string"
										}
										valueFrom: {
											description: "Reference on value source, might be the reference on a secret or config map"
											properties: {
												configMapKeyRef: {
													description: "Selects a key of a ConfigMap."
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
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												secretKeyRef: {
													description: "Selects a key of a Secret."
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
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							folder: {
								description: "folder assignment for dashboard"
								type:        "string"
							}
							grafanaCom: {
								description: "grafana.com/dashboards"
								properties: {
									id: type:       "integer"
									revision: type: "integer"
								}
								required: ["id"]
								type: "object"
							}
							gzipJson: {
								description: "GzipJson the dashboard's JSON compressed with Gzip. Base64-encoded when in YAML."
								format:      "byte"
								type:        "string"
							}
							instanceSelector: {
								description: "selects Grafanas for import"
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
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							json: {
								description: "dashboard json"
								type:        "string"
							}
							jsonnet: {
								description: "Jsonnet"
								type:        "string"
							}
							jsonnetLib: {
								description: "Jsonnet project build"
								properties: {
									fileName: type: "string"
									gzipJsonnetProject: {
										format: "byte"
										type:   "string"
									}
									jPath: {
										items: type: "string"
										type: "array"
									}
								}
								required: [
									"fileName",
									"gzipJsonnetProject",
								]
								type: "object"
							}
							plugins: {
								description: "plugins"
								items: {
									properties: {
										name: type:    "string"
										version: type: "string"
									}
									required: [
										"name",
										"version",
									]
									type: "object"
								}
								type: "array"
							}
							resyncPeriod: {
								description: "how often the dashboard is refreshed, defaults to 5m if not set"
								type:        "string"
							}
							url: {
								description: "dashboard url"
								type:        "string"
							}
						}
						required: ["instanceSelector"]
						type: "object"
					}
					status: {
						description: "GrafanaDashboardStatus defines the observed state of GrafanaDashboard"
						properties: {
							NoMatchingInstances: {
								description: "The dashboard instanceSelector can't find matching grafana instances"
								type:        "boolean"
							}
							contentCache: {
								format: "byte"
								type:   "string"
							}
							contentTimestamp: {
								format: "date-time"
								type:   "string"
							}
							contentUrl: type: "string"
							hash: type:       "string"
							lastResync: {
								description: "Last time the dashboard was resynced"
								format:      "date-time"
								type:        "string"
							}
							uid: type: "string"
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
	metadata: name: "grafanadatasources.grafana.integreatly.org"
	spec: {
		group: "grafana.integreatly.org"
		names: {
			kind:     "GrafanaDatasource"
			listKind: "GrafanaDatasourceList"
			plural:   "grafanadatasources"
			singular: "grafanadatasource"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.NoMatchingInstances"
				name:     "No matching instances"
				type:     "boolean"
			}, {
				format:   "date-time"
				jsonPath: ".status.lastResync"
				name:     "Last resync"
				type:     "date"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "GrafanaDatasource is the Schema for the grafanadatasources API"
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
						description: "GrafanaDatasourceSpec defines the desired state of GrafanaDatasource"
						properties: {
							allowCrossNamespaceImport: {
								description: "allow to import this resources from an operator in a different namespace"
								type:        "boolean"
							}
							datasource: {
								properties: {
									access: type:        "string"
									basicAuth: type:     "boolean"
									basicAuthUser: type: "string"
									database: type:      "string"
									editable: type:      "boolean"
									isDefault: type:     "boolean"
									jsonData: {
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									name: type: "string"
									orgId: {
										format: "int64"
										type:   "integer"
									}
									secureJsonData: {
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									type: type: "string"
									uid: type:  "string"
									url: type:  "string"
									user: type: "string"
								}
								type: "object"
							}
							instanceSelector: {
								description: "selects Grafana instances for import"
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
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							plugins: {
								description: "plugins"
								items: {
									properties: {
										name: type:    "string"
										version: type: "string"
									}
									required: [
										"name",
										"version",
									]
									type: "object"
								}
								type: "array"
							}
							resyncPeriod: {
								description: "how often the datasource is refreshed, defaults to 5m if not set"
								type:        "string"
							}
							valuesFrom: {
								description: "environments variables from secrets or config maps"
								items: {
									properties: {
										targetPath: type: "string"
										valueFrom: {
											properties: {
												configMapKeyRef: {
													description: "Selects a key of a ConfigMap."
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
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												secretKeyRef: {
													description: "Selects a key of a Secret."
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
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
									}
									required: [
										"targetPath",
										"valueFrom",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"datasource",
							"instanceSelector",
						]
						type: "object"
					}
					status: {
						description: "GrafanaDatasourceStatus defines the observed state of GrafanaDatasource"
						properties: {
							NoMatchingInstances: {
								description: "The datasource instanceSelector can't find matching grafana instances"
								type:        "boolean"
							}
							hash: type:        "string"
							lastMessage: type: "string"
							lastResync: {
								description: "Last time the datasource was resynced"
								format:      "date-time"
								type:        "string"
							}
							uid: type: "string"
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
	metadata: name: "grafanafolders.grafana.integreatly.org"
	spec: {
		group: "grafana.integreatly.org"
		names: {
			kind:     "GrafanaFolder"
			listKind: "GrafanaFolderList"
			plural:   "grafanafolders"
			singular: "grafanafolder"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.NoMatchingInstances"
				name:     "No matching instances"
				type:     "boolean"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "GrafanaFolder is the Schema for the grafanafolders API"
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
						description: "GrafanaFolderSpec defines the desired state of GrafanaFolder"
						properties: {
							allowCrossNamespaceImport: {
								description: "allow to import this resources from an operator in a different namespace"
								type:        "boolean"
							}
							instanceSelector: {
								description: "selects Grafanas for import"
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
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							permissions: {
								description: "raw json with folder permissions"
								type:        "string"
							}
							resyncPeriod: {
								description: "how often the folder is synced, defaults to 5m if not set"
								type:        "string"
							}
							title: type: "string"
						}
						required: ["instanceSelector"]
						type: "object"
					}
					status: {
						description: "GrafanaFolderStatus defines the observed state of GrafanaFolder"
						properties: {
							NoMatchingInstances: {
								description: "The folder instanceSelector can't find matching grafana instances"
								type:        "boolean"
							}
							hash: {
								description: "INSERT ADDITIONAL STATUS FIELD - define observed state of cluster Important: Run \"make\" to regenerate code after modifying this file"
								type:        "string"
							}
							lastResync: {
								description: "Last time the folder was resynced"
								format:      "date-time"
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
}, {
	metadata: name: "grafanas.grafana.integreatly.org"
	spec: {
		group: "grafana.integreatly.org"
		names: {
			kind:     "Grafana"
			listKind: "GrafanaList"
			plural:   "grafanas"
			singular: "grafana"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.stage"
				name:     "Stage"
				type:     "string"
			}, {
				jsonPath: ".status.stageStatus"
				name:     "Stage status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "Grafana is the Schema for the grafanas API"
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
						description: "GrafanaSpec defines the desired state of Grafana"
						properties: {
							client: {
								description: "Client defines how the grafana-operator talks to the grafana instance."
								properties: {
									preferIngress: {
										description: "If the operator should send it's request through the grafana instances ingress object instead of through the service."
										nullable:    true
										type:        "boolean"
									}
									timeout: {
										nullable: true
										type:     "integer"
									}
								}
								type: "object"
							}
							config: {
								additionalProperties: {
									additionalProperties: type: "string"
									type: "object"
								}
								description:                            "Config defines how your grafana ini file should looks like."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							deployment: {
								description: "Deployment sets how the deployment object should look like with your grafana instance, contains a number of defaults."
								properties: {
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									spec: {
										properties: {
											minReadySeconds: {
												format: "int32"
												type:   "integer"
											}
											paused: type: "boolean"
											progressDeadlineSeconds: {
												format: "int32"
												type:   "integer"
											}
											replicas: {
												format: "int32"
												type:   "integer"
											}
											revisionHistoryLimit: {
												format: "int32"
												type:   "integer"
											}
											selector: {
												description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."
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
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											strategy: {
												description: "DeploymentStrategy describes how to replace existing pods with new ones."
												properties: {
													rollingUpdate: {
														description: "Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate. --- TODO: Update this to follow our convention for oneOf, whatever we decide it to be."
														properties: {
															maxSurge: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																description:                  "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods."
																"x-kubernetes-int-or-string": true
															}
															maxUnavailable: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																description:                  "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods."
																"x-kubernetes-int-or-string": true
															}
														}
														type: "object"
													}
													type: {
														description: "Type of deployment. Can be \"Recreate\" or \"RollingUpdate\". Default is RollingUpdate."
														type:        "string"
													}
												}
												type: "object"
											}
											template: {
												properties: {
													metadata: {
														description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
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
													spec: {
														description: "Specification of the desired behavior of the pod. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
														properties: {
															activeDeadlineSeconds: {
																format: "int64"
																type:   "integer"
															}
															affinity: {
																description: "If specified, the pod's scheduling constraints"
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
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
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
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					type: "array"
																				}
																				required: ["nodeSelectorTerms"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
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
																									description: "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods."
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
																									type:                    "object"
																									"x-kubernetes-map-type": "atomic"
																								}
																								matchLabelKeys: {
																									description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																									items: type: "string"
																									type:                     "array"
																									"x-kubernetes-list-type": "atomic"
																								}
																								mismatchLabelKeys: {
																									description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																									items: type: "string"
																									type:                     "array"
																									"x-kubernetes-list-type": "atomic"
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
																									type:                    "object"
																									"x-kubernetes-map-type": "atomic"
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
																							required: ["topologyKey"]
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
																							description: "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods."
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
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
																						}
																						matchLabelKeys: {
																							description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																							items: type: "string"
																							type:                     "array"
																							"x-kubernetes-list-type": "atomic"
																						}
																						mismatchLabelKeys: {
																							description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																							items: type: "string"
																							type:                     "array"
																							"x-kubernetes-list-type": "atomic"
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
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
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
																					required: ["topologyKey"]
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
																									description: "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods."
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
																									type:                    "object"
																									"x-kubernetes-map-type": "atomic"
																								}
																								matchLabelKeys: {
																									description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																									items: type: "string"
																									type:                     "array"
																									"x-kubernetes-list-type": "atomic"
																								}
																								mismatchLabelKeys: {
																									description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																									items: type: "string"
																									type:                     "array"
																									"x-kubernetes-list-type": "atomic"
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
																									type:                    "object"
																									"x-kubernetes-map-type": "atomic"
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
																							required: ["topologyKey"]
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
																							description: "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods."
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
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
																						}
																						matchLabelKeys: {
																							description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																							items: type: "string"
																							type:                     "array"
																							"x-kubernetes-list-type": "atomic"
																						}
																						mismatchLabelKeys: {
																							description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate."
																							items: type: "string"
																							type:                     "array"
																							"x-kubernetes-list-type": "atomic"
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
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
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
																					required: ["topologyKey"]
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
															automountServiceAccountToken: {
																description: "AutomountServiceAccountToken indicates whether a service account token should be automatically mounted."
																type:        "boolean"
															}
															containers: {
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
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "Specify whether the ConfigMap or its key must be defined"
																										type:        "boolean"
																									}
																								}
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["fieldPath"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["resource"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																							secretKeyRef: {
																								description: "Selects a key of a secret in the pod's namespace"
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
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: ["name"]
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
																								description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																								type:        "string"
																							}
																							optional: {
																								description: "Specify whether the ConfigMap must be defined"
																								type:        "boolean"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					prefix: {
																						description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																						type:        "string"
																					}
																					secretRef: {
																						description: "The Secret to select from"
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
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																			description: "List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated."
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
																				required: ["containerPort"]
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																		resizePolicy: {
																			description: "Resources resize policy for the container."
																			items: {
																				description: "ContainerResizePolicy represents resource resize policy for the container."
																				properties: {
																					resourceName: {
																						description: "Name of the resource to which this resource resize policy applies. Supported values: cpu, memory."
																						type:        "string"
																					}
																					restartPolicy: {
																						description: "Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired."
																						type:        "string"
																					}
																				}
																				required: [
																					"resourceName",
																					"restartPolicy",
																				]
																				type: "object"
																			}
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		resources: {
																			description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																			properties: {
																				claims: {
																					description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
		 This field is immutable. It can only be set for containers.
		"""
																					items: {
																						description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																						properties: name: {
																							description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."
																							type:        "string"
																						}
																						required: ["name"]
																						type: "object"
																					}
																					type: "array"
																					"x-kubernetes-list-map-keys": ["name"]
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
																					description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		restartPolicy: {
																			description: "RestartPolicy defines the restart behavior of individual containers in a pod. This field may only be set for init containers, and the only allowed value is \"Always\". For non-init containers or when this field is not specified, the restart behavior is defined by the Pod's restart policy and the container type. Setting the RestartPolicy as \"Always\" for the init container will have the following effect: this init container will be continually restarted on exit until all regular containers have terminated. Once all regular containers have completed, all init containers with restartPolicy \"Always\" will be shut down. This lifecycle differs from normal init containers and is often referred to as a \"sidecar\" container. Although this init container still starts in the init container sequence, it does not wait for the container to complete before proceeding to the next init container. Instead, the next init container starts immediately after this init container is started, or after any startupProbe has successfully completed."
																			type:        "string"
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
																							description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type."
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
																					required: ["type"]
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
																							description: "HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true."
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																	required: ["name"]
																	type: "object"
																}
																type: "array"
															}
															dnsConfig: {
																description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."
																properties: {
																	nameservers: {
																		description: "A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed."
																		items: type: "string"
																		type: "array"
																	}
																	options: {
																		description: "A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy."
																		items: {
																			description: "PodDNSConfigOption defines DNS resolver options of a pod."
																			properties: {
																				name: {
																					description: "Required."
																					type:        "string"
																				}
																				value: type: "string"
																			}
																			type: "object"
																		}
																		type: "array"
																	}
																	searches: {
																		description: "A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed."
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															dnsPolicy: {
																description: "DNSPolicy defines how a pod's DNS will be configured."
																type:        "string"
															}
															enableServiceLinks: {
																description: "EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true."
																type:        "boolean"
															}
															ephemeralContainers: {
																items: {
																	description: """
		An EphemeralContainer is a temporary container that you may add to an existing Pod for user-initiated activities such as debugging. Ephemeral containers have no resource or scheduling guarantees, and they will not be restarted when they exit or when a Pod is removed or restarted. The kubelet may evict a Pod if an ephemeral container causes the Pod to exceed its resource allocation.
		 To add an ephemeral container, use the ephemeralcontainers subresource of an existing Pod. Ephemeral containers may not be removed or restarted.
		"""
																	properties: {
																		args: {
																			description: "Arguments to the entrypoint. The image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
																			items: type: "string"
																			type: "array"
																		}
																		command: {
																			description: "Entrypoint array. Not executed within a shell. The image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
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
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "Specify whether the ConfigMap or its key must be defined"
																										type:        "boolean"
																									}
																								}
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["fieldPath"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["resource"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																							secretKeyRef: {
																								description: "Selects a key of a secret in the pod's namespace"
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
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: ["name"]
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
																								description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																								type:        "string"
																							}
																							optional: {
																								description: "Specify whether the ConfigMap must be defined"
																								type:        "boolean"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					prefix: {
																						description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																						type:        "string"
																					}
																					secretRef: {
																						description: "The Secret to select from"
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
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																				}
																				type: "object"
																			}
																			type: "array"
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
																							type: "object"
																						}
																					}
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		livenessProbe: {
																			description: "Probes are not allowed for ephemeral containers."
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																			description: "Name of the ephemeral container specified as a DNS_LABEL. This name must be unique among all containers, init containers and ephemeral containers."
																			type:        "string"
																		}
																		ports: {
																			description: "Ports are not allowed for ephemeral containers."
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
																				required: ["containerPort"]
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
																			description: "Probes are not allowed for ephemeral containers."
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																		resizePolicy: {
																			description: "Resources resize policy for the container."
																			items: {
																				description: "ContainerResizePolicy represents resource resize policy for the container."
																				properties: {
																					resourceName: {
																						description: "Name of the resource to which this resource resize policy applies. Supported values: cpu, memory."
																						type:        "string"
																					}
																					restartPolicy: {
																						description: "Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired."
																						type:        "string"
																					}
																				}
																				required: [
																					"resourceName",
																					"restartPolicy",
																				]
																				type: "object"
																			}
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		resources: {
																			description: "Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources already allocated to the pod."
																			properties: {
																				claims: {
																					description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
		 This field is immutable. It can only be set for containers.
		"""
																					items: {
																						description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																						properties: name: {
																							description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."
																							type:        "string"
																						}
																						required: ["name"]
																						type: "object"
																					}
																					type: "array"
																					"x-kubernetes-list-map-keys": ["name"]
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
																					description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		restartPolicy: {
																			description: "Restart policy for the container to manage the restart behavior of each container within a pod. This may only be set for init containers. You cannot set this field on ephemeral containers."
																			type:        "string"
																		}
																		securityContext: {
																			description: "Optional: SecurityContext defines the security options the ephemeral container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext."
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
																							description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type."
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
																					required: ["type"]
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
																							description: "HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true."
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
																			description: "Probes are not allowed for ephemeral containers."
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																			description: "Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers. Cannot be updated."
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
																	required: ["name"]
																	type: "object"
																}
																type: "array"
															}
															hostAliases: {
																description: "HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods."
																items: {
																	description: "HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file."
																	properties: {
																		hostnames: {
																			description: "Hostnames for the above IP address."
																			items: type: "string"
																			type: "array"
																		}
																		ip: {
																			description: "IP address of the host file entry."
																			type:        "string"
																		}
																	}
																	type: "object"
																}
																type: "array"
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
																items: {
																	description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
																	properties: name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																type: "array"
															}
															initContainers: {
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
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "Specify whether the ConfigMap or its key must be defined"
																										type:        "boolean"
																									}
																								}
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["fieldPath"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["resource"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																							secretKeyRef: {
																								description: "Selects a key of a secret in the pod's namespace"
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
																								required: ["key"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																						}
																						type: "object"
																					}
																				}
																				required: ["name"]
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
																								description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																								type:        "string"
																							}
																							optional: {
																								description: "Specify whether the ConfigMap must be defined"
																								type:        "boolean"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					prefix: {
																						description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
																						type:        "string"
																					}
																					secretRef: {
																						description: "The Secret to select from"
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
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
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
																												description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																							required: ["port"]
																							type: "object"
																						}
																						sleep: {
																							description: "Sleep represents the duration that the container should sleep before being terminated."
																							properties: seconds: {
																								description: "Seconds is the number of seconds to sleep."
																								format:      "int64"
																								type:        "integer"
																							}
																							required: ["seconds"]
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
																							required: ["port"]
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																			description: "List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated."
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
																				required: ["containerPort"]
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																		resizePolicy: {
																			description: "Resources resize policy for the container."
																			items: {
																				description: "ContainerResizePolicy represents resource resize policy for the container."
																				properties: {
																					resourceName: {
																						description: "Name of the resource to which this resource resize policy applies. Supported values: cpu, memory."
																						type:        "string"
																					}
																					restartPolicy: {
																						description: "Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired."
																						type:        "string"
																					}
																				}
																				required: [
																					"resourceName",
																					"restartPolicy",
																				]
																				type: "object"
																			}
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		resources: {
																			description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																			properties: {
																				claims: {
																					description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
		 This field is immutable. It can only be set for containers.
		"""
																					items: {
																						description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																						properties: name: {
																							description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."
																							type:        "string"
																						}
																						required: ["name"]
																						type: "object"
																					}
																					type: "array"
																					"x-kubernetes-list-map-keys": ["name"]
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
																					description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		restartPolicy: {
																			description: "RestartPolicy defines the restart behavior of individual containers in a pod. This field may only be set for init containers, and the only allowed value is \"Always\". For non-init containers or when this field is not specified, the restart behavior is defined by the Pod's restart policy and the container type. Setting the RestartPolicy as \"Always\" for the init container will have the following effect: this init container will be continually restarted on exit until all regular containers have terminated. Once all regular containers have completed, all init containers with restartPolicy \"Always\" will be shut down. This lifecycle differs from normal init containers and is often referred to as a \"sidecar\" container. Although this init container still starts in the init container sequence, it does not wait for the container to complete before proceeding to the next init container. Instead, the next init container starts immediately after this init container is started, or after any startupProbe has successfully completed."
																			type:        "string"
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
																							description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type."
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
																					required: ["type"]
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
																							description: "HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true."
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
																					description: "GRPC specifies an action involving a GRPC port."
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
																					required: ["port"]
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
																										description: "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header."
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
																					required: ["port"]
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
																					required: ["port"]
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
																	required: ["name"]
																	type: "object"
																}
																type: "array"
															}
															nodeName: {
																description: "NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements."
																type:        "string"
															}
															nodeSelector: {
																additionalProperties: type: "string"
																description:             "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															os: {
																description: """
		Specifies the OS of the containers in the pod. Some pod and container fields are restricted if this is set.
		 If the OS field is set to linux, the following fields must be unset: -securityContext.windowsOptions
		 If the OS field is set to windows, following fields must be unset: - spec.hostPID - spec.hostIPC - spec.hostUsers - spec.securityContext.seLinuxOptions - spec.securityContext.seccompProfile - spec.securityContext.fsGroup - spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls - spec.shareProcessNamespace - spec.securityContext.runAsUser - spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups - spec.containers[*].securityContext.seLinuxOptions - spec.containers[*].securityContext.seccompProfile - spec.containers[*].securityContext.capabilities - spec.containers[*].securityContext.readOnlyRootFilesystem - spec.containers[*].securityContext.privileged - spec.containers[*].securityContext.allowPrivilegeEscalation - spec.containers[*].securityContext.procMount - spec.containers[*].securityContext.runAsUser - spec.containers[*].securityContext.runAsGroup
		"""
																properties: name: {
																	description: "Name is the name of the operating system. The currently supported values are linux and windows. Additional value may be defined in future and can be one of: https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration Clients should expect to handle additional values and treat unrecognized values in this field as os: null"
																	type:        "string"
																}
																required: ["name"]
																type: "object"
															}
															overhead: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md"
																type:        "object"
															}
															preemptionPolicy: {
																description: "PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset."
																type:        "string"
															}
															priority: {
																description: "The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority."
																format:      "int32"
																type:        "integer"
															}
															priorityClassName: {
																description: "If specified, indicates the pod's priority. \"system-node-critical\" and \"system-cluster-critical\" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default."
																type:        "string"
															}
															readinessGates: {
																description: "If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to \"True\" More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates"
																items: {
																	description: "PodReadinessGate contains the reference to a pod condition"
																	properties: conditionType: {
																		description: "ConditionType refers to a condition in the pod's condition list with matching type."
																		type:        "string"
																	}
																	required: ["conditionType"]
																	type: "object"
																}
																type: "array"
															}
															restartPolicy: {
																description: "RestartPolicy describes how the container should be restarted. Only one of the following restart policies may be specified. If none of the following policies is specified, the default one is RestartPolicyAlways."
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
																properties: {
																	fsGroup: {
																		description: """
		A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
		 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
		 If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.
		"""
																		format: "int64"
																		type:   "integer"
																	}
																	fsGroupChangePolicy: {
																		description: "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used. Note that this field cannot be set when spec.os.name is windows."
																		type:        "string"
																	}
																	runAsGroup: {
																		description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
																		format:      "int64"
																		type:        "integer"
																	}
																	runAsNonRoot: {
																		description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
																		type:        "boolean"
																	}
																	runAsUser: {
																		description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
																		format:      "int64"
																		type:        "integer"
																	}
																	seLinuxOptions: {
																		description: "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."
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
																		description: "The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows."
																		properties: {
																			localhostProfile: {
																				description: "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type."
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
																		required: ["type"]
																		type: "object"
																	}
																	supplementalGroups: {
																		description: "A list of groups applied to the first process run in each container, in addition to the container's primary GID, the fsGroup (if specified), and group memberships defined in the container image for the uid of the container process. If unspecified, no additional groups are added to any container. Note that group memberships defined in the container image for the uid of the container process are still effective, even if they are not included in this list. Note that this field cannot be set when spec.os.name is windows."
																		items: {
																			format: "int64"
																			type:   "integer"
																		}
																		type: "array"
																	}
																	sysctls: {
																		description: "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows."
																		items: {
																			description: "Sysctl defines a kernel parameter to be set"
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
																			required: [
																				"name",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	windowsOptions: {
																		description: "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is linux."
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
																				description: "HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true."
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
																format: "int64"
																type:   "integer"
															}
															tolerations: {
																description: "If specified, the pod's tolerations."
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
																description: "TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed."
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
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: """
		MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. MatchLabelKeys cannot be set when LabelSelector isn't set. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector.
		 This is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).
		"""
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
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
		 This is a beta field and requires the MinDomainsInPodTopologySpread feature gate to be enabled (enabled by default).
		"""
																			format: "int32"
																			type:   "integer"
																		}
																		nodeAffinityPolicy: {
																			description: """
		NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.
		 If this value is nil, the behavior is equivalent to the Honor policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
		"""
																			type: "string"
																		}
																		nodeTaintsPolicy: {
																			description: """
		NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.
		 If this value is nil, the behavior is equivalent to the Ignore policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
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
																	required: [
																		"maxSkew",
																		"topologyKey",
																		"whenUnsatisfiable",
																	]
																	type: "object"
																}
																type: "array"
																"x-kubernetes-list-map-keys": [
																	"topologyKey",
																	"whenUnsatisfiable",
																]
																"x-kubernetes-list-type": "map"
															}
															volumes: {
																items: {
																	description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
																	properties: {
																		awsElasticBlockStore: {
																			description: "awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
																			properties: {
																				fsType: {
																					description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
																					type:        "string"
																				}
																				partition: {
																					description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
																					format:      "int32"
																					type:        "integer"
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
																			required: ["volumeID"]
																			type: "object"
																		}
																		azureDisk: {
																			description: "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
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
																			required: [
																				"diskName",
																				"diskURI",
																			]
																			type: "object"
																		}
																		azureFile: {
																			description: "azureFile represents an Azure File Service mount on the host and bind mount to the pod."
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
																			required: [
																				"secretName",
																				"shareName",
																			]
																			type: "object"
																		}
																		cephfs: {
																			description: "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
																			properties: {
																				monitors: {
																					description: "monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																					items: type: "string"
																					type: "array"
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				user: {
																					description: "user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
																					type:        "string"
																				}
																			}
																			required: ["monitors"]
																			type: "object"
																		}
																		cinder: {
																			description: "cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				volumeID: {
																					description: "volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
																					type:        "string"
																				}
																			}
																			required: ["volumeID"]
																			type: "object"
																		}
																		configMap: {
																			description: "configMap represents a configMap that should populate this volume"
																			properties: {
																				defaultMode: {
																					description: "defaultMode is optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
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
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																					type:        "string"
																				}
																				optional: {
																					description: "optional specify whether the ConfigMap or its keys must be defined"
																					type:        "boolean"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		csi: {
																			description: "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature)."
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				readOnly: {
																					description: "readOnly specifies a read-only configuration for the volume. Defaults to false (read/write)."
																					type:        "boolean"
																				}
																				volumeAttributes: {
																					additionalProperties: type: "string"
																					description: "volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
																					type:        "object"
																				}
																			}
																			required: ["driver"]
																			type: "object"
																		}
																		downwardAPI: {
																			description: "downwardAPI represents downward API about the pod that should populate this volume"
																			properties: {
																				defaultMode: {
																					description: "Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				items: {
																					description: "Items is a list of downward API volume file"
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
																								required: ["fieldPath"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["resource"]
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																						}
																						required: ["path"]
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		emptyDir: {
																			description: "emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
																			properties: {
																				medium: {
																					description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
																					type:        "string"
																				}
																				sizeLimit: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description:                  "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																			}
																			type: "object"
																		}
																		ephemeral: {
																			description: """
		ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed.
		 Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity tracking are needed, c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through a PersistentVolumeClaim (see EphemeralVolumeSource for more information on the connection between this volume type and PersistentVolumeClaim).
		 Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod.
		 Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information.
		 A pod can use both types of ephemeral volumes and persistent volumes at the same time.
		"""
																			properties: volumeClaimTemplate: {
																				description: """
		Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long).
		 An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster.
		 This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created.
		 Required, must not be nil.
		"""
																				properties: {
																					metadata: {
																						description: "May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation."
																						type:        "object"
																					}
																					spec: {
																						description: "The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here."
																						properties: {
																							accessModes: {
																								description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																								items: type: "string"
																								type: "array"
																							}
																							dataSource: {
																								description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified. If the namespace is specified, then dataSourceRef will not be copied to dataSource."
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
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																							dataSourceRef: {
																								description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the dataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, when namespace isn't specified in dataSourceRef, both fields (dataSource and dataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. When namespace is specified in dataSourceRef, dataSource isn't set to the same value and must be empty. There are three important differences between dataSource and dataSourceRef: * While dataSource only allows two specific types of objects, dataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While dataSource ignores disallowed values (dropping them), dataSourceRef preserves all values, and generates an error if a disallowed value is specified. * While dataSource only allows local objects, dataSourceRef allows objects in any namespaces. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled. (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled."
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
																									namespace: {
																										description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled."
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
																										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
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
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
																							}
																							storageClassName: {
																								description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																								type:        "string"
																							}
																							volumeAttributesClassName: {
																								description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim. If specified, the CSI driver will create or update the volume with the attributes defined in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName, it can be changed after the claim is created. An empty string value means that no VolumeAttributesClass will be applied to the claim but it's not allowed to reset this field to empty string once it is set. If unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass will be set by the persistentvolume controller if it exists. If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource exists. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#volumeattributesclass (Alpha) Using this field requires the VolumeAttributesClass feature gate to be enabled."
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
																				}
																				required: ["spec"]
																				type: "object"
																			}
																			type: "object"
																		}
																		fc: {
																			description: "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
																			properties: {
																				fsType: {
																					description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
																					type:        "string"
																				}
																				lun: {
																					description: "lun is Optional: FC target lun number"
																					format:      "int32"
																					type:        "integer"
																				}
																				readOnly: {
																					description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																					type:        "boolean"
																				}
																				targetWWNs: {
																					description: "targetWWNs is Optional: FC target worldwide names (WWNs)"
																					items: type: "string"
																					type: "array"
																				}
																				wwids: {
																					description: "wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
																					items: type: "string"
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		flexVolume: {
																			description: "flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
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
																					additionalProperties: type: "string"
																					description: "options is Optional: this field holds extra command options if any."
																					type:        "object"
																				}
																				readOnly: {
																					description: "readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
																					type:        "boolean"
																				}
																				secretRef: {
																					description: "secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																			}
																			required: ["driver"]
																			type: "object"
																		}
																		flocker: {
																			description: "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
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
																			type: "object"
																		}
																		gcePersistentDisk: {
																			description: "gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																			properties: {
																				fsType: {
																					description: "fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
																					type:        "string"
																				}
																				partition: {
																					description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
																					format:      "int32"
																					type:        "integer"
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
																			required: ["pdName"]
																			type: "object"
																		}
																		gitRepo: {
																			description: "gitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
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
																			required: ["repository"]
																			type: "object"
																		}
																		glusterfs: {
																			description: "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
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
																			required: [
																				"endpoints",
																				"path",
																			]
																			type: "object"
																		}
																		hostPath: {
																			description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
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
																			required: ["path"]
																			type: "object"
																		}
																		iscsi: {
																			description: "iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
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
																					format:      "int32"
																					type:        "integer"
																				}
																				portals: {
																					description: "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
																					items: type: "string"
																					type: "array"
																				}
																				readOnly: {
																					description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
																					type:        "boolean"
																				}
																				secretRef: {
																					description: "secretRef is the CHAP Secret for iSCSI target and initiator authentication"
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				targetPortal: {
																					description: "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
																					type:        "string"
																				}
																			}
																			required: [
																				"iqn",
																				"lun",
																				"targetPortal",
																			]
																			type: "object"
																		}
																		name: {
																			description: "name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
																			type:        "string"
																		}
																		nfs: {
																			description: "nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
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
																			required: [
																				"path",
																				"server",
																			]
																			type: "object"
																		}
																		persistentVolumeClaim: {
																			description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
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
																			required: ["claimName"]
																			type: "object"
																		}
																		photonPersistentDisk: {
																			description: "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
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
																			required: ["pdID"]
																			type: "object"
																		}
																		portworxVolume: {
																			description: "portworxVolume represents a portworx volume attached and mounted on kubelets host machine"
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
																			required: ["volumeID"]
																			type: "object"
																		}
																		projected: {
																			description: "projected items for all in one resources secrets, configmaps, and downward API"
																			properties: {
																				defaultMode: {
																					description: "defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				sources: {
																					description: "sources is the list of volume projections"
																					items: {
																						description: "Projection that may be projected along with other supported volume types"
																						properties: {
																							clusterTrustBundle: {
																								description: """
		ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field of ClusterTrustBundle objects in an auto-updating file.
		 Alpha, gated by the ClusterTrustBundleProjection feature gate.
		 ClusterTrustBundle objects can either be selected by name, or by the combination of signer name and a label selector.
		 Kubelet performs aggressive normalization of the PEM contents written into the pod filesystem.  Esoteric PEM features such as inter-block comments and block headers are stripped.  Certificates are deduplicated. The ordering of certificates within the file is arbitrary, and Kubelet may change the order over time.
		"""
																								properties: {
																									labelSelector: {
																										description: "Select all ClusterTrustBundles that match this label selector.  Only has effect if signerName is set.  Mutually-exclusive with name.  If unset, interpreted as \"match nothing\".  If set but empty, interpreted as \"match everything\"."
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
																										type:                    "object"
																										"x-kubernetes-map-type": "atomic"
																									}
																									name: {
																										description: "Select a single ClusterTrustBundle by object name.  Mutually-exclusive with signerName and labelSelector."
																										type:        "string"
																									}
																									optional: {
																										description: "If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available.  If using name, then the named ClusterTrustBundle is allowed not to exist.  If using signerName, then the combination of signerName and labelSelector is allowed to match zero ClusterTrustBundles."
																										type:        "boolean"
																									}
																									path: {
																										description: "Relative path from the volume root to write the bundle."
																										type:        "string"
																									}
																									signerName: {
																										description: "Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name.  The contents of all selected ClusterTrustBundles will be unified and deduplicated."
																										type:        "string"
																									}
																								}
																								required: ["path"]
																								type: "object"
																							}
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
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "optional specify whether the ConfigMap or its keys must be defined"
																										type:        "boolean"
																									}
																								}
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																												required: ["fieldPath"]
																												type:                    "object"
																												"x-kubernetes-map-type": "atomic"
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
																												required: ["resource"]
																												type:                    "object"
																												"x-kubernetes-map-type": "atomic"
																											}
																										}
																										required: ["path"]
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
																										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																										type:        "string"
																									}
																									optional: {
																										description: "optional field specify whether the Secret or its key must be defined"
																										type:        "boolean"
																									}
																								}
																								type:                    "object"
																								"x-kubernetes-map-type": "atomic"
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
																								required: ["path"]
																								type: "object"
																							}
																						}
																						type: "object"
																					}
																					type: "array"
																				}
																			}
																			type: "object"
																		}
																		quobyte: {
																			description: "quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
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
																			required: [
																				"registry",
																				"volume",
																			]
																			type: "object"
																		}
																		rbd: {
																			description: "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
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
																					items: type: "string"
																					type: "array"
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				user: {
																					description: "user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
																					type:        "string"
																				}
																			}
																			required: [
																				"image",
																				"monitors",
																			]
																			type: "object"
																		}
																		scaleIO: {
																			description: "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
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
																			required: [
																				"gateway",
																				"secretRef",
																				"system",
																			]
																			type: "object"
																		}
																		secret: {
																			description: "secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
																			properties: {
																				defaultMode: {
																					description: "defaultMode is Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				items: {
																					description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
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
																				optional: {
																					description: "optional field specify whether the Secret or its keys must be defined"
																					type:        "boolean"
																				}
																				secretName: {
																					description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
																					type:        "string"
																				}
																			}
																			type: "object"
																		}
																		storageos: {
																			description: "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
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
																					properties: name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
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
																			type: "object"
																		}
																		vsphereVolume: {
																			description: "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
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
																			required: ["volumePath"]
																			type: "object"
																		}
																	}
																	required: ["name"]
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
										}
										type: "object"
									}
								}
								type: "object"
							}
							external: {
								description: "External enables you to configure external grafana instances that is not managed by the operator."
								properties: {
									adminPassword: {
										description: "AdminPassword key to talk to the external grafana instance."
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
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									adminUser: {
										description: "AdminUser key to talk to the external grafana instance."
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
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									apiKey: {
										description: "The API key to talk to the external grafana instance, you need to define ether apiKey or adminUser/adminPassword."
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
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									url: {
										description: "URL of the external grafana instance you want to manage."
										type:        "string"
									}
								}
								required: ["url"]
								type: "object"
							}
							ingress: {
								description: "Ingress sets how the ingress object should look like with your grafana instance."
								properties: {
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									spec: {
										description: "IngressSpec describes the Ingress the user wishes to exist."
										properties: {
											defaultBackend: {
												description: "defaultBackend is the backend that should handle requests that don't match any rule. If Rules are not specified, DefaultBackend must be specified. If DefaultBackend is not set, the handling of requests that do not match any of the rules will be up to the Ingress controller."
												properties: {
													resource: {
														description: "resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with \"Service\"."
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
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													service: {
														description: "service references a service as a backend. This is a mutually exclusive setting with \"Resource\"."
														properties: {
															name: {
																description: "name is the referenced service. The service must exist in the same namespace as the Ingress object."
																type:        "string"
															}
															port: {
																description: "port of the referenced service. A port name or port number is required for a IngressServiceBackend."
																properties: {
																	name: {
																		description: "name is the name of the port on the Service. This is a mutually exclusive setting with \"Number\"."
																		type:        "string"
																	}
																	number: {
																		description: "number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with \"Name\"."
																		format:      "int32"
																		type:        "integer"
																	}
																}
																type: "object"
															}
														}
														required: ["name"]
														type: "object"
													}
												}
												type: "object"
											}
											ingressClassName: {
												description: "ingressClassName is the name of an IngressClass cluster resource. Ingress controller implementations use this field to know whether they should be serving this Ingress resource, by a transitive connection (controller -> IngressClass -> Ingress resource). Although the `kubernetes.io/ingress.class` annotation (simple constant name) was never formally defined, it was widely supported by Ingress controllers to create a direct binding between Ingress controller and Ingress resources. Newly created Ingress resources should prefer using the field. However, even though the annotation is officially deprecated, for backwards compatibility reasons, ingress controllers should still honor that annotation if present."
												type:        "string"
											}
											rules: {
												description: "rules is a list of host rules used to configure the Ingress. If unspecified, or no rule matches, all traffic is sent to the default backend."
												items: {
													description: "IngressRule represents the rules mapping the paths under a specified host to the related backend services. Incoming requests are first evaluated for a host match, then routed to the backend associated with the matching IngressRuleValue."
													properties: {
														host: {
															description: """
		host is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the \"host\" part of the URI as defined in RFC 3986: 1. IPs are not allowed. Currently an IngressRuleValue can only apply to the IP in the Spec of the parent Ingress. 2. The `:` delimiter is not respected because ports are not allowed. Currently the port of an Ingress is implicitly :80 for http and :443 for https. Both these may change in the future. Incoming requests are matched against the host before the IngressRuleValue. If the host is unspecified, the Ingress routes all traffic based on the specified IngressRuleValue.
		 host can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.bar.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. \"*.foo.com\"). The wildcard character '*' must appear by itself as the first DNS label and matches only a single label. You cannot have a wildcard label by itself (e.g. Host == \"*\"). Requests will be matched against the Host field in the following way: 1. If host is precise, the request matches this rule if the http host header is equal to Host. 2. If host is a wildcard, then the request matches this rule if the http host header is to equal to the suffix (removing the first label) of the wildcard rule.
		"""
															type: "string"
														}
														http: {
															description: "HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'."
															properties: paths: {
																description: "paths is a collection of paths that map requests to backends."
																items: {
																	description: "HTTPIngressPath associates a path with a backend. Incoming urls matching the path are forwarded to the backend."
																	properties: {
																		backend: {
																			description: "backend defines the referenced service endpoint to which the traffic will be forwarded to."
																			properties: {
																				resource: {
																					description: "resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with \"Service\"."
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
																					type:                    "object"
																					"x-kubernetes-map-type": "atomic"
																				}
																				service: {
																					description: "service references a service as a backend. This is a mutually exclusive setting with \"Resource\"."
																					properties: {
																						name: {
																							description: "name is the referenced service. The service must exist in the same namespace as the Ingress object."
																							type:        "string"
																						}
																						port: {
																							description: "port of the referenced service. A port name or port number is required for a IngressServiceBackend."
																							properties: {
																								name: {
																									description: "name is the name of the port on the Service. This is a mutually exclusive setting with \"Number\"."
																									type:        "string"
																								}
																								number: {
																									description: "number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with \"Name\"."
																									format:      "int32"
																									type:        "integer"
																								}
																							}
																							type: "object"
																						}
																					}
																					required: ["name"]
																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		path: {
																			description: "path is matched against the path of an incoming request. Currently it can contain characters disallowed from the conventional \"path\" part of a URL as defined by RFC 3986. Paths must begin with a '/' and must be present when using PathType with value \"Exact\" or \"Prefix\"."
																			type:        "string"
																		}
																		pathType: {
																			description: "pathType determines the interpretation of the path matching. PathType can be one of the following values: * Exact: Matches the URL path exactly. * Prefix: Matches based on a URL path prefix split by '/'. Matching is done on a path element by element basis. A path element refers is the list of labels in the path split by the '/' separator. A request is a match for path p if every p is an element-wise prefix of p of the request path. Note that if the last element of the path is a substring of the last element in request path, it is not a match (e.g. /foo/bar matches /foo/bar/baz, but does not match /foo/barbaz). * ImplementationSpecific: Interpretation of the Path matching is up to the IngressClass. Implementations can treat this as a separate PathType or treat it identically to Prefix or Exact path types. Implementations are required to support all path types."
																			type:        "string"
																		}
																	}
																	required: [
																		"backend",
																		"pathType",
																	]
																	type: "object"
																}
																type:                     "array"
																"x-kubernetes-list-type": "atomic"
															}
															required: ["paths"]
															type: "object"
														}
													}
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											tls: {
												description: "tls represents the TLS configuration. Currently the Ingress only supports a single TLS port, 443. If multiple members of this list specify different hosts, they will be multiplexed on the same port according to the hostname specified through the SNI TLS extension, if the ingress controller fulfilling the ingress supports SNI."
												items: {
													description: "IngressTLS describes the transport layer security associated with an ingress."
													properties: {
														hosts: {
															description: "hosts is a list of hosts included in the TLS certificate. The values in this list must match the name/s used in the tlsSecret. Defaults to the wildcard host setting for the loadbalancer controller fulfilling this Ingress, if left unspecified."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														secretName: {
															description: "secretName is the name of the secret used to terminate TLS traffic on port 443. Field is left optional to allow TLS routing based on SNI hostname alone. If the SNI host in a listener conflicts with the \"Host\" header field used by an IngressRule, the SNI host is used for termination and value of the \"Host\" header is used for routing."
															type:        "string"
														}
													}
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							jsonnet: {
								properties: libraryLabelSelector: {
									description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."
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
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "object"
							}
							persistentVolumeClaim: {
								description: "PersistentVolumeClaim creates a PVC if you need to attach one to your grafana instance."
								properties: {
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									spec: {
										properties: {
											accessModes: {
												items: type: "string"
												type: "array"
											}
											dataSource: {
												description: "TypedLocalObjectReference contains enough information to let you locate the typed referenced object inside the same namespace."
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
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											dataSourceRef: {
												description: "TypedLocalObjectReference contains enough information to let you locate the typed referenced object inside the same namespace."
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
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											resources: {
												description: "ResourceRequirements describes the compute resource requirements."
												properties: {
													claims: {
														description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.
		 This field is immutable. It can only be set for containers.
		"""
														items: {
															description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
															properties: name: {
																description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."
																type:        "string"
															}
															required: ["name"]
															type: "object"
														}
														type: "array"
														"x-kubernetes-list-map-keys": ["name"]
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
														description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
														type:        "object"
													}
												}
												type: "object"
											}
											selector: {
												description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."
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
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											storageClassName: type: "string"
											volumeMode: {
												description: "PersistentVolumeMode describes how a volume is intended to be consumed, either Block or Filesystem."
												type:        "string"
											}
											volumeName: {
												description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							preferences: {
								description: "Preferences holds the Grafana Preferences settings"
								properties: homeDashboardUid: type: "string"
								type: "object"
							}
							route: {
								description: "Route sets how the ingress object should look like with your grafana instance, this only works in Openshift."
								properties: {
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									spec: {
										properties: {
											alternateBackends: {
												items: {
													description: "RouteTargetReference specifies the target that resolve into endpoints. Only the 'Service' kind is allowed. Use 'weight' field to emphasize one over others."
													properties: {
														kind: {
															description: "The kind of target that the route is referring to. Currently, only 'Service' is allowed"
															type:        "string"
														}
														name: {
															description: "name of the service/target that is being referred to. e.g. name of the service"
															type:        "string"
														}
														weight: {
															description: "weight as an integer between 0 and 256, default 100, that specifies the target's relative weight against other target reference objects. 0 suppresses requests to this backend."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"kind",
														"name",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											host: type: "string"
											path: type: "string"
											port: {
												description: "RoutePort defines a port mapping from a router to an endpoint in the service endpoints."
												properties: targetPort: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													description:                  "The target port on pods selected by the service this route points to. If this is a string, it will be looked up as a named port in the target endpoints port list. Required"
													"x-kubernetes-int-or-string": true
												}
												required: ["targetPort"]
												type: "object"
											}
											tls: {
												description: "TLSConfig defines config used to secure a route and provide termination"
												properties: {
													caCertificate: {
														description: "caCertificate provides the cert authority certificate contents"
														type:        "string"
													}
													certificate: {
														description: "certificate provides certificate contents"
														type:        "string"
													}
													destinationCACertificate: {
														description: "destinationCACertificate provides the contents of the ca certificate of the final destination.  When using reencrypt termination this file should be provided in order to have routers use it for health checks on the secure connection. If this field is not specified, the router may provide its own destination CA and perform hostname validation using the short service name (service.namespace.svc), which allows infrastructure generated certificates to automatically verify."
														type:        "string"
													}
													insecureEdgeTerminationPolicy: {
														description: """
		insecureEdgeTerminationPolicy indicates the desired behavior for insecure connections to a route. While each router may make its own decisions on which ports to expose, this is normally port 80.
		 * Allow - traffic is sent to the server on the insecure port (default) * Disable - no traffic is allowed on the insecure port. * Redirect - clients are redirected to the secure port.
		"""
														type: "string"
													}
													key: {
														description: "key provides key file contents"
														type:        "string"
													}
													termination: {
														description: "termination indicates termination type."
														type:        "string"
													}
												}
												required: ["termination"]
												type: "object"
											}
											to: {
												description: "RouteTargetReference specifies the target that resolve into endpoints. Only the 'Service' kind is allowed. Use 'weight' field to emphasize one over others."
												properties: {
													kind: {
														description: "The kind of target that the route is referring to. Currently, only 'Service' is allowed"
														type:        "string"
													}
													name: {
														description: "name of the service/target that is being referred to. e.g. name of the service"
														type:        "string"
													}
													weight: {
														description: "weight as an integer between 0 and 256, default 100, that specifies the target's relative weight against other target reference objects. 0 suppresses requests to this backend."
														format:      "int32"
														type:        "integer"
													}
												}
												required: [
													"kind",
													"name",
													"weight",
												]
												type: "object"
											}
											wildcardPolicy: {
												description: "WildcardPolicyType indicates the type of wildcard support needed by routes."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							service: {
								description: "Service sets how the service object should look like with your grafana instance, contains a number of defaults."
								properties: {
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service."
										properties: {
											allocateLoadBalancerNodePorts: {
												description: "allocateLoadBalancerNodePorts defines if NodePorts will be automatically allocated for services with type LoadBalancer.  Default is \"true\". It may be set to \"false\" if the cluster load-balancer does not rely on NodePorts.  If the caller requests specific NodePorts (by specifying a value), those requests will be respected, regardless of this field. This field may only be set for services with type LoadBalancer and will be cleared if the type is changed to any other type."
												type:        "boolean"
											}
											clusterIP: {
												description: "clusterIP is the IP address of the service and is usually assigned randomly. If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be blank) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are \"None\", empty string (\"\"), or a valid IP address. Setting this to \"None\" makes a \"headless service\" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies"
												type:        "string"
											}
											clusterIPs: {
												description: """
		ClusterIPs is a list of IP addresses assigned to this service, and are usually assigned randomly.  If an address is specified manually, is in-range (as per system configuration), and is not in use, it will be allocated to the service; otherwise creation of the service will fail. This field may not be changed through updates unless the type field is also being changed to ExternalName (which requires this field to be empty) or the type field is being changed from ExternalName (in which case this field may optionally be specified, as describe above).  Valid values are \"None\", empty string (\"\"), or a valid IP address.  Setting this to \"None\" makes a \"headless service\" (no virtual IP), which is useful when direct endpoint connections are preferred and proxying is not required.  Only applies to types ClusterIP, NodePort, and LoadBalancer. If this field is specified when creating a Service of type ExternalName, creation will fail. This field will be wiped when updating a Service to type ExternalName.  If this field is not specified, it will be initialized from the clusterIP field.  If this field is specified, clients must ensure that clusterIPs[0] and clusterIP have the same value.
		 This field may hold a maximum of two entries (dual-stack IPs, in either order). These IPs must correspond to the values of the ipFamilies field. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
		"""
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											externalIPs: {
												description: "externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.  These IPs are not managed by Kubernetes.  The user is responsible for ensuring that traffic arrives at a node with this IP.  A common example is external load-balancers that are not part of the Kubernetes system."
												items: type: "string"
												type: "array"
											}
											externalName: {
												description: "externalName is the external reference that discovery mechanisms will return as an alias for this service (e.g. a DNS CNAME record). No proxying will be involved.  Must be a lowercase RFC-1123 hostname (https://tools.ietf.org/html/rfc1123) and requires `type` to be \"ExternalName\"."
												type:        "string"
											}
											externalTrafficPolicy: {
												description: "externalTrafficPolicy describes how nodes distribute service traffic they receive on one of the Service's \"externally-facing\" addresses (NodePorts, ExternalIPs, and LoadBalancer IPs). If set to \"Local\", the proxy will configure the service in a way that assumes that external load balancers will take care of balancing the service traffic between nodes, and so each node will deliver traffic only to the node-local endpoints of the service, without masquerading the client source IP. (Traffic mistakenly sent to a node with no endpoints will be dropped.) The default value, \"Cluster\", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features). Note that traffic sent to an External IP or LoadBalancer IP from within the cluster will always get \"Cluster\" semantics, but clients sending to a NodePort from within the cluster may need to take traffic policy into account when picking a node."
												type:        "string"
											}
											healthCheckNodePort: {
												description: "healthCheckNodePort specifies the healthcheck nodePort for the service. This only applies when type is set to LoadBalancer and externalTrafficPolicy is set to Local. If a value is specified, is in-range, and is not in use, it will be used.  If not specified, a value will be automatically allocated.  External systems (e.g. load-balancers) can use this port to determine if a given node holds endpoints for this service or not.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type). This field cannot be updated once set."
												format:      "int32"
												type:        "integer"
											}
											internalTrafficPolicy: {
												description: "InternalTrafficPolicy describes how nodes distribute service traffic they receive on the ClusterIP. If set to \"Local\", the proxy will assume that pods only want to talk to endpoints of the service on the same node as the pod, dropping the traffic if there are no local endpoints. The default value, \"Cluster\", uses the standard behavior of routing to all endpoints evenly (possibly modified by topology and other features)."
												type:        "string"
											}
											ipFamilies: {
												description: """
		IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this service. This field is usually assigned automatically based on cluster configuration and the ipFamilyPolicy field. If this field is specified manually, the requested family is available in the cluster, and ipFamilyPolicy allows it, it will be used; otherwise creation of the service will fail. This field is conditionally mutable: it allows for adding or removing a secondary IP family, but it does not allow changing the primary IP family of the Service. Valid values are \"IPv4\" and \"IPv6\".  This field only applies to Services of types ClusterIP, NodePort, and LoadBalancer, and does apply to \"headless\" services. This field will be wiped when updating a Service to type ExternalName.
		 This field may hold a maximum of two entries (dual-stack families, in either order).  These families must correspond to the values of the clusterIPs field, if specified. Both clusterIPs and ipFamilies are governed by the ipFamilyPolicy field.
		"""
												items: {
													description: "IPFamily represents the IP Family (IPv4 or IPv6). This type is used to express the family of an IP expressed by a type (e.g. service.spec.ipFamilies)."
													type:        "string"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											ipFamilyPolicy: {
												description: "IPFamilyPolicy represents the dual-stack-ness requested or required by this Service. If there is no value provided, then this field will be set to SingleStack. Services can be \"SingleStack\" (a single IP family), \"PreferDualStack\" (two IP families on dual-stack configured clusters or a single IP family on single-stack clusters), or \"RequireDualStack\" (two IP families on dual-stack configured clusters, otherwise fail). The ipFamilies and clusterIPs fields depend on the value of this field. This field will be wiped when updating a service to type ExternalName."
												type:        "string"
											}
											loadBalancerClass: {
												description: "loadBalancerClass is the class of the load balancer implementation this Service belongs to. If specified, the value of this field must be a label-style identifier, with an optional prefix, e.g. \"internal-vip\" or \"example.com/internal-vip\". Unprefixed names are reserved for end-users. This field can only be set when the Service type is 'LoadBalancer'. If not set, the default load balancer implementation is used, today this is typically done through the cloud provider integration, but should apply for any default implementation. If set, it is assumed that a load balancer implementation is watching for Services with a matching class. Any default load balancer implementation (e.g. cloud providers) should ignore Services that set this field. This field can only be set when creating or updating a Service to type 'LoadBalancer'. Once set, it can not be changed. This field will be wiped when a service is updated to a non 'LoadBalancer' type."
												type:        "string"
											}
											loadBalancerIP: {
												description: "Only applies to Service Type: LoadBalancer. This feature depends on whether the underlying cloud-provider supports specifying the loadBalancerIP when a load balancer is created. This field will be ignored if the cloud-provider does not support the feature. Deprecated: This field was under-specified and its meaning varies across implementations. Using it is non-portable and it may not support dual-stack. Users are encouraged to use implementation-specific annotations when available."
												type:        "string"
											}
											loadBalancerSourceRanges: {
												description: "If specified and supported by the platform, this will restrict traffic through the cloud-provider load-balancer will be restricted to the specified client IPs. This field will be ignored if the cloud-provider does not support the feature.\" More info: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/"
												items: type: "string"
												type: "array"
											}
											ports: {
												description: "The list of ports that are exposed by this service. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies"
												items: {
													description: "ServicePort contains information on service's port."
													properties: {
														appProtocol: {
															description: """
		The application protocol for this port. This is used as a hint for implementations to offer richer behavior for protocols that they understand. This field follows standard Kubernetes label syntax. Valid values are either:
		 * Un-prefixed protocol names - reserved for IANA standard service names (as per RFC-6335 and https://www.iana.org/assignments/service-names).
		 * Kubernetes-defined prefixed names: * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior- * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455 * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455
		 * Other protocols should use implementation-defined prefixed names such as mycompany.com/my-custom-protocol.
		"""
															type: "string"
														}
														name: {
															description: "The name of this port within the service. This must be a DNS_LABEL. All ports within a ServiceSpec must have unique names. When considering the endpoints for a Service, this must match the 'name' field in the EndpointPort. Optional if only one ServicePort is defined on this service."
															type:        "string"
														}
														nodePort: {
															description: "The port on each node on which this service is exposed when type is NodePort or LoadBalancer.  Usually assigned by the system. If a value is specified, in-range, and not in use it will be used, otherwise the operation will fail.  If not specified, a port will be allocated if this Service requires one.  If this field is specified when creating a Service which does not need it, creation will fail. This field will be wiped when updating a Service to no longer need it (e.g. changing type from NodePort to ClusterIP). More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport"
															format:      "int32"
															type:        "integer"
														}
														port: {
															description: "The port that will be exposed by this service."
															format:      "int32"
															type:        "integer"
														}
														protocol: {
															default:     "TCP"
															description: "The IP protocol for this port. Supports \"TCP\", \"UDP\", and \"SCTP\". Default is TCP."
															type:        "string"
														}
														targetPort: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME. If this is a string, it will be looked up as a named port in the target Pod's container ports. If this is not specified, the value of the 'port' field is used (an identity map). This field is ignored for services with clusterIP=None, and should be omitted or set equal to the 'port' field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service"
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												type: "array"
												"x-kubernetes-list-map-keys": [
													"port",
													"protocol",
												]
												"x-kubernetes-list-type": "map"
											}
											publishNotReadyAddresses: {
												description: "publishNotReadyAddresses indicates that any agent which deals with endpoints for this Service should disregard any indications of ready/not-ready. The primary use case for setting this field is for a StatefulSet's Headless Service to propagate SRV DNS records for its Pods for the purpose of peer discovery. The Kubernetes controllers that generate Endpoints and EndpointSlice resources for Services interpret this to mean that all endpoints are considered \"ready\" even if the Pods themselves are not. Agents which consume only Kubernetes generated endpoints through the Endpoints or EndpointSlice resources can safely assume this behavior."
												type:        "boolean"
											}
											selector: {
												additionalProperties: type: "string"
												description:             "Route service traffic to pods with label keys and values matching this selector. If empty or not present, the service is assumed to have an external process managing its endpoints, which Kubernetes will not modify. Only applies to types ClusterIP, NodePort, and LoadBalancer. Ignored if type is ExternalName. More info: https://kubernetes.io/docs/concepts/services-networking/service/"
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											sessionAffinity: {
												description: "Supports \"ClientIP\" and \"None\". Used to maintain session affinity. Enable client IP based session affinity. Must be ClientIP or None. Defaults to None. More info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies"
												type:        "string"
											}
											sessionAffinityConfig: {
												description: "sessionAffinityConfig contains the configurations of session affinity."
												properties: clientIP: {
													description: "clientIP contains the configurations of Client IP based session affinity."
													properties: timeoutSeconds: {
														description: "timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == \"ClientIP\". Default value is 10800(for 3 hours)."
														format:      "int32"
														type:        "integer"
													}
													type: "object"
												}
												type: "object"
											}
											type: {
												description: "type determines how the Service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer. \"ClusterIP\" allocates a cluster-internal IP address for load-balancing to endpoints. Endpoints are determined by the selector or if that is not specified, by manual construction of an Endpoints object or EndpointSlice objects. If clusterIP is \"None\", no virtual IP is allocated and the endpoints are published as a set of endpoints rather than a virtual IP. \"NodePort\" builds on ClusterIP and allocates a port on every node which routes to the same endpoints as the clusterIP. \"LoadBalancer\" builds on NodePort and creates an external load-balancer (if supported in the current cloud) which routes to the same endpoints as the clusterIP. \"ExternalName\" aliases this service to the specified externalName. Several other fields do not apply to ExternalName services. More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types"
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccount: {
								description: "ServiceAccount sets how the ServiceAccount object should look like with your grafana instance, contains a number of defaults."
								properties: {
									automountServiceAccountToken: type: "boolean"
									imagePullSecrets: {
										items: {
											description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
											properties: name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										type: "array"
									}
									metadata: {
										description: "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta)."
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
									secrets: {
										items: {
											description: """
		ObjectReference contains enough information to let you inspect or modify the referred object. --- New uses of this type are discouraged because of difficulty describing its usage when embedded in APIs. 1. Ignored fields.  It includes many fields which are not generally honored.  For instance, ResourceVersion and FieldPath are both very rarely valid in actual usage. 2. Invalid usage help.  It is impossible to add specific help for individual usage.  In most embedded usages, there are particular restrictions like, \"must refer only to types A and B\" or \"UID not honored\" or \"name must be restricted\". Those cannot be well described when embedded. 3. Inconsistent validation.  Because the usages are different, the validation rules are different by usage, which makes it hard for users to predict what will happen. 4. The fields are both imprecise and overly precise.  Kind is not a precise mapping to a URL. This can produce ambiguity during interpretation and require a REST mapping.  In most cases, the dependency is on the group,resource tuple and the version of the actual struct is irrelevant. 5. We cannot easily change it.  Because this type is embedded in many locations, updates to this type will affect numerous schemas.  Don't make new APIs embed an underspecified API type they do not control.
		 Instead of using this type, create a locally provided and used type that is well-focused on your reference. For example, ServiceReferences for admission registration: https://github.com/kubernetes/api/blob/release-1.17/admissionregistration/v1/types.go#L533 .
		"""
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
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										type: "array"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "GrafanaStatus defines the observed state of Grafana"
						properties: {
							adminUrl: type: "string"
							dashboards: {
								items: type: "string"
								type: "array"
							}
							datasources: {
								items: type: "string"
								type: "array"
							}
							folders: {
								items: type: "string"
								type: "array"
							}
							lastMessage: type: "string"
							stage: type:       "string"
							stageStatus: type: "string"
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
