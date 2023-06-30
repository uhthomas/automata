package vm_operator

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
		annotations: "controller-gen.kubebuilder.io/version": "v0.10.0"
		name: "vmagents.operator.victoriametrics.com"
	}
	spec: {
		group: "operator.victoriametrics.com"
		names: {
			kind:     "VMAgent"
			listKind: "VMAgentList"
			plural:   "vmagents"
			singular: "vmagent"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "current number of shards"
				jsonPath:    ".status.shards"
				name:        "Shards Count"
				type:        "integer"
			}, {
				description: "current number of replicas"
				jsonPath:    ".status.replicas"
				name:        "Replica Count"
				type:        "integer"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "VMAgent - is a tiny but brave agent, which helps you collect metrics from various sources and stores them in VictoriaMetrics or any other Prometheus-compatible storage system that supports the remote_write protocol."

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
						description: "VMAgentSpec defines the desired state of VMAgent"
						properties: {
							"-": {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server"

								type: "string"
							}
							aPIServerConfig: {
								description: "APIServerConfig allows specifying a host and auth methods to access apiserver. If left empty, VMAgent is assumed to run inside of the cluster and will discover API servers automatically and use the pod's CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/."

								properties: {
									authorization: {
										description: "Authorization configures generic authorization params"
										properties: {
											credentials: {
												description: "Reference to the secret with value for authorization"
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											credentialsFile: {
												description: "File with value for authorization"
												type:        "string"
											}
											type: {
												description: "Type of authorization, default to bearer"
												type:        "string"
											}
										}
										type: "object"
									}
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"

										properties: {
											password: {
												description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											password_file: {
												description: "PasswordFile defines path to password file at disk"

												type: "string"
											}
											username: {
												description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerToken: {
										description: "Bearer token for accessing apiserver."
										type:        "string"
									}
									bearerTokenFile: {
										description: "File to read bearer token for accessing apiserver."
										type:        "string"
									}
									host: {
										description: "Host of apiserver. A valid string consisting of a hostname or IP followed by an optional port number"

										type: "string"
									}
									tlsConfig: {
										description: "TLSConfig Config to use for accessing apiserver."
										properties: {
											ca: {
												description: "Stuct containing the CA cert to use for the targets."
												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."

														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"

																type: "boolean"
															}
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: {
												description: "Path to the CA cert in the container to use for the targets."

												type: "string"
											}
											cert: {
												description: "Struct containing the client cert file for the targets."

												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."

														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"

																type: "boolean"
															}
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: {
												description: "Path to the client cert file in the container for the targets."

												type: "string"
											}
											insecureSkipVerify: {
												description: "Disable target certificate validation."
												type:        "boolean"
											}
											keyFile: {
												description: "Path to the client key file in the container for the targets."

												type: "string"
											}
											keySecret: {
												description: "Secret containing the client key file for the targets."

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: {
												description: "Used to verify the hostname for the targets."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								required: [
									"host",
								]
								type: "object"
							}
							additionalScrapeConfigs: {
								description: "AdditionalScrapeConfigs As scrape configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of VMAgent. It is advised to review VMAgent release notes to ensure that no incompatible scrape configs are going to break VMAgent after the upgrade."

								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							affinity: {
								description:                            "Affinity If specified, the pod's scheduling constraints."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							arbitraryFSAccessThroughSMs: {
								description: "ArbitraryFSAccessThroughSMs configures whether configuration based on a service scrape can access arbitrary files on the file system of the VMAgent container e.g. bearer token files."

								properties: deny: type: "boolean"
								type: "object"
							}
							claimTemplates: {
								description: "ClaimTemplates allows adding additional VolumeClaimTemplates for VMAgent in StatefulMode"

								items: {
									description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"

									properties: {
										apiVersion: {
											description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

											type: "string"
										}
										kind: {
											description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

											type: "string"
										}
										metadata: {
											description:                            "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										spec: {
											description: "spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

															type: "string"
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
													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

													properties: {
														apiGroup: {
															description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

															type: "string"
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

															type: "object"
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

															type: "object"
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

																		type: "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																		type: "string"
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

															type: "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												storageClassName: {
													description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

													type: "string"
												}
												volumeMode: {
													description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

													type: "string"
												}
												volumeName: {
													description: "volumeName is the binding reference to the PersistentVolume backing this claim."

													type: "string"
												}
											}
											type: "object"
										}
										status: {
											description: "status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

											properties: {
												accessModes: {
													description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

													items: type: "string"
													type: "array"
												}
												allocatedResources: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

													type: "object"
												}
												capacity: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "capacity represents the actual resources of the underlying volume."

													type: "object"
												}
												conditions: {
													description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

													items: {
														description: "PersistentVolumeClaimCondition contails details about state of pvc"

														properties: {
															lastProbeTime: {
																description: "lastProbeTime is the time we probed the condition."

																format: "date-time"
																type:   "string"
															}
															lastTransitionTime: {
																description: "lastTransitionTime is the time the condition transitioned from one status to another."

																format: "date-time"
																type:   "string"
															}
															message: {
																description: "message is the human-readable message indicating details about last transition."

																type: "string"
															}
															reason: {
																description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																type: "string"
															}
															status: type: "string"
															type: {
																description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																type: "string"
															}
														}
														required: [
															"status",
															"type",
														]
														type: "object"
													}
													type: "array"
												}
												phase: {
													description: "phase represents the current phase of PersistentVolumeClaim."
													type:        "string"
												}
												resizeStatus: {
													description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

													type: "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the vmagent object, which shall be mounted into the vmagent Pods. will be mounted at path  /etc/vm/configs"

								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

								items: {
									description: "A single application container that you want to run within a pod."

									required: [
										"name",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							dnsConfig: {
								description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

								items: "x-kubernetes-preserve-unknown-fields": true
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
								description: "DNSPolicy set DNS policy for the pod"
								type:        "string"
							}
							enforcedNamespaceLabel: {
								description: "EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created."

								type: "string"
							}
							externalLabels: {
								additionalProperties: type: "string"
								description: "ExternalLabels The labels to add to any time series scraped by vmagent. it doesn't affect metrics ingested directly by push API's"

								type: "object"
							}
							extraArgs: {
								additionalProperties: type: "string"
								description: "ExtraArgs that will be passed to  VMAgent pod for example remoteWrite.tmpDataPath: /tmp it would be converted to flag --remoteWrite.tmpDataPath=/tmp"

								type: "object"
							}
							extraEnvs: {
								description: "ExtraEnvs that will be added to VMAgent pod"
								items: {
									description: "EnvVar represents an environment variable present in a Container."

									properties: {
										name: {
											description: "Name of the environment variable. Must be a C_IDENTIFIER."
											type:        "string"
										}
										value: {
											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

											type: "string"
										}
									}
									required: [
										"name",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							host_aliases: {
								description: "HostAliases provides mapping between ip and hostnames, that would be propagated to pod, cannot be used with HostNetwork."

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
							hostNetwork: {
								description: "HostNetwork controls whether the pod may use the node network namespace"

								type: "boolean"
							}
							ignoreNamespaceSelectors: {
								description: "IgnoreNamespaceSelectors if set to true will ignore NamespaceSelector settings from the podscrape and vmservicescrape configs, and they will only discover endpoints within their current namespace.  Defaults to false."

								type: "boolean"
							}
							image: {
								description: "Image - docker image settings for VMAgent if no specified operator uses default config version"

								properties: {
									pullPolicy: {
										description: "PullPolicy describes how to pull docker image"
										type:        "string"
									}
									repository: {
										description: "Repository contains name of docker image + it's repository if needed"

										type: "string"
									}
									tag: {
										description: "Tag contains desired docker image version"
										type:        "string"
									}
								}
								type: "object"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the vmagent configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

								items: {
									description: "A single application container that you want to run within a pod."

									required: [
										"name",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							inlineRelabelConfig: {
								description: "InlineRelabelConfig - defines GlobalRelabelConfig for vmagent, can be defined directly at CRD."

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							inlineScrapeConfig: {
								description: "InlineScrapeConfig As scrape configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of VMAgent. It is advised to review VMAgent release notes to ensure that no incompatible scrape configs are going to break VMAgent after the upgrade. it should be defined as single yaml file. inlineScrapeConfig: | - job_name: \"prometheus\" static_configs: - targets: [\"localhost:9090\"]"

								type: "string"
							}
							insertPorts: {
								description: "InsertPorts - additional listen ports for data ingestion."
								properties: {
									graphitePort: {
										description: "GraphitePort listen port"
										type:        "string"
									}
									influxPort: {
										description: "InfluxPort listen port"
										type:        "string"
									}
									openTSDBHTTPPort: {
										description: "OpenTSDBHTTPPort for http connections."
										type:        "string"
									}
									openTSDBPort: {
										description: "OpenTSDBPort for tcp and udp listen"
										type:        "string"
									}
								}
								type: "object"
							}
							livenessProbe: {
								description:                            "LivenessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logFormat: {
								description: "LogFormat for VMAgent to be configured with."
								enum: [
									"default",
									"json",
								]
								type: "string"
							}
							logLevel: {
								description: "LogLevel for VMAgent to be configured with. INFO, WARN, ERROR, FATAL, PANIC"

								enum: [
									"INFO",
									"WARN",
									"ERROR",
									"FATAL",
									"PANIC",
								]
								type: "string"
							}
							maxScrapeInterval: {
								description: "MaxScrapeInterval allows limiting maximum scrape interval for VMServiceScrape, VMPodScrape and other scrapes If interval is higher than defined limit, `maxScrapeInterval` will be used."

								type: "string"
							}
							minScrapeInterval: {
								description: "MinScrapeInterval allows limiting minimal scrape interval for VMServiceScrape, VMPodScrape and other scrapes If interval is lower than defined limit, `minScrapeInterval` will be used."

								type: "string"
							}
							nodeScrapeNamespaceSelector: {
								description: "NodeScrapeNamespaceSelector defines Namespaces to be selected for VMNodeScrape discovery. Works in combination with Selector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							nodeScrapeRelabelTemplate: {
								description: "NodeScrapeRelabelTemplate defines relabel config, that will be added to each VMNodeScrape. it's useful for adding specific labels to all targets"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							nodeScrapeSelector: {
								description: "NodeScrapeSelector defines VMNodeScrape to be selected for scraping. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector Define which Nodes the Pods are scheduled on."

								type: "object"
							}
							overrideHonorLabels: {
								description: "OverrideHonorLabels if set to true overrides all user configured honor_labels. If HonorLabels is set in ServiceScrape or PodScrape to true, this overrides honor_labels to false."

								type: "boolean"
							}
							overrideHonorTimestamps: {
								description: "OverrideHonorTimestamps allows to globally enforce honoring timestamps in all scrape configs."

								type: "boolean"
							}
							podDisruptionBudget: {
								description: "PodDisruptionBudget created by operator"
								properties: {
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

										"x-kubernetes-int-or-string": true
									}
									minAvailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

										"x-kubernetes-int-or-string": true
									}
									selectorLabels: {
										additionalProperties: type: "string"
										description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

										type: "object"
									}
								}
								type: "object"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the vmagent pods."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							podScrapeNamespaceSelector: {
								description: "PodScrapeNamespaceSelector defines Namespaces to be selected for VMPodScrape discovery. Works in combination with Selector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podScrapeRelabelTemplate: {
								description: "PodScrapeRelabelTemplate defines relabel config, that will be added to each VMPodScrape. it's useful for adding specific labels to all targets"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							podScrapeSelector: {
								description: "PodScrapeSelector defines PodScrapes to be selected for target discovery. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							port: {
								description: "Port listen address"
								type:        "string"
							}
							priorityClassName: {
								description: "PriorityClassName assigned to the Pods"
								type:        "string"
							}
							probeNamespaceSelector: {
								description: "ProbeNamespaceSelector defines Namespaces to be selected for VMProbe discovery. Works in combination with Selector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							probeScrapeRelabelTemplate: {
								description: "ProbeScrapeRelabelTemplate defines relabel config, that will be added to each VMProbeScrape. it's useful for adding specific labels to all targets"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							probeSelector: {
								description: "ProbeSelector defines VMProbe to be selected for target probing. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							readinessGates: {
								description: "ReadinessGates defines pod readiness gates"
								items: {
									description: "PodReadinessGate contains the reference to a pod condition"
									properties: conditionType: {
										description: "ConditionType refers to a condition in the pod's condition list with matching type."

										type: "string"
									}
									required: [
										"conditionType",
									]
									type: "object"
								}
								type: "array"
							}
							readinessProbe: {
								description:                            "ReadinessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							relabelConfig: {
								description: "RelabelConfig ConfigMap with global relabel config -remoteWrite.relabelConfig This relabeling is applied to all the collected metrics before sending them to remote storage."

								properties: {
									key: {
										description: "The key to select."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									optional: {
										description: "Specify whether the ConfigMap or its key must be defined"

										type: "boolean"
									}
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							remoteWrite: {
								description: "RemoteWrite list of victoria metrics /some other remote write system for vm it must looks like: http://victoria-metrics-single:8429/api/v1/write or for cluster different url https://github.com/VictoriaMetrics/VictoriaMetrics/tree/master/app/vmagent#splitting-data-streams-among-multiple-systems"

								items: {
									description: "VMAgentRemoteWriteSpec defines the remote storage configuration for VmAgent"

									properties: {
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication"

											properties: {
												password: {
													description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												password_file: {
													description: "PasswordFile defines path to password file at disk"

													type: "string"
												}
												username: {
													description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenSecret: {
											description: "Optional bearer auth token to use for -remoteWrite.url"
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."

													type: "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"

													type: "boolean"
												}
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										headers: {
											description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName: headerValue vmagent supports since 1.79.0 version"

											items: type: "string"
											type: "array"
										}
										inlineUrlRelabelConfig: {
											description: "InlineUrlRelabelConfig defines relabeling config for remoteWriteURL, it can be defined at crd spec."

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											description: "OAuth2 defines auth configuration"
											properties: {
												client_id: {
													description: "The secret or configmap containing the OAuth2 client id"

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												client_secret: {
													description: "The secret containing the OAuth2 client secret"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												client_secret_file: {
													description: "ClientSecretFile defines path for client secret file."

													type: "string"
												}
												endpoint_params: {
													additionalProperties: type: "string"
													description: "Parameters to append to the token URL"
													type:        "object"
												}
												scopes: {
													description: "OAuth2 scopes used for the token request"
													items: type: "string"
													type: "array"
												}
												token_url: {
													description: "The URL to fetch the token from"
													minLength:   1
													type:        "string"
												}
											}
											required: [
												"client_id",
												"token_url",
											]
											type: "object"
										}
										sendTimeout: {
											description: "Timeout for sending a single block of data to -remoteWrite.url (default 1m0s)"

											pattern: "[0-9]+(ms|s|m|h)"
											type:    "string"
										}
										streamAggrConfig: {
											description: "StreamAggrConfig defines stream aggregation configuration for VMAgent for -remoteWrite.url"

											properties: {
												dedupInterval: {
													description: "Allows setting different de-duplication intervals per each configured remote storage"

													type: "string"
												}
												keepInput: {
													description: "Allows writing both raw and aggregate data"
													type:        "boolean"
												}
												rules: {
													description: "Stream aggregation rules"
													items: {
														description: "StreamAggrRule defines the rule in stream aggregation config"

														properties: {
															by: {
																description: """
		By is an optional list of labels for grouping input series.
		 See also Without.
		 If neither By nor Without are set, then the Outputs are calculated individually per each input time series.
		"""

																items: type: "string"
																type: "array"
															}
															input_relabel_configs: {
																description: "InputRelabelConfigs is an optional relabeling rules, which are applied on the input before aggregation."

																items: {
																	description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

																	properties: {
																		action: {
																			description: "Action to perform based on regex matching. Default is 'replace'"

																			type: "string"
																		}
																		if: {
																			description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

																			type: "string"
																		}
																		labels: {
																			additionalProperties: type: "string"
																			description: "Labels is used together with Match for `action: graphite`"

																			type: "object"
																		}
																		match: {
																			description: "Match is used together with Labels for `action: graphite`"

																			type: "string"
																		}
																		modulus: {
																			description: "Modulus to take of the hash of the source label values."

																			format: "int64"
																			type:   "integer"
																		}
																		regex: {
																			description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

																			type: "string"
																		}
																		replacement: {
																			description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

																			type: "string"
																		}
																		separator: {
																			description: "Separator placed between concatenated source label values. default is ';'."

																			type: "string"
																		}
																		source_labels: {
																			description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																			items: type: "string"
																			type: "array"
																		}
																		sourceLabels: {
																			description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

																			items: type: "string"
																			type: "array"
																		}
																		target_label: {
																			description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																			type: "string"
																		}
																		targetLabel: {
																			description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

																			type: "string"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															interval: {
																description: "Interval is the interval between aggregations."
																type:        "string"
															}
															match: {
																description: """
		Match is a label selector for filtering time series for the given selector.
		 If the match isn't set, then all the input time series are processed.
		"""

																type: "string"
															}
															output_relabel_configs: {
																description: "OutputRelabelConfigs is an optional relabeling rules, which are applied on the aggregated output before being sent to remote storage."

																items: {
																	description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

																	properties: {
																		action: {
																			description: "Action to perform based on regex matching. Default is 'replace'"

																			type: "string"
																		}
																		if: {
																			description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

																			type: "string"
																		}
																		labels: {
																			additionalProperties: type: "string"
																			description: "Labels is used together with Match for `action: graphite`"

																			type: "object"
																		}
																		match: {
																			description: "Match is used together with Labels for `action: graphite`"

																			type: "string"
																		}
																		modulus: {
																			description: "Modulus to take of the hash of the source label values."

																			format: "int64"
																			type:   "integer"
																		}
																		regex: {
																			description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

																			type: "string"
																		}
																		replacement: {
																			description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

																			type: "string"
																		}
																		separator: {
																			description: "Separator placed between concatenated source label values. default is ';'."

																			type: "string"
																		}
																		source_labels: {
																			description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																			items: type: "string"
																			type: "array"
																		}
																		sourceLabels: {
																			description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

																			items: type: "string"
																			type: "array"
																		}
																		target_label: {
																			description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																			type: "string"
																		}
																		targetLabel: {
																			description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

																			type: "string"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															outputs: {
																description: """
		Outputs is a list of output aggregate functions to produce.
		 The following names are allowed:
		 - total - aggregates input counters - increase - counts the increase over input counters - count_series - counts the input series - count_samples - counts the input samples - sum_samples - sums the input samples - last - the last biggest sample value - min - the minimum sample value - max - the maximum sample value - avg - the average value across all the samples - stddev - standard deviation across all the samples - stdvar - standard variance across all the samples - histogram_bucket - creates VictoriaMetrics histogram for input samples - quantiles(phi1, ..., phiN) - quantiles' estimation for phi in the range [0..1]
		 The output time series will have the following names:
		 input_name:aggr_<interval>_<output>
		"""

																items: type: "string"
																type: "array"
															}
															without: {
																description: """
		Without is an optional list of labels, which must be excluded when grouping input series.
		 See also By.
		 If neither By nor Without are set, then the Outputs are calculated individually per each input time series.
		"""

																items: type: "string"
																type: "array"
															}
														}
														required: [
															"interval",
															"outputs",
														]
														type: "object"
													}
													type: "array"
												}
											}
											required: [
												"rules",
											]
											type: "object"
										}
										tlsConfig: {
											description: "TLSConfig describes tls configuration for remote write target"

											properties: {
												ca: {
													description: "Stuct containing the CA cert to use for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the container to use for the targets."

													type: "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the container for the targets."

													type: "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the container for the targets."

													type: "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										url: {
											description: "URL of the endpoint to send samples to."
											type:        "string"
										}
										urlRelabelConfig: {
											description: "ConfigMap with relabeling config which is applied to metrics before sending them to the corresponding -remoteWrite.url"

											properties: {
												key: {
													description: "The key to select."
													type:        "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the ConfigMap or its key must be defined"

													type: "boolean"
												}
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
									}
									required: [
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							remoteWriteSettings: {
								description: "RemoteWriteSettings defines global settings for all remoteWrite urls."

								properties: {
									flushInterval: {
										description: "Interval for flushing the data to remote storage. (default 1s)"

										pattern: "[0-9]+(ms|s|m|h)"
										type:    "string"
									}
									label: {
										additionalProperties: type: "string"
										description: "Optional labels in the form 'name=value' to add to all the metrics before sending them"

										type: "object"
									}
									maxBlockSize: {
										description: "The maximum size in bytes of unpacked request to send to remote storage"

										format: "int32"
										type:   "integer"
									}
									maxDiskUsagePerURL: {
										description: "The maximum file-based buffer size in bytes at -remoteWrite.tmpDataPath"
										format:      "int64"
										type:        "integer"
									}
									queues: {
										description: "The number of concurrent queues"
										format:      "int32"
										type:        "integer"
									}
									showURL: {
										description: "Whether to show -remoteWrite.url in the exported metrics. It is hidden by default, since it can contain sensitive auth info"

										type: "boolean"
									}
									tmpDataPath: {
										description: "Path to directory where temporary data for remote write component is stored (default vmagent-remotewrite-data)"

										type: "string"
									}
									useMultiTenantMode: {
										description: "Configures vmagent in multi-tenant mode with direct cluster support docs https://docs.victoriametrics.com/vmagent.html#multitenancy it's global setting and affects all remote storage configurations"

										type: "boolean"
									}
								}
								type: "object"
							}
							replicaCount: {
								description: "ReplicaCount is the expected size of the VMAgent cluster. The controller will eventually make the size of the running cluster equal to the expected size. NOTE enable VMSingle deduplication for replica usage"

								format: "int32"
								type:   "integer"
							}
							resources: {
								description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ if not specified - default setting will be used"

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

										type: "object"
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

										type: "object"
									}
								}
								type: "object"
							}
							rollingUpdate: {
								description: "RollingUpdate - overrides deployment update params."
								properties: {
									maxSurge: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods."

										"x-kubernetes-int-or-string": true
									}
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods."

										"x-kubernetes-int-or-string": true
									}
								}
								type: "object"
							}
							runtimeClassName: {
								description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

								type: "string"
							}
							schedulerName: {
								description: "SchedulerName - defines kubernetes scheduler name"
								type:        "string"
							}
							scrapeInterval: {
								description: "ScrapeInterval defines how often scrape targets by default"
								pattern:     "[0-9]+(ms|s|m|h)"
								type:        "string"
							}
							scrapeTimeout: {
								description: "ScrapeTimeout defines global timeout for targets scrape"
								pattern:     "[0-9]+(ms|s|m|h)"
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the vmagent object, which shall be mounted into the vmagent Pods. will be mounted at path /etc/vm/secrets"

								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							selectAllByDefault: {
								description: "SelectAllByDefault changes default behavior for empty CRD selectors, such ServiceScrapeSelector. with selectAllScrapes: true and empty serviceScrapeSelector and ServiceScrapeNamespaceSelector Operator selects all exist serviceScrapes with selectAllScrapes: false - selects nothing"

								type: "boolean"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the VMAgent Pods."

								type: "string"
							}
							serviceScrapeNamespaceSelector: {
								description: "ServiceScrapeNamespaceSelector Namespaces to be selected for VMServiceScrape discovery. Works in combination with Selector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							serviceScrapeRelabelTemplate: {
								description: "ServiceScrapeRelabelTemplate defines relabel config, that will be added to each VMServiceScrape. it's useful for adding specific labels to all targets"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							serviceScrapeSelector: {
								description: "ServiceScrapeSelector defines ServiceScrapes to be selected for target discovery. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							serviceScrapeSpec: {
								description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

								required: [
									"endpoints",
								]
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceSpec: {
								description: "ServiceSpec that will be added to vmagent service spec"
								properties: {
									metadata: {
										description: "EmbeddedObjectMetadata defines objectMeta for additional service."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: [
									"spec",
								]
								type: "object"
							}
							shardCount: {
								description: "ShardCount - numbers of shards of VMAgent in this case operator will use 1 deployment/sts per shard with replicas count according to spec.replicas https://victoriametrics.github.io/vmagent.html#scraping-big-number-of-targets"

								type: "integer"
							}
							startupProbe: {
								description:                            "StartupProbe that will be added to CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							statefulMode: {
								description: "StatefulMode enables StatefulSet for `VMAgent` instead of Deployment it allows using persistent storage for vmagent's persistentQueue"

								type: "boolean"
							}
							statefulRollingUpdateStrategy: {
								description: "StatefulRollingUpdateStrategy allows configuration for strategyType set it to RollingUpdate for disabling operator statefulSet rollingUpdate"

								type: "string"
							}
							statefulStorage: {
								description: "StatefulStorage configures storage for StatefulSet"
								properties: {
									disableMountSubPath: {
										description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."

										type: "boolean"
									}
									emptyDir: {
										description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"

										properties: {
											medium: {
												description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

												type: "string"
											}
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"

												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "A PVC spec to be used by the VMAlertManager StatefulSets."
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

												type: "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

												type: "string"
											}
											metadata: {
												description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."

												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

														type: "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

														type: "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

																type: "string"
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
														description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																type: "string"
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

																type: "object"
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

																type: "object"
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

																			type: "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																			type: "string"
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

																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: {
														description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

														type: "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

														type: "string"
													}
													volumeName: {
														description: "volumeName is the binding reference to the PersistentVolume backing this claim."

														type: "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

												properties: {
													accessModes: {
														description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

														items: type: "string"
														type: "array"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "capacity represents the actual resources of the underlying volume."

														type: "object"
													}
													conditions: {
														description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"

															properties: {
																lastProbeTime: {
																	description: "lastProbeTime is the time we probed the condition."

																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	description: "lastTransitionTime is the time the condition transitioned from one status to another."

																	format: "date-time"
																	type:   "string"
																}
																message: {
																	description: "message is the human-readable message indicating details about last transition."

																	type: "string"
																}
																reason: {
																	description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																	type: "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																	type: "string"
																}
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													phase: {
														description: "phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
													resizeStatus: {
														description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

														type: "string"
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
							staticScrapeNamespaceSelector: {
								description: "StaticScrapeNamespaceSelector defines Namespaces to be selected for VMStaticScrape discovery. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							staticScrapeRelabelTemplate: {
								description: "StaticScrapeRelabelTemplate defines relabel config, that will be added to each VMStaticScrape. it's useful for adding specific labels to all targets"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							staticScrapeSelector: {
								description: "StaticScrapeSelector defines PodScrapes to be selected for target discovery. Works in combination with NamespaceSelector. If both nil - match everything. NamespaceSelector nil - only objects at VMAgent namespace. Selector nil - only objects at NamespaceSelector namespaces."

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							terminationGracePeriodSeconds: {
								description: "TerminationGracePeriodSeconds period for container graceful termination"

								format: "int64"
								type:   "integer"
							}
							tolerations: {
								description: "Tolerations If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

											type: "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

											type: "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

											type: "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

											format: "int64"
											type:   "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							updateStrategy: {
								description: "UpdateStrategy - overrides default update strategy. works only for deployments, statefulset always use OnDelete."

								enum: [
									"Recreate",
									"RollingUpdate",
								]
								type: "string"
							}
							vmAgentExternalLabelName: {
								description: "VMAgentExternalLabelName Name of vmAgent external label used to denote vmAgent instance name. Defaults to the value of `prometheus`. External label will _not_ be added when value is set to empty string (`\"\"`)."

								type: "string"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output deploy definition. VolumeMounts specified will be appended to other VolumeMounts in the vmagent container, that are generated as a result of StorageSpec objects."

								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."

									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

											type: "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

											type: "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

											type: "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

											type: "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

											type: "string"
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
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output deploy definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

									required: [
										"name",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
						}
						type: "object"
					}
					status: {
						description: "VmAgentStatus defines the observed state of VmAgent"
						properties: {
							availableReplicas: {
								description: "AvailableReplicas Total number of available pods (ready for at least minReadySeconds) targeted by this VMAlert cluster."

								format: "int32"
								type:   "integer"
							}
							replicas: {
								description: "ReplicaCount Total number of pods targeted by this VMAgent"
								format:      "int32"
								type:        "integer"
							}
							selector: {
								description: "Selector string form of label value set for autoscaling"
								type:        "string"
							}
							shards: {
								description: "Shards represents total number of vmagent deployments with uniq scrape targets"

								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								description: "UnavailableReplicas Total number of unavailable pods targeted by this VMAgent cluster."

								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								description: "UpdatedReplicas Total number of non-terminated pods targeted by this VMAgent cluster that have the desired version spec."

								format: "int32"
								type:   "integer"
							}
						}
						required: [
							"availableReplicas",
							"replicas",
							"selector",
							"shards",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: {
				scale: {
					labelSelectorPath:  ".status.selector"
					specReplicasPath:   ".spec.shardCount"
					statusReplicasPath: ".status.shards"
				}
				status: {}
			}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.10.0"
		name: "vmalertmanagerconfigs.operator.victoriametrics.com"
	}
	spec: {
		group: "operator.victoriametrics.com"
		names: {
			kind:     "VMAlertmanagerConfig"
			listKind: "VMAlertmanagerConfigList"
			plural:   "vmalertmanagerconfigs"
			singular: "vmalertmanagerconfig"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "VMAlertmanagerConfig is the Schema for the vmalertmanagerconfigs API"

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
						description: "VMAlertmanagerConfigSpec defines configuration for VMAlertmanagerConfig"
						properties: {
							"-": type: "string"
							inhibit_rules: {
								description: "InhibitRules will only apply for alerts matching the resource's namespace."

								items: {
									description: "InhibitRule defines an inhibition rule that allows to mute alerts when other alerts are already firing. Note, it doesn't support deprecated alertmanager config options. See https://prometheus.io/docs/alerting/latest/configuration/#inhibit_rule"

									properties: {
										equal: {
											description: "Labels that must have an equal value in the source and target alert for the inhibition to take effect."

											items: type: "string"
											type: "array"
										}
										source_matchers: {
											description: "SourceMatchers defines a list of matchers for which one or more alerts have to exist for the inhibition to take effect."

											items: type: "string"
											type: "array"
										}
										target_matchers: {
											description: "TargetMatchers defines a list of matchers that have to be fulfilled by the target alerts to be muted."

											items: type: "string"
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							mute_time_intervals: {
								description: "MuteTimeInterval - global mute time See https://prometheus.io/docs/alerting/latest/configuration/#mute_time_interval"
								items: {
									description: "MuteTimeInterval for alerts"
									properties: {
										name: {
											description: "Name of interval"
											type:        "string"
										}
										time_intervals: {
											description: "TimeIntervals interval configuration"
											items: {
												description: "TimeInterval defines intervals of time"
												properties: {
													days_of_month: {
														description: "DayOfMonth defines list of numerical days in the month. Days begin at 1. Negative values are also accepted. for example, ['1:5', '-3:-1']"

														items: type: "string"
														type: "array"
													}
													location: {
														description: "Location in golang time location form, e.g. UTC"

														type: "string"
													}
													months: {
														description: "Months  defines list of calendar months identified by a case-insentive name (e.g. ‘January’) or numeric 1. For example, ['1:3', 'may:august', 'december']"

														items: type: "string"
														type: "array"
													}
													times: {
														description: "Times defines time range for mute"
														items: {
															description: "TimeRange  ranges inclusive of the starting time and exclusive of the end time"

															properties: {
																end_time: {
																	description: "EndTime for example HH:MM"
																	type:        "string"
																}
																start_time: {
																	description: "StartTime for example  HH:MM"
																	type:        "string"
																}
															}
															required: [
																"end_time",
																"start_time",
															]
															type: "object"
														}
														type: "array"
													}
													weekdays: {
														description: "Weekdays defines list of days of the week, where the week begins on Sunday and ends on Saturday."

														items: type: "string"
														type: "array"
													}
													years: {
														description: "Years defines numerical list of years, ranges are accepted. For example, ['2020:2022', '2030']"

														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: ["time_intervals"]
									type: "object"
								}
								type: "array"
							}
							receivers: {
								description: "Receivers defines alert receivers. without defined Route, receivers will be skipped."

								items: {
									description: "Receiver defines one or more notification integrations."
									properties: {
										email_configs: {
											description: "EmailConfigs defines email notification configurations."
											items: {
												description: "EmailConfig configures notifications via Email."
												properties: {
													auth_identity: {
														description: "The identity to use for authentication."
														type:        "string"
													}
													auth_password: {
														description: "AuthPassword defines secret name and key at CRD namespace."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													auth_secret: {
														description: "AuthSecret defines secrent name and key at CRD namespace. It must contain the CRAM-MD5 secret."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													auth_username: {
														description: "The username to use for authentication."
														type:        "string"
													}
													from: {
														description: "The sender address."
														type:        "string"
													}
													headers: {
														additionalProperties: type: "string"
														description: "Further headers email header key/value pairs. Overrides any headers previously set by the notification implementation."

														type: "object"
													}
													hello: {
														description: "The hostname to identify to the SMTP server."
														type:        "string"
													}
													html: {
														description: "The HTML body of the email notification."
														type:        "string"
													}
													require_tls: {
														description: "The SMTP TLS requirement. Note that Go does not support unencrypted connections to remote SMTP endpoints."

														type: "boolean"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													smarthost: {
														description: "The SMTP host through which emails are sent."
														type:        "string"
													}
													text: {
														description: "The text body of the email notification."
														type:        "string"
													}
													tls_config: {
														description: "TLS configuration"
														properties: {
															ca: {
																description: "Stuct containing the CA cert to use for the targets."

																properties: {
																	configMap: {
																		description: "ConfigMap containing data to use for the targets."

																		properties: {
																			key: {
																				description: "The key to select."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the ConfigMap or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		description: "Secret containing data to use for the targets."

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															caFile: {
																description: "Path to the CA cert in the container to use for the targets."

																type: "string"
															}
															cert: {
																description: "Struct containing the client cert file for the targets."

																properties: {
																	configMap: {
																		description: "ConfigMap containing data to use for the targets."

																		properties: {
																			key: {
																				description: "The key to select."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the ConfigMap or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		description: "Secret containing data to use for the targets."

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															certFile: {
																description: "Path to the client cert file in the container for the targets."

																type: "string"
															}
															insecureSkipVerify: {
																description: "Disable target certificate validation."
																type:        "boolean"
															}
															keyFile: {
																description: "Path to the client key file in the container for the targets."

																type: "string"
															}
															keySecret: {
																description: "Secret containing the client key file for the targets."

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serverName: {
																description: "Used to verify the hostname for the targets."
																type:        "string"
															}
														}
														type: "object"
													}
													to: {
														description: "The email address to send notifications to."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										name: {
											description: "Name of the receiver. Must be unique across all items from the list."

											minLength: 1
											type:      "string"
										}
										opsgenie_configs: {
											description: "OpsGenieConfigs defines ops genie notification configurations."

											items: {
												description: "OpsGenieConfig configures notifications via OpsGenie. See https://prometheus.io/docs/alerting/latest/configuration/#opsgenie_config"

												properties: {
													api_key: {
														description: "The secret's key that contains the OpsGenie API key. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													apiURL: {
														description: "The URL to send OpsGenie API requests to."
														type:        "string"
													}
													description: {
														description: "Description of the incident."
														type:        "string"
													}
													details: {
														additionalProperties: type: "string"
														description: "A set of arbitrary key/value pairs that provide further detail about the incident."

														type: "object"
													}
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													message: {
														description: "Alert text limited to 130 characters."
														type:        "string"
													}
													note: {
														description: "Additional alert note."
														type:        "string"
													}
													priority: {
														description: "Priority level of alert. Possible values are P1, P2, P3, P4, and P5."

														type: "string"
													}
													responders: {
														description: "List of responders responsible for notifications."
														items: {
															description: "OpsGenieConfigResponder defines a responder to an incident. One of `id`, `name` or `username` has to be defined."

															properties: {
																id: {
																	description: "ID of the responder."
																	type:        "string"
																}
																name: {
																	description: "Name of the responder."
																	type:        "string"
																}
																type: {
																	description: "Type of responder."
																	minLength:   1
																	type:        "string"
																}
																username: {
																	description: "Username of the responder."
																	type:        "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														type: "array"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													source: {
														description: "Backlink to the sender of the notification."
														type:        "string"
													}
													tags: {
														description: "Comma separated list of tags attached to the notifications."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										pagerduty_configs: {
											description: "PagerDutyConfigs defines pager duty notification configurations."

											items: {
												description: "PagerDutyConfig configures notifications via PagerDuty. See https://prometheus.io/docs/alerting/latest/configuration/#pagerduty_config"

												properties: {
													class: {
														description: "The class/type of the event."
														type:        "string"
													}
													client: {
														description: "Client identification."
														type:        "string"
													}
													client_url: {
														description: "Backlink to the sender of notification."
														type:        "string"
													}
													component: {
														description: "The part or component of the affected system that is broken."

														type: "string"
													}
													description: {
														description: "Description of the incident."
														type:        "string"
													}
													details: {
														additionalProperties: type: "string"
														description: "Arbitrary key/value pairs that provide further detail about the incident."

														type: "object"
													}
													group: {
														description: "A cluster or grouping of sources."
														type:        "string"
													}
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													images: {
														description: "Images to attach to the incident."
														items: {
															description: "ImageConfig is used to attach images to the incident. See https://developer.pagerduty.com/docs/ZG9jOjExMDI5NTgx-send-an-alert-event#the-images-property for more information."

															properties: {
																alt: type:    "string"
																href: type:   "string"
																source: type: "string"
															}
															required: ["source"]
															type: "object"
														}
														type: "array"
													}
													links: {
														description: "Links to attach to the incident."
														items: {
															description: "LinkConfig is used to attach text links to the incident. See https://developer.pagerduty.com/docs/ZG9jOjExMDI5NTgx-send-an-alert-event#the-links-property for more information."

															properties: {
																href: type: "string"
																text: type: "string"
															}
															required: ["href"]
															type: "object"
														}
														type: "array"
													}
													routing_key: {
														description: "The secret's key that contains the PagerDuty integration key (when using Events API v2). Either this field or `serviceKey` needs to be defined. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													service_key: {
														description: "The secret's key that contains the PagerDuty service key (when using integration type \"Prometheus\"). Either this field or `routingKey` needs to be defined. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													severity: {
														description: "Severity of the incident."
														type:        "string"
													}
													url: {
														description: "The URL to send requests to."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										pushover_configs: {
											description: "PushoverConfigs defines push over notification configurations."

											items: {
												description: "PushoverConfig configures notifications via Pushover. See https://prometheus.io/docs/alerting/latest/configuration/#pushover_config"

												properties: {
													expire: {
														description: "How long your notification will continue to be retried for, unless the user acknowledges the notification."

														type: "string"
													}
													html: {
														description: "Whether notification message is HTML or plain text."

														type: "boolean"
													}
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													message: {
														description: "Notification message."
														type:        "string"
													}
													priority: {
														description: "Priority, see https://pushover.net/api#priority"
														type:        "string"
													}
													retry: {
														description: "How often the Pushover servers will send the same notification to the user. Must be at least 30 seconds."

														type: "string"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													sound: {
														description: "The name of one of the sounds supported by device clients to override the user's default sound choice"

														type: "string"
													}
													title: {
														description: "Notification title."
														type:        "string"
													}
													token: {
														description: "The secret's key that contains the registered application’s API token, see https://pushover.net/apps. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													url: {
														description: "A supplementary URL shown alongside the message."
														type:        "string"
													}
													url_title: {
														description: "A title for supplementary URL, otherwise just the URL is shown"

														type: "string"
													}
													user_key: {
														description: "The secret's key that contains the recipient user’s user key. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
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
										slack_configs: {
											description: "SlackConfigs defines slack notification configurations."
											items: {
												description: "SlackConfig configures notifications via Slack. See https://prometheus.io/docs/alerting/latest/configuration/#slack_config"

												properties: {
													actions: {
														description: "A list of Slack actions that are sent with each notification."

														items: {
															description: "SlackAction configures a single Slack action that is sent with each notification. See https://api.slack.com/docs/message-attachments#action_fields and https://api.slack.com/docs/message-buttons for more information."

															properties: {
																confirm: {
																	description: "SlackConfirmationField protect users from destructive actions or particularly distinguished decisions by asking them to confirm their button click one more time. See https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields for more information."

																	properties: {
																		dismiss_text: type: "string"
																		ok_text: type:      "string"
																		text: {
																			minLength: 1
																			type:      "string"
																		}
																		title: type: "string"
																	}
																	required: ["text"]
																	type: "object"
																}
																name: type:  "string"
																style: type: "string"
																text: {
																	minLength: 1
																	type:      "string"
																}
																type: {
																	minLength: 1
																	type:      "string"
																}
																url: type:   "string"
																value: type: "string"
															}
															required: [
																"text",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													api_url: {
														description: "The secret's key that contains the Slack webhook URL. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													callback_id: type: "string"
													channel: {
														description: "The channel or user to send notifications to."

														type: "string"
													}
													color: type:    "string"
													fallback: type: "string"
													fields: {
														description: "A list of Slack fields that are sent with each notification."

														items: {
															description: "See https://api.slack.com/docs/message-attachments#fields for more information."

															properties: {
																short: type: "boolean"
																title: {
																	minLength: 1
																	type:      "string"
																}
																value: {
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"title",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													footer: type: "string"
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													icon_emoji: type: "string"
													icon_url: type:   "string"
													image_url: type:  "string"
													link_names: type: "boolean"
													mrkdwn_in: {
														items: type: "string"
														type: "array"
													}
													pretext: type: "string"
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													short_fields: type: "boolean"
													text: type:         "string"
													thumb_url: type:    "string"
													title: type:        "string"
													title_link: type:   "string"
													username: type:     "string"
												}
												type: "object"
											}
											type: "array"
										}
										telegram_configs: {
											items: {
												properties: {
													api_url: {
														description: "APIUrl the Telegram API URL i.e. https://api.telegram.org."
														type:        "string"
													}
													bot_token: {
														description: "BotToken token for the bot https://core.telegram.org/bots/api"
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													chat_id: {
														description: "ChatID is ID of the chat where to send the messages."

														type: "integer"
													}
													disable_notifications: {
														description: "DisableNotifications"
														type:        "boolean"
													}
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													message: {
														description: "Message is templated message"
														type:        "string"
													}
													parse_mode: {
														description: "ParseMode for telegram message, supported values are MarkdownV2, Markdown, Markdown and empty string for plain text."

														type: "string"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
												}
												required: [
													"bot_token",
													"chat_id",
												]
												type: "object"
											}
											type: "array"
										}
										victorops_configs: {
											description: "VictorOpsConfigs defines victor ops notification configurations."

											items: {
												description: "VictorOpsConfig configures notifications via VictorOps. See https://prometheus.io/docs/alerting/latest/configuration/#victorops_config"

												properties: {
													api_key: {
														description: "The secret's key that contains the API key to use when talking to the VictorOps API. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													api_url: {
														description: "The VictorOps API URL."
														type:        "string"
													}
													custom_fields: {
														additionalProperties: type: "string"
														description: "Adds optional custom fields https://github.com/prometheus/alertmanager/blob/v0.24.0/config/notifiers.go#L537"
														type:        "object"
													}
													entity_display_name: {
														description: "Contains summary of the alerted problem."
														type:        "string"
													}
													http_config: {
														description: "The HTTP client's configuration."
														properties: {
															basic_auth: {
																description: "TODO oAuth2 support BasicAuth for the client."

																properties: {
																	password: {
																		description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	password_file: {
																		description: "PasswordFile defines path to password file at disk"

																		type: "string"
																	}
																	username: {
																		description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearer_token_file: {
																description: "BearerTokenFile defines filename for bearer token, it must be mounted to pod."

																type: "string"
															}
															bearer_token_secret: {
																description: "The secret's key that contains the bearer token It must be at them same namespace as CRD"

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tls_config: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Stuct containing the CA cert to use for the targets."

																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."

																						type: "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	caFile: {
																		description: "Path to the CA cert in the container to use for the targets."

																		type: "string"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."

																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."

																						type: "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	certFile: {
																		description: "Path to the client cert file in the container for the targets."

																		type: "string"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keyFile: {
																		description: "Path to the client key file in the container for the targets."

																		type: "string"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."

																		type: "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													message_type: {
														description: "Describes the behavior of the alert (CRITICAL, WARNING, INFO)."

														type: "string"
													}
													monitoring_tool: {
														description: "The monitoring tool the state message is from."

														type: "string"
													}
													routing_key: {
														description: "A key used to map the alert to a team."
														type:        "string"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													state_message: {
														description: "Contains long explanation of the alerted problem."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										webhook_configs: {
											description: "WebhookConfigs defines webhook notification configurations."
											items: {
												description: "WebhookConfig configures notifications via a generic receiver supporting the webhook payload. See https://prometheus.io/docs/alerting/latest/configuration/#webhook_config"

												properties: {
													http_config: {
														description:                            "HTTP client configuration."
														type:                                   "object"
														"x-kubernetes-preserve-unknown-fields": true
													}
													max_alerts: {
														description: "Maximum number of alerts to be sent per webhook message. When 0, all alerts are included."

														format:  "int32"
														minimum: 0
														type:    "integer"
													}
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													url: {
														description: "URL to send requests to, one of `urlSecret` and `url` must be defined."

														type: "string"
													}
													url_secret: {
														description: "URLSecret defines secret name and key at the CRD namespace. It must contain the webhook URL. one of `urlSecret` and `url` must be defined."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
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
										wechat_configs: {
											description: "WeChatConfigs defines wechat notification configurations."
											items: {
												description: "WeChatConfig configures notifications via WeChat. See https://prometheus.io/docs/alerting/latest/configuration/#wechat_config"

												properties: {
													agent_id: type: "string"
													api_secret: {
														description: "The secret's key that contains the WeChat API key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													api_url: {
														description: "The WeChat API URL."
														type:        "string"
													}
													corp_id: {
														description: "The corp id for authentication."
														type:        "string"
													}
													http_config: {
														description: "HTTP client configuration."
														properties: {
															basic_auth: {
																description: "TODO oAuth2 support BasicAuth for the client."

																properties: {
																	password: {
																		description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	password_file: {
																		description: "PasswordFile defines path to password file at disk"

																		type: "string"
																	}
																	username: {
																		description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearer_token_file: {
																description: "BearerTokenFile defines filename for bearer token, it must be mounted to pod."

																type: "string"
															}
															bearer_token_secret: {
																description: "The secret's key that contains the bearer token It must be at them same namespace as CRD"

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tls_config: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Stuct containing the CA cert to use for the targets."

																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."

																						type: "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	caFile: {
																		description: "Path to the CA cert in the container to use for the targets."

																		type: "string"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."

																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."

																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."

																						type: "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																						type: "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"

																						type: "boolean"
																					}
																				}
																				required: ["key"]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	certFile: {
																		description: "Path to the client cert file in the container for the targets."

																		type: "string"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keyFile: {
																		description: "Path to the client key file in the container for the targets."

																		type: "string"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."

																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."

																				type: "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																				type: "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"

																				type: "boolean"
																			}
																		}
																		required: ["key"]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."

																		type: "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: {
														description: "API request data as defined by the WeChat API."

														type: "string"
													}
													message_type: type: "string"
													send_resolved: {
														description: "SendResolved controls notify about resolved alerts."

														type: "boolean"
													}
													to_party: type: "string"
													to_tag: type:   "string"
													to_user: type:  "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							route: {
								description: "Route definition for alertmanager, may include nested routes."

								properties: {
									active_time_intervals: {
										description: "ActiveTimeIntervals Times when the route should be active These must match the name at time_intervals"

										items: type: "string"
										type: "array"
									}
									continue: {
										description: "Continue indicating whether an alert should continue matching subsequent sibling nodes. It will always be true for the first-level route if disableRouteContinueEnforce for vmalertmanager not set."

										type: "boolean"
									}
									group_by: {
										description: "List of labels to group by."
										items: type: "string"
										type: "array"
									}
									group_interval: {
										description: "How long to wait before sending an updated notification."
										pattern:     "[0-9]+(ms|s|m|h)"
										type:        "string"
									}
									group_wait: {
										description: "How long to wait before sending the initial notification."
										pattern:     "[0-9]+(ms|s|m|h)"
										type:        "string"
									}
									matchers: {
										description: "List of matchers that the alert’s labels should match. For the first level route, the operator adds a namespace: \"CRD_NS\" matcher. https://prometheus.io/docs/alerting/latest/configuration/#matcher"

										items: type: "string"
										type: "array"
									}
									mute_time_intervals: {
										description: "MuteTimeIntervals for alerts"
										items: type: "string"
										type: "array"
									}
									receiver: {
										description: "Name of the receiver for this route."
										type:        "string"
									}
									repeat_interval: {
										description: "How long to wait before repeating the last notification."
										pattern:     "[0-9]+(ms|s|m|h)"
										type:        "string"
									}
									routes: {
										description: "Child routes. https://prometheus.io/docs/alerting/latest/configuration/#route"
										items: "x-kubernetes-preserve-unknown-fields": true
										type: "array"
									}
								}
								required: ["receiver"]
								type: "object"
							}
							time_intervals: {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server TimeIntervals modern config option, use it instead of  mute_time_intervals"

								items: {
									description: "MuteTimeInterval for alerts"
									properties: {
										name: {
											description: "Name of interval"
											type:        "string"
										}
										time_intervals: {
											description: "TimeIntervals interval configuration"
											items: {
												description: "TimeInterval defines intervals of time"
												properties: {
													days_of_month: {
														description: "DayOfMonth defines list of numerical days in the month. Days begin at 1. Negative values are also accepted. for example, ['1:5', '-3:-1']"

														items: type: "string"
														type: "array"
													}
													location: {
														description: "Location in golang time location form, e.g. UTC"

														type: "string"
													}
													months: {
														description: "Months  defines list of calendar months identified by a case-insentive name (e.g. ‘January’) or numeric 1. For example, ['1:3', 'may:august', 'december']"

														items: type: "string"
														type: "array"
													}
													times: {
														description: "Times defines time range for mute"
														items: {
															description: "TimeRange  ranges inclusive of the starting time and exclusive of the end time"

															properties: {
																end_time: {
																	description: "EndTime for example HH:MM"
																	type:        "string"
																}
																start_time: {
																	description: "StartTime for example  HH:MM"
																	type:        "string"
																}
															}
															required: [
																"end_time",
																"start_time",
															]
															type: "object"
														}
														type: "array"
													}
													weekdays: {
														description: "Weekdays defines list of days of the week, where the week begins on Sunday and ends on Saturday."

														items: type: "string"
														type: "array"
													}
													years: {
														description: "Years defines numerical list of years, ranges are accepted. For example, ['2020:2022', '2030']"

														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: ["time_intervals"]
									type: "object"
								}
								type: "array"
							}
						}, type:
							"object"
					}, status: {
						description:
							"VMAlertmanagerConfigStatus defines the observed state of VMAlertmanagerConfig"
						properties: reason: {
							description: "ErrorReason describes validation or any other errors."
							type:        "string"
						}, type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmalertmanagers.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
			kind: "VMAlertmanager"
			listKind:
				"VMAlertmanagerList", plural: "vmalertmanagers"
			shortNames: ["vma"]
				singular:
					"vmalertmanager"
		}, scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description:
					"The version of VMAlertmanager", jsonPath:
					".spec.version", name: "Version"
				type: "string"
			}, {
				description:
					"The desired replicas number of Alertmanagers", jsonPath:
					".spec.ReplicaCount", name: "ReplicaCount"
				type: "integer"
			}, {
				jsonPath:
					".metadata.creationTimestamp", name: "Age"
				type: "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMAlertmanager represents Victoria-Metrics deployment for Alertmanager.", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"Specification of the desired behavior of the VMAlertmanager cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {

							"-": {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server"

								type: "string"
							}
							additionalPeers: {
								description: "AdditionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster."

								items: type: "string"
								type: "array"
							}
							affinity: {
								description:                            "Affinity If specified, the pod's scheduling constraints."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							claimTemplates: {
								description: "ClaimTemplates allows adding additional VolumeClaimTemplates for StatefulSet"

								items: {
									description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"

									properties: {
										apiVersion: {
											description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

											type: "string"
										}
										kind: {
											description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

											type: "string"
										}
										metadata: {
											description:                            "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										spec: {
											description: "spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

															type: "string"
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
													description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

													properties: {
														apiGroup: {
															description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

															type: "string"
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

															type: "object"
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

															type: "object"
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

																		type: "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																		type: "string"
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

															type: "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												storageClassName: {
													description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

													type: "string"
												}
												volumeMode: {
													description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

													type: "string"
												}
												volumeName: {
													description: "volumeName is the binding reference to the PersistentVolume backing this claim."

													type: "string"
												}
											}
											type: "object"
										}
										status: {
											description: "status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

											properties: {
												accessModes: {
													description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

													items: type: "string"
													type: "array"
												}
												allocatedResources: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

													type: "object"
												}
												capacity: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "capacity represents the actual resources of the underlying volume."

													type: "object"
												}
												conditions: {
													description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

													items: {
														description: "PersistentVolumeClaimCondition contails details about state of pvc"

														properties: {
															lastProbeTime: {
																description: "lastProbeTime is the time we probed the condition."

																format: "date-time"
																type:   "string"
															}
															lastTransitionTime: {
																description: "lastTransitionTime is the time the condition transitioned from one status to another."

																format: "date-time"
																type:   "string"
															}
															message: {
																description: "message is the human-readable message indicating details about last transition."

																type: "string"
															}
															reason: {
																description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																type: "string"
															}
															status: type: "string"
															type: {
																description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																type: "string"
															}
														}
														required: [
															"status",
															"type",
														]
														type: "object"
													}
													type: "array"
												}
												phase: {
													description: "phase represents the current phase of PersistentVolumeClaim."
													type:        "string"
												}
												resizeStatus: {
													description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

													type: "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							clusterAdvertiseAddress: {
								description: "ClusterAdvertiseAddress is the explicit address to advertise in cluster. Needs to be provided for non RFC1918 [1] (public) addresses. [1] RFC1918: https://tools.ietf.org/html/rfc1918"

								type: "string"
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMAlertmanager object, which shall be mounted into the VMAlertmanager Pods. The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>."

								items: type: "string"
								type: "array"
							}
							configNamespaceSelector: {
								description: "ConfigNamespaceSelector defines namespace selector for VMAlertmanagerConfig. Works in combination with Selector. NamespaceSelector nil - only objects at VMAlertmanager namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							configRawYaml: {
								description: "ConfigRawYaml - raw configuration for alertmanager, it helps it to start without secret. priority -> hardcoded ConfigRaw -> ConfigRaw, provided by user -> ConfigSecret."

								type: "string"
							}
							configSecret: {
								description: "ConfigSecret is the name of a Kubernetes Secret in the same namespace as the VMAlertmanager object, which contains configuration for this VMAlertmanager, configuration must be inside secret key: alertmanager.yaml. It must be created by user. instance. Defaults to 'vmalertmanager-<alertmanager-name>' The secret is mounted into /etc/alertmanager/config."

								type: "string"
							}
							configSelector: {
								description: "ConfigSelector defines selector for VMAlertmanagerConfig, result config will be merged with with Raw or Secret config. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAlertmanager namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							containers: {
								description: "Containers allows injecting additional containers or patching existing containers. This is meant to allow adding an authentication proxy to an VMAlertmanager pod."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							disableNamespaceMatcher: {
								description: "DisableNamespaceMatcher disables namespace label matcher for VMAlertmanagerConfig It may be useful if alert doesn't have namespace label for some reason"

								type: "boolean"
							}
							disableRouteContinueEnforce: {
								description: "DisableRouteContinueEnforce cancel the behavior for VMAlertmanagerConfig that always enforce first-level route continue to true"

								type: "boolean"
							}
							dnsConfig: {
								description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

								items: "x-kubernetes-preserve-unknown-fields": true
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
								description: "DNSPolicy sets DNS policy for the pod"
								type:        "string"
							}
							externalURL: {
								description: "ExternalURL the VMAlertmanager instances will be available under. This is necessary to generate correct URLs. This is necessary if VMAlertmanager is not served from root of a DNS name."

								type: "string"
							}
							extraArgs: {
								additionalProperties: type: "string"
								description: "ExtraArgs that will be passed to  VMAlertmanager pod for example log.level: debug"

								type: "object"
							}
							extraEnvs: {
								description: "ExtraEnvs that will be added to VMAlertmanager pod"
								items: {
									description: "EnvVar represents an environment variable present in a Container."

									properties: {
										name: {
											description: "Name of the environment variable. Must be a C_IDENTIFIER."
											type:        "string"
										}
										value: {
											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

											type: "string"
										}
									}
									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							hostNetwork: {
								description: "HostNetwork controls whether the pod may use the node network namespace"

								type: "boolean"
							}
							image: {
								description: "Image - docker image settings for VMAlertmanager if no specified operator uses default config version"

								properties: {
									pullPolicy: {
										description: "PullPolicy describes how to pull docker image"
										type:        "string"
									}
									repository: {
										description: "Repository contains name of docker image + it's repository if needed"

										type: "string"
									}
									tag: {
										description: "Tag contains desired docker image version"
										type:        "string"
									}
								}
								type: "object"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the VMAlertmanager configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							listenLocal: {
								description: "ListenLocal makes the VMAlertmanager server listen on loopback, so that it does not bind against the Pod IP. Note this is only for the VMAlertmanager UI, not the gossip communication."

								type: "boolean"
							}
							livenessProbe: {
								description:                            "LivenessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logFormat: {
								description: "LogFormat for VMAlertmanager to be configured with."
								type:        "string"
							}
							logLevel: {
								description: "Log level for VMAlertmanager to be configured with."
								type:        "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector Define which Nodes the Pods are scheduled on."

								type: "object"
							}
							paused: {
								description: "Paused If set to true all actions on the underlaying managed objects are not goint to be performed, except for delete actions."

								type: "boolean"
							}
							podDisruptionBudget: {
								description: "PodDisruptionBudget created by operator"
								properties: {
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

										"x-kubernetes-int-or-string": true
									}
									minAvailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

										"x-kubernetes-int-or-string": true
									}
									selectorLabels: {
										additionalProperties: type: "string"
										description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

										type: "object"
									}
								}
								type: "object"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the alertmanager pods."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							portName: {
								description: "PortName used for the pods and governing service. This defaults to web"

								type: "string"
							}
							priorityClassName: {
								description: "PriorityClassName class assigned to the Pods"
								type:        "string"
							}
							readinessGates: {
								description: "ReadinessGates defines pod readiness gates"
								items: {
									description: "PodReadinessGate contains the reference to a pod condition"
									properties: conditionType: {
										description: "ConditionType refers to a condition in the pod's condition list with matching type."

										type: "string"
									}
									required: ["conditionType"]
									type: "object"
								}
								type: "array"
							}
							readinessProbe: {
								description:                            "ReadinessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							replicaCount: {
								description: "ReplicaCount Size is the expected size of the alertmanager cluster. The controller will eventually make the size of the running cluster equal to the expected"

								format:  "int32"
								minimum: 1
								type:    "integer"
							}
							resources: {
								description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
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

										type: "object"
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

										type: "object"
									}
								}
								type: "object"
							}
							retention: {
								description: "Retention Time duration VMAlertmanager shall retain data for. Default is '120h', and must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours)."

								pattern: "[0-9]+(ms|s|m|h)"
								type:    "string"
							}
							rollingUpdateStrategy: {
								description: "RollingUpdateStrategy defines strategy for application updates Default is OnDelete, in this case operator handles update process Can be changed for RollingUpdate"

								type: "string"
							}
							routePrefix: {
								description: "RoutePrefix VMAlertmanager registers HTTP handlers for. This is useful, if using ExternalURL and a proxy is rewriting HTTP routes of a request, and the actual ExternalURL is still true, but the server serves requests under a different route prefix. For example for use with `kubectl proxy`."

								type: "string"
							}
							runtimeClassName: {
								description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

								type: "string"
							}
							schedulerName: {
								description: "SchedulerName - defines kubernetes scheduler name"
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the VMAlertmanager object, which shall be mounted into the VMAlertmanager Pods. The Secrets are mounted into /etc/vm/secrets/<secret-name>"

								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							selectAllByDefault: {
								description: "SelectAllByDefault changes default behavior for empty CRD selectors, such ConfigSelector. with selectAllScrapes: true and undefined ConfigSelector and ConfigNamespaceSelector Operator selects all exist alertManagerConfigs with selectAllScrapes: false - selects nothing"

								type: "boolean"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use"

								type: "string"
							}
							serviceScrapeSpec: {
								description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

								required: ["endpoints"]
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceSpec: {
								description: "ServiceSpec that will be added to vmalertmanager service spec"

								properties: {
									metadata: {
										description: "EmbeddedObjectMetadata defines objectMeta for additional service."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: ["spec"]
								type: "object"
							}
							startupProbe: {
								description:                            "StartupProbe that will be added to CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							storage: {
								description: "Storage is the definition of how storage will be used by the VMAlertmanager instances."

								properties: {
									disableMountSubPath: {
										description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."

										type: "boolean"
									}
									emptyDir: {
										description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"

										properties: {
											medium: {
												description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

												type: "string"
											}
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"

												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "A PVC spec to be used by the VMAlertManager StatefulSets."
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

												type: "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

												type: "string"
											}
											metadata: {
												description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."

												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

														type: "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

														type: "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

																type: "string"
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
														description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																type: "string"
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

																type: "object"
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

																type: "object"
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

																			type: "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																			type: "string"
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

																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: {
														description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

														type: "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

														type: "string"
													}
													volumeName: {
														description: "volumeName is the binding reference to the PersistentVolume backing this claim."

														type: "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

												properties: {
													accessModes: {
														description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

														items: type: "string"
														type: "array"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "capacity represents the actual resources of the underlying volume."

														type: "object"
													}
													conditions: {
														description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"

															properties: {
																lastProbeTime: {
																	description: "lastProbeTime is the time we probed the condition."

																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	description: "lastTransitionTime is the time the condition transitioned from one status to another."

																	format: "date-time"
																	type:   "string"
																}
																message: {
																	description: "message is the human-readable message indicating details about last transition."

																	type: "string"
																}
																reason: {
																	description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																	type: "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																	type: "string"
																}
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													phase: {
														description: "phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
													resizeStatus: {
														description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

														type: "string"
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
							templates: {
								description: "Templates is a list of ConfigMap key references for ConfigMaps in the same namespace as the VMAlertmanager object, which shall be mounted into the VMAlertmanager Pods. The Templates are mounted into /etc/vm/templates/<configmap-name>/<configmap-key>."

								items: {
									description: "ConfigMapKeyReference refers to a key in a ConfigMap."
									properties: {
										key: {
											description: "The ConfigMap key to refer to."
											type:        "string"
										}
										name: {
											description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

											type: "string"
										}
									}
									required: ["key"]
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							terminationGracePeriodSeconds: {
								description: "TerminationGracePeriodSeconds period for container graceful termination"

								format: "int64"
								type:   "integer"
							}
							tolerations: {
								description: "Tolerations If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

											type: "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

											type: "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

											type: "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

											format: "int64"
											type:   "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition. VolumeMounts specified will be appended to other VolumeMounts in the alertmanager container, that are generated as a result of StorageSpec objects."

								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."

									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

											type: "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

											type: "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

											type: "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

											type: "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

											type: "string"
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
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output StatefulSet definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
						}, type:
							"object"
					}, status: {
						description:
							"Most recent observed status of the VMAlertmanager cluster. Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {

							availableReplicas: {
								description: "AvailableReplicas Total number of available pods (ready for at least minReadySeconds) targeted by this VMAlertmanager cluster."

								format: "int32"
								type:   "integer"
							}
							paused: {
								description: "Paused Represents whether any actions on the underlaying managed objects are being performed. Only delete actions will be performed."

								type: "boolean"
							}
							replicas: {
								description: "ReplicaCount Total number of non-terminated pods targeted by this VMAlertmanager cluster (their labels match the selector)."

								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								description: "UnavailableReplicas Total number of unavailable pods targeted by this VMAlertmanager cluster."

								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								description: "UpdatedReplicas Total number of non-terminated pods targeted by this VMAlertmanager cluster that have the desired version spec."

								format: "int32"
								type:   "integer"
							}
						}, required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						], type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true, subresources: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmalerts.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMAlert"
				listKind:
					"VMAlertList", plural: "vmalerts"
				singular:
					"vmalert"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMAlert  executes a list of given alerting or recording rules against configured address."
				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMAlertSpec defines the desired state of VMAlert", properties: {

							"-": {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server"

								type: "string"
							}
							affinity: {
								description:                            "Affinity If specified, the pod's scheduling constraints."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMAlert object, which shall be mounted into the VMAlert Pods. The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>."

								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							datasource: {
								description: "Datasource Victoria Metrics or VMSelect url. Required parameter. e.g. http://127.0.0.1:8428"

								properties: {
									OAuth2: {
										description: "OAuth2 defines OAuth2 configuration"
										required: [
											"client_id",
											"token_url",
										]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"

										properties: {
											password: {
												description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											password_file: {
												description: "PasswordFile defines path to password file at disk"

												type: "string"
											}
											username: {
												description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerTokenFilePath: type: "string"
									bearerTokenSecret: {
										description: "Optional bearer auth token to use for -remoteWrite.url"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									headers: {
										description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName:headerValue vmalert supports it since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									tlsConfig: {
										description:                            "TLSConfig specifies TLSConfig configuration parameters."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									url: {
										description: "Victoria Metrics or VMSelect url. Required parameter. E.g. http://127.0.0.1:8428"

										type: "string"
									}
								}
								required: ["url"]
								type: "object"
							}
							dnsConfig: {
								description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

								items: "x-kubernetes-preserve-unknown-fields": true
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
								description: "DNSPolicy sets DNS policy for the pod"
								type:        "string"
							}
							enforcedNamespaceLabel: {
								description: "EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created."

								type: "string"
							}
							evaluationInterval: {
								description: "EvaluationInterval how often evalute rules by default"
								pattern:     "[0-9]+(ms|s|m|h)"
								type:        "string"
							}
							externalLabels: {
								additionalProperties: type: "string"
								description: "ExternalLabels in the form 'name: value' to add to all generated recording rules and alerts."

								type: "object"
							}
							extraArgs: {
								additionalProperties: type: "string"
								description: "ExtraArgs that will be passed to  VMAlert pod for example -remoteWrite.tmpDataPath=/tmp"

								type: "object"
							}
							extraEnvs: {
								description: "ExtraEnvs that will be added to VMAlert pod"
								items: {
									description: "EnvVar represents an environment variable present in a Container."

									properties: {
										name: {
											description: "Name of the environment variable. Must be a C_IDENTIFIER."
											type:        "string"
										}
										value: {
											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

											type: "string"
										}
									}
									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							hostNetwork: {
								description: "HostNetwork controls whether the pod may use the node network namespace"

								type: "boolean"
							}
							image: {
								description: "Image - docker image settings for VMAlert if no specified operator uses default config version"

								properties: {
									pullPolicy: {
										description: "PullPolicy describes how to pull docker image"
										type:        "string"
									}
									repository: {
										description: "Repository contains name of docker image + it's repository if needed"

										type: "string"
									}
									tag: {
										description: "Tag contains desired docker image version"
										type:        "string"
									}
								}
								type: "object"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the VMAlert configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							livenessProbe: {
								description:                            "LivenessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logFormat: {
								description: "LogFormat for VMAlert to be configured with. default or json"

								enum: [
									"default",
									"json",
								]
								type: "string"
							}
							logLevel: {
								description: "LogLevel for VMAlert to be configured with."
								enum: [
									"INFO",
									"WARN",
									"ERROR",
									"FATAL",
									"PANIC",
								]
								type: "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector Define which Nodes the Pods are scheduled on."

								type: "object"
							}
							notifier: {
								description: "Notifier prometheus alertmanager endpoint spec. Required at least one of  notifier or notifiers. e.g. http://127.0.0.1:9093 If specified both notifier and notifiers, notifier will be added as last element to notifiers. only one of notifier options could be chosen: notifierConfigRef or notifiers +  notifier"

								properties: {
									OAuth2: {
										description: "OAuth2 defines OAuth2 configuration"
										required: [
											"client_id",
											"token_url",
										]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"

										properties: {
											password: {
												description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											password_file: {
												description: "PasswordFile defines path to password file at disk"

												type: "string"
											}
											username: {
												description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerTokenFilePath: type: "string"
									bearerTokenSecret: {
										description: "Optional bearer auth token to use for -remoteWrite.url"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									headers: {
										description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName:headerValue vmalert supports it since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									selector: {
										description: "Selector allows service discovery for alertmanager in this case all matched vmalertmanager replicas will be added into vmalert notifier.url as statefulset pod.fqdn"

										properties: {
											labelSelector: {
												description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."

												properties: {
													matchExpressions: {
														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

														items: {
															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

															properties: {
																key: {
																	description: "key is the label key that the selector applies to."

																	type: "string"
																}
																operator: {
																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																	type: "string"
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

														type: "object"
													}
												}
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											namespaceSelector: {
												description: "NamespaceSelector is a selector for selecting either all namespaces or a list of namespaces."

												properties: {
													any: {
														description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."

														type: "boolean"
													}
													matchNames: {
														description: "List of namespace names."
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									tlsConfig: {
										description:                            "TLSConfig specifies TLSConfig configuration parameters."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									url: {
										description: "AlertManager url.  E.g. http://127.0.0.1:9093"
										type:        "string"
									}
								}
								type: "object"
							}
							notifierConfigRef: {
								description: "NotifierConfigRef reference for secret with notifier configuration for vmalert only one of notifier options could be chosen: notifierConfigRef or notifiers +  notifier"

								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
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
							notifiers: {
								description: "Notifiers prometheus alertmanager endpoints. Required at least one of  notifier or notifiers. e.g. http://127.0.0.1:9093 If specified both notifier and notifiers, notifier will be added as last element to notifiers. only one of notifier options could be chosen: notifierConfigRef or notifiers +  notifier"

								items: {
									description: "VMAlertNotifierSpec defines the notifier url for sending information about alerts"

									properties: {
										OAuth2: {
											description: "OAuth2 defines OAuth2 configuration"
											required: [
												"client_id",
												"token_url",
											]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication"

											properties: {
												password: {
													description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												password_file: {
													description: "PasswordFile defines path to password file at disk"

													type: "string"
												}
												username: {
													description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenFilePath: type: "string"
										bearerTokenSecret: {
											description: "Optional bearer auth token to use for -remoteWrite.url"
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."

													type: "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"

													type: "boolean"
												}
											}
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										headers: {
											description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName:headerValue vmalert supports it since 1.79.0 version"

											items: type: "string"
											type: "array"
										}
										selector: {
											description: "Selector allows service discovery for alertmanager in this case all matched vmalertmanager replicas will be added into vmalert notifier.url as statefulset pod.fqdn"

											properties: {
												labelSelector: {
													description: "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects."

													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

																properties: {
																	key: {
																		description: "key is the label key that the selector applies to."

																		type: "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																		type: "string"
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

															type: "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												namespaceSelector: {
													description: "NamespaceSelector is a selector for selecting either all namespaces or a list of namespaces."

													properties: {
														any: {
															description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."

															type: "boolean"
														}
														matchNames: {
															description: "List of namespace names."
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										tlsConfig: {
											description:                            "TLSConfig specifies TLSConfig configuration parameters."
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										url: {
											description: "AlertManager url.  E.g. http://127.0.0.1:9093"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							podDisruptionBudget: {
								description: "PodDisruptionBudget created by operator"
								properties: {
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

										"x-kubernetes-int-or-string": true
									}
									minAvailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

										"x-kubernetes-int-or-string": true
									}
									selectorLabels: {
										additionalProperties: type: "string"
										description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

										type: "object"
									}
								}
								type: "object"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the VMAlert pods."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							port: {
								description: "Port for listen"
								type:        "string"
							}
							priorityClassName: {
								description: "Priority class assigned to the Pods"
								type:        "string"
							}
							readinessGates: {
								description: "ReadinessGates defines pod readiness gates"
								items: {
									description: "PodReadinessGate contains the reference to a pod condition"
									properties: conditionType: {
										description: "ConditionType refers to a condition in the pod's condition list with matching type."

										type: "string"
									}
									required: ["conditionType"]
									type: "object"
								}
								type: "array"
							}
							readinessProbe: {
								description:                            "ReadinessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							remoteRead: {
								description: "RemoteRead Optional URL to read vmalert state (persisted via RemoteWrite) This configuration only makes sense if alerts state has been successfully persisted (via RemoteWrite) before. see -remoteRead.url docs in vmalerts for details. E.g. http://127.0.0.1:8428"

								properties: {
									OAuth2: {
										description: "OAuth2 defines OAuth2 configuration"
										required: [
											"client_id",
											"token_url",
										]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"

										properties: {
											password: {
												description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											password_file: {
												description: "PasswordFile defines path to password file at disk"

												type: "string"
											}
											username: {
												description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerTokenFilePath: type: "string"
									bearerTokenSecret: {
										description: "Optional bearer auth token to use for -remoteWrite.url"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									headers: {
										description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName:headerValue vmalert supports it since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									lookback: {
										description: "Lookback defines how far to look into past for alerts timeseries. For example, if lookback=1h then range from now() to now()-1h will be scanned. (default 1h0m0s) Applied only to RemoteReadSpec"

										type: "string"
									}
									tlsConfig: {
										description:                            "TLSConfig specifies TLSConfig configuration parameters."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									url: {
										description: "URL of the endpoint to send samples to."
										type:        "string"
									}
								}
								required: ["url"]
								type: "object"
							}
							remoteWrite: {
								description: "RemoteWrite Optional URL to remote-write compatible storage to persist vmalert state and rule results to. Rule results will be persisted according to each rule. Alerts state will be persisted in the form of time series named ALERTS and ALERTS_FOR_STATE see -remoteWrite.url docs in vmalerts for details. E.g. http://127.0.0.1:8428"

								properties: {
									OAuth2: {
										description: "OAuth2 defines OAuth2 configuration"
										required: [
											"client_id",
											"token_url",
										]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"

										properties: {
											password: {
												description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											password_file: {
												description: "PasswordFile defines path to password file at disk"

												type: "string"
											}
											username: {
												description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerTokenFilePath: type: "string"
									bearerTokenSecret: {
										description: "Optional bearer auth token to use for -remoteWrite.url"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									concurrency: {
										description: "Defines number of readers that concurrently write into remote storage (default 1)"

										format: "int32"
										type:   "integer"
									}
									flushInterval: {
										description: "Defines interval of flushes to remote write endpoint (default 5s)"

										pattern: "[0-9]+(ms|s|m|h)"
										type:    "string"
									}
									headers: {
										description: "Headers allow configuring custom http headers Must be in form of semicolon separated header with value e.g. headerName:headerValue vmalert supports it since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									maxBatchSize: {
										description: "Defines defines max number of timeseries to be flushed at once (default 1000)"

										format: "int32"
										type:   "integer"
									}
									maxQueueSize: {
										description: "Defines the max number of pending datapoints to remote write endpoint (default 100000)"

										format: "int32"
										type:   "integer"
									}
									tlsConfig: {
										description:                            "TLSConfig specifies TLSConfig configuration parameters."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									url: {
										description: "URL of the endpoint to send samples to."
										type:        "string"
									}
								}
								required: ["url"]
								type: "object"
							}
							replicaCount: {
								description: "ReplicaCount is the expected size of the VMAlert cluster. The controller will eventually make the size of the running cluster equal to the expected size."

								format: "int32"
								type:   "integer"
							}
							resources: {
								description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"
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

										type: "object"
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

										type: "object"
									}
								}
								type: "object"
							}
							rollingUpdate: {
								description: "RollingUpdate - overrides deployment update params."
								properties: {
									maxSurge: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods."

										"x-kubernetes-int-or-string": true
									}
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods."

										"x-kubernetes-int-or-string": true
									}
								}
								type: "object"
							}
							ruleNamespaceSelector: {
								description: "RuleNamespaceSelector to be selected for VMRules discovery. Works in combination with Selector. If both nil - behaviour controlled by selectAllByDefault NamespaceSelector nil - only objects at VMAlert namespace."

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							rulePath: {
								description: "RulePath to the file with alert rules. Supports patterns. Flag can be specified multiple times. Examples: -rule /path/to/file. Path to a single file with alerting rules -rule dir/*.yaml -rule /*.yaml. Relative path to all .yaml files in folder, absolute path to all .yaml files in root. by default operator adds /etc/vmalert/configs/base/vmalert.yaml"

								items: type: "string"
								type: "array"
							}
							ruleSelector: {
								description: "RuleSelector selector to select which VMRules to mount for loading alerting rules from. Works in combination with NamespaceSelector. If both nil - behaviour controlled by selectAllByDefault NamespaceSelector nil - only objects at VMAlert namespace."

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							runtimeClassName: {
								description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

								type: "string"
							}
							schedulerName: {
								description: "SchedulerName - defines kubernetes scheduler name"
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the VMAlert object, which shall be mounted into the VMAlert Pods. The Secrets are mounted into /etc/vm/secrets/<secret-name>."

								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							selectAllByDefault: {
								description: "SelectAllByDefault changes default behavior for empty CRD selectors, such RuleSelector. with selectAllByDefault: true and empty serviceScrapeSelector and RuleNamespaceSelector Operator selects all exist serviceScrapes with selectAllByDefault: false - selects nothing"

								type: "boolean"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the VMAlert Pods."

								type: "string"
							}
							serviceScrapeSpec: {
								description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

								required: ["endpoints"]
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceSpec: {
								description: "ServiceSpec that will be added to vmalert service spec"
								properties: {
									metadata: {
										description: "EmbeddedObjectMetadata defines objectMeta for additional service."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: ["spec"]
								type: "object"
							}
							startupProbe: {
								description:                            "StartupProbe that will be added to CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							terminationGracePeriodSeconds: {
								description: "TerminationGracePeriodSeconds period for container graceful termination"

								format: "int64"
								type:   "integer"
							}
							tolerations: {
								description: "Tolerations If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

											type: "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

											type: "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

											type: "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

											format: "int64"
											type:   "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							updateStrategy: {
								description: "UpdateStrategy - overrides default update strategy."
								enum: [
									"Recreate",
									"RollingUpdate",
								]
								type: "string"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMAlert container, that are generated as a result of StorageSpec objects."

								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."

									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

											type: "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

											type: "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

											type: "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

											type: "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

											type: "string"
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
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output Deployment definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
						}, required: [
							"datasource",
						], type:
							"object"
					}, status: {
						description:
							"VmAlertStatus defines the observed state of VmAlert", properties: {

							availableReplicas: {
								description: "AvailableReplicas Total number of available pods (ready for at least minReadySeconds) targeted by this VMAlert cluster."

								format: "int32"
								type:   "integer"
							}
							replicas: {
								description: "ReplicaCount Total number of non-terminated pods targeted by this VMAlert cluster (their labels match the selector)."

								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								description: "UnavailableReplicas Total number of unavailable pods targeted by this VMAlert cluster."

								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								description: "UpdatedReplicas Total number of non-terminated pods targeted by this VMAlert cluster that have the desired version spec."

								format: "int32"
								type:   "integer"
							}
						}, required: [
							"availableReplicas",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						], type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmauths.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMAuth"
				listKind:
					"VMAuthList", plural: "vmauths"
				singular:
					"vmauth"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMAuth is the Schema for the vmauths API", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMAuthSpec defines the desired state of VMAuth", properties: {

							"-": {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server"

								type: "string"
							}
							affinity: {
								description:                            "Affinity If specified, the pod's scheduling constraints."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMAuth object, which shall be mounted into the VMAuth Pods."

								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							dnsConfig: {
								description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

								items: "x-kubernetes-preserve-unknown-fields": true
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
								description: "DNSPolicy sets DNS policy for the pod"
								type:        "string"
							}
							extraArgs: {
								additionalProperties: type: "string"
								description: "ExtraArgs that will be passed to  VMAuth pod for example remoteWrite.tmpDataPath: /tmp"

								type: "object"
							}
							extraEnvs: {
								description: "ExtraEnvs that will be added to VMAuth pod"
								items: {
									description: "EnvVar represents an environment variable present in a Container."

									properties: {
										name: {
											description: "Name of the environment variable. Must be a C_IDENTIFIER."
											type:        "string"
										}
										value: {
											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

											type: "string"
										}
									}
									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							hostAliases: {
								description: "HostAliases provides mapping for ip and hostname, that would be propagated to pod, cannot be used with HostNetwork."

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
							hostNetwork: {
								description: "HostNetwork controls whether the pod may use the node network namespace"

								type: "boolean"
							}
							image: {
								description: "Image - docker image settings for VMAuth if no specified operator uses default config version"

								properties: {
									pullPolicy: {
										description: "PullPolicy describes how to pull docker image"
										type:        "string"
									}
									repository: {
										description: "Repository contains name of docker image + it's repository if needed"

										type: "string"
									}
									tag: {
										description: "Tag contains desired docker image version"
										type:        "string"
									}
								}
								type: "object"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							ingress: {
								description: "Ingress enables ingress configuration for VMAuth."
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									class_name: {
										description: "ClassName defines ingress class name for VMAuth"
										type:        "string"
									}
									extraRules: {
										description: "ExtraRules - additional rules for ingress, must be checked for correctness by user."

										items: {
											description: "IngressRule represents the rules mapping the paths under a specified host to the related backend services. Incoming requests are first evaluated for a host match, then routed to the backend associated with the matching IngressRuleValue."

											properties: {
												host: {
													description: """
		Host is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the \"host\" part of the URI as defined in RFC 3986: 1. IPs are not allowed. Currently an IngressRuleValue can only apply to the IP in the Spec of the parent Ingress. 2. The `:` delimiter is not respected because ports are not allowed. Currently the port of an Ingress is implicitly :80 for http and :443 for https. Both these may change in the future. Incoming requests are matched against the host before the IngressRuleValue. If the host is unspecified, the Ingress routes all traffic based on the specified IngressRuleValue.
		 Host can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.bar.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. \"*.foo.com\"). The wildcard character '*' must appear by itself as the first DNS label and matches only a single label. You cannot have a wildcard label by itself (e.g. Host == \"*\"). Requests will be matched against the Host field in the following way: 1. If Host is precise, the request matches this rule if the http host header is equal to Host. 2. If Host is a wildcard, then the request matches this rule if the http host header is to equal to the suffix (removing the first label) of the wildcard rule.
		"""

													type: "string"
												}
												http: {
													description: "HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'."

													properties: paths: {
														description: "A collection of paths that map requests to backends."

														items: {
															description: "HTTPIngressPath associates a path with a backend. Incoming urls matching the path are forwarded to the backend."

															properties: {
																backend: {
																	description: "Backend defines the referenced service endpoint to which the traffic will be forwarded to."

																	properties: {
																		resource: {
																			description: "Resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with \"Service\"."

																			properties: {
																				apiGroup: {
																					description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																					type: "string"
																				}
																				kind: {
																					description: "Kind is the type of resource being referenced"

																					type: "string"
																				}
																				name: {
																					description: "Name is the name of resource being referenced"

																					type: "string"
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
																			description: "Service references a Service as a Backend. This is a mutually exclusive setting with \"Resource\"."

																			properties: {
																				name: {
																					description: "Name is the referenced service. The service must exist in the same namespace as the Ingress object."

																					type: "string"
																				}
																				port: {
																					description: "Port of the referenced service. A port name or port number is required for a IngressServiceBackend."

																					properties: {
																						name: {
																							description: "Name is the name of the port on the Service. This is a mutually exclusive setting with \"Number\"."

																							type: "string"
																						}
																						number: {
																							description: "Number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with \"Name\"."

																							format: "int32"
																							type:   "integer"
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
																	description: "Path is matched against the path of an incoming request. Currently it can contain characters disallowed from the conventional \"path\" part of a URL as defined by RFC 3986. Paths must begin with a '/' and must be present when using PathType with value \"Exact\" or \"Prefix\"."

																	type: "string"
																}
																pathType: {
																	description: "PathType determines the interpretation of the Path matching. PathType can be one of the following values: * Exact: Matches the URL path exactly. * Prefix: Matches based on a URL path prefix split by '/'. Matching is done on a path element by element basis. A path element refers is the list of labels in the path split by the '/' separator. A request is a match for path p if every p is an element-wise prefix of p of the request path. Note that if the last element of the path is a substring of the last element in request path, it is not a match (e.g. /foo/bar matches /foo/bar/baz, but does not match /foo/barbaz). * ImplementationSpecific: Interpretation of the Path matching is up to the IngressClass. Implementations can treat this as a separate PathType or treat it identically to Prefix or Exact path types. Implementations are required to support all path types."

																	type: "string"
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
										type: "array"
									}
									extraTls: {
										description: "ExtraTLS - additional TLS configuration for ingress must be checked for correctness by user."

										items: {
											description: "IngressTLS describes the transport layer security associated with an Ingress."

											properties: {
												hosts: {
													description: "Hosts are a list of hosts included in the TLS certificate. The values in this list must match the name/s used in the tlsSecret. Defaults to the wildcard host setting for the loadbalancer controller fulfilling this Ingress, if left unspecified."

													items: type: "string"
													type:                     "array"
													"x-kubernetes-list-type": "atomic"
												}
												secretName: {
													description: "SecretName is the name of the secret used to terminate TLS traffic on port 443. Field is left optional to allow TLS routing based on SNI hostname alone. If the SNI host in a listener conflicts with the \"Host\" header field used by an IngressRule, the SNI host is used for termination and value of the Host header is used for routing."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									host: {
										description: "Host defines ingress host parameter for default rule It will be used, only if TlsHosts is empty"

										type: "string"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
									tlsHosts: {
										description: "TlsHosts configures TLS access for ingress, tlsSecretName must be defined for it."

										items: type: "string"
										type: "array"
									}
									tlsSecretName: {
										description: "TlsSecretName defines secretname at the VMAuth namespace with cert and key https://kubernetes.io/docs/concepts/services-networking/ingress/#tls"

										type: "string"
									}
								}
								type: "object"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the vmSingle configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							livenessProbe: {
								description:                            "LivenessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logFormat: {
								description: "LogFormat for VMAuth to be configured with."
								enum: [
									"default",
									"json",
								]
								type: "string"
							}
							logLevel: {
								description: "LogLevel for victoria metrics single to be configured with."

								enum: [
									"INFO",
									"WARN",
									"ERROR",
									"FATAL",
									"PANIC",
								]
								type: "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector Define which Nodes the Pods are scheduled on."

								type: "object"
							}
							podDisruptionBudget: {
								description: "PodDisruptionBudget created by operator"
								properties: {
									maxUnavailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

										"x-kubernetes-int-or-string": true
									}
									minAvailable: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

										"x-kubernetes-int-or-string": true
									}
									selectorLabels: {
										additionalProperties: type: "string"
										description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

										type: "object"
									}
								}
								type: "object"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the VMAuth pods."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							port: {
								description: "Port listen port"
								type:        "string"
							}
							priorityClassName: {
								description: "PriorityClassName assigned to the Pods"
								type:        "string"
							}
							readinessGates: {
								description: "ReadinessGates defines pod readiness gates"
								items: {
									description: "PodReadinessGate contains the reference to a pod condition"
									properties: conditionType: {
										description: "ConditionType refers to a condition in the pod's condition list with matching type."

										type: "string"
									}
									required: ["conditionType"]
									type: "object"
								}
								type: "array"
							}
							readinessProbe: {
								description:                            "ReadinessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							replicaCount: {
								description: "ReplicaCount is the expected size of the VMAuth"
								format:      "int32"
								type:        "integer"
							}
							resources: {
								description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ if not defined default resources from operator config will be used"

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

										type: "object"
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

										type: "object"
									}
								}
								type: "object"
							}
							runtimeClassName: {
								description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

								type: "string"
							}
							schedulerName: {
								description: "SchedulerName - defines kubernetes scheduler name"
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the VMAuth object, which shall be mounted into the VMAuth Pods."

								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							selectAllByDefault: {
								description: "SelectAllByDefault changes default behavior for empty CRD selectors, such userSelector. with selectAllByDefault: true and empty userSelector and userNamespaceSelector Operator selects all exist users with selectAllByDefault: false - selects nothing"

								type: "boolean"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the VMAuth Pods."

								type: "string"
							}
							serviceScrapeSpec: {
								description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

								required: ["endpoints"]
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceSpec: {
								description: "ServiceSpec that will be added to vmsingle service spec"
								properties: {
									metadata: {
										description: "EmbeddedObjectMetadata defines objectMeta for additional service."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: ["spec"]
								type: "object"
							}
							startupProbe: {
								description:                            "StartupProbe that will be added to CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							terminationGracePeriodSeconds: {
								description: "TerminationGracePeriodSeconds period for container graceful termination"

								format: "int64"
								type:   "integer"
							}
							tolerations: {
								description: "Tolerations If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

											type: "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

											type: "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

											type: "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

											format: "int64"
											type:   "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							unauthorizedAccessConfig: {
								description: "UnauthorizedAccessConfig configures access for un authorized users"

								items: {
									description: "VMAuthUnauthorizedPath defines url_map for unauthorized access"

									properties: {
										ip_filters: {
											description: "IPFilters defines filter for src ip address enterprise only"

											properties: {
												allow_list: {
													items: type: "string"
													type: "array"
												}
												deny_list: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										src_paths: {
											description: "Paths src request paths"
											items: type: "string"
											type: "array"
										}
										url_prefix: {
											description: "URLs defines url_prefix for dst routing"
											items: type: "string"
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							userNamespaceSelector: {
								description: "UserNamespaceSelector Namespaces to be selected for  VMAuth discovery. Works in combination with Selector. NamespaceSelector nil - only objects at VMAuth namespace. Selector nil - only objects at NamespaceSelector namespaces. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							userSelector: {
								description: "UserSelector defines VMUser to be selected for config file generation. Works in combination with NamespaceSelector. NamespaceSelector nil - only objects at VMAuth namespace. If both nil - behaviour controlled by selectAllByDefault"

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMAuth container, that are generated as a result of StorageSpec objects."

								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."

									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

											type: "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

											type: "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

											type: "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

											type: "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

											type: "string"
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
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output deploy definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
						}, type:
							"object"
					}, status: {
						description:
							"VMAuthStatus defines the observed state of VMAuth", type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmclusters.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMCluster"
				listKind:
					"VMClusterList", plural: "vmclusters"
				singular:
					"vmcluster"
		}, scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description:
					"replicas of VMInsert", jsonPath:
					".spec.vminsert.replicaCount", name: "Insert Count"
				type: "string"
			}, {
				description:
					"replicas of VMStorage", jsonPath:
					".spec.vmstorage.replicaCount", name: "Storage Count"
				type: "string"
			}, {
				description:
					"replicas of VMSelect", jsonPath:
					".spec.vmselect.replicaCount", name: "Select Count"
				type: "string"
			}, {
				jsonPath:
					".metadata.creationTimestamp", name: "Age"
				type: "date"
			}, {
				description:
					"Current status of cluster", jsonPath:
					".status.clusterStatus", name: "Status"
				type: "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMCluster is fast, cost-effective and scalable time-series database. Cluster version with"
				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMClusterSpec defines the desired state of VMCluster", properties: {

							"-": {
								description: "ParsingError contents error with context if operator was failed to parse json object from kubernetes api server"

								type: "string"
							}
							clusterVersion: {
								description: "ClusterVersion defines default images tag for all components. it can be overwritten with component specific image.tag value."

								type: "string"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							replicationFactor: {
								description: "ReplicationFactor defines how many copies of data make among distinct storage nodes"

								format: "int32"
								type:   "integer"
							}
							retentionPeriod: {
								description: "RetentionPeriod for the stored metrics Note VictoriaMetrics has data/ and indexdb/ folders metrics from data/ removed eventually as soon as partition leaves retention period reverse index data at indexdb rotates once at the half of configured retention period https://docs.victoriametrics.com/Single-server-VictoriaMetrics.html#retention"

								type: "string"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the VMSelect, VMStorage and VMInsert Pods."

								type: "string"
							}
							vminsert: {
								properties: {
									affinity: {
										description:                            "Affinity If specified, the pod's scheduling constraints."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									clusterNativeListenPort: {
										description: "ClusterNativePort for multi-level cluster setup. More details: https://docs.victoriametrics.com/Cluster-VictoriaMetrics.html#multi-level-cluster-setup"

										type: "string"
									}
									configMaps: {
										description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>."

										items: type: "string"
										type: "array"
									}
									containers: {
										description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									dnsConfig: {
										description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

										items: "x-kubernetes-preserve-unknown-fields": true
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
										description: "DNSPolicy sets DNS policy for the pod"
										type:        "string"
									}
									extraArgs: {
										additionalProperties: type: "string"
										type: "object"
									}
									extraEnvs: {
										description: "ExtraEnvs that will be added to VMSelect pod"
										items: {
											description: "EnvVar represents an environment variable present in a Container."

											properties: {
												name: {
													description: "Name of the environment variable. Must be a C_IDENTIFIER."

													type: "string"
												}
												value: {
													description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

													type: "string"
												}
											}
											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									hostNetwork: {
										description: "HostNetwork controls whether the pod may use the node network namespace"

										type: "boolean"
									}
									hpa: {
										description: "HPA defines kubernetes PodAutoScaling configuration version 2."

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									image: {
										description: "Image - docker image settings for VMInsert"
										properties: {
											pullPolicy: {
												description: "PullPolicy describes how to pull docker image"
												type:        "string"
											}
											repository: {
												description: "Repository contains name of docker image + it's repository if needed"

												type: "string"
											}
											tag: {
												description: "Tag contains desired docker image version"
												type:        "string"
											}
										}
										type: "object"
									}
									initContainers: {
										description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the VMSelect configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									insertPorts: {
										description: "InsertPorts - additional listen ports for data ingestion."
										properties: {
											graphitePort: {
												description: "GraphitePort listen port"
												type:        "string"
											}
											influxPort: {
												description: "InfluxPort listen port"
												type:        "string"
											}
											openTSDBHTTPPort: {
												description: "OpenTSDBHTTPPort for http connections."
												type:        "string"
											}
											openTSDBPort: {
												description: "OpenTSDBPort for tcp and udp listen"
												type:        "string"
											}
										}
										type: "object"
									}
									livenessProbe: {
										description:                            "LivenessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									logFormat: {
										description: "LogFormat for VMSelect to be configured with. default or json"

										enum: [
											"default",
											"json",
										]
										type: "string"
									}
									logLevel: {
										description: "LogLevel for VMSelect to be configured with."
										enum: [
											"INFO",
											"WARN",
											"ERROR",
											"FATAL",
											"PANIC",
										]
										type: "string"
									}
									name: {
										description: "Name is deprecated and will be removed at 0.22.0 release"

										type: "string"
									}
									nodeSelector: {
										additionalProperties: type: "string"
										description: "NodeSelector Define which Nodes the Pods are scheduled on."

										type: "object"
									}
									podDisruptionBudget: {
										description: "PodDisruptionBudget created by operator"
										properties: {
											maxUnavailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

												"x-kubernetes-int-or-string": true
											}
											minAvailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

												"x-kubernetes-int-or-string": true
											}
											selectorLabels: {
												additionalProperties: type: "string"
												description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

												type: "object"
											}
										}
										type: "object"
									}
									podMetadata: {
										description: "PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									port: {
										description: "Port listen port"
										type:        "string"
									}
									priorityClassName: {
										description: "Priority class assigned to the Pods"
										type:        "string"
									}
									readinessGates: {
										description: "ReadinessGates defines pod readiness gates"
										items: {
											description: "PodReadinessGate contains the reference to a pod condition"

											properties: conditionType: {
												description: "ConditionType refers to a condition in the pod's condition list with matching type."

												type: "string"
											}
											required: ["conditionType"]
											type: "object"
										}
										type: "array"
									}
									readinessProbe: {
										description:                            "ReadinessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									replicaCount: {
										description: "ReplicaCount is the expected size of the VMInsert cluster. The controller will eventually make the size of the running cluster equal to the expected size."

										format: "int32"
										type:   "integer"
									}
									resources: {
										description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

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

												type: "object"
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

												type: "object"
											}
										}
										type: "object"
									}
									rollingUpdate: {
										description: "RollingUpdate - overrides deployment update params."
										properties: {
											maxSurge: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "The maximum number of pods that can be scheduled above the desired number of pods. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is calculated from percentage by rounding up. Defaults to 25%. Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when the rolling update starts, such that the total number of old and new pods do not exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet can be scaled up further, ensuring that total number of pods running at any time during the update is at most 130% of desired pods."

												"x-kubernetes-int-or-string": true
											}
											maxUnavailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "The maximum number of pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%). Absolute number is calculated from percentage by rounding down. This can not be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods immediately when the rolling update starts. Once new pods are ready, old ReplicaSet can be scaled down further, followed by scaling up the new ReplicaSet, ensuring that the total number of pods available at all times during the update is at least 70% of desired pods."

												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									runtimeClassName: {
										description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

										type: "string"
									}
									schedulerName: {
										description: "SchedulerName - defines kubernetes scheduler name"
										type:        "string"
									}
									secrets: {
										description: "Secrets is a list of Secrets in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The Secrets are mounted into /etc/vm/secrets/<secret-name>."

										items: type: "string"
										type: "array"
									}
									securityContext: {
										description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceScrapeSpec: {
										description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

										required: ["endpoints"]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceSpec: {
										description: "ServiceSpec that will be added to vminsert service spec"

										properties: {
											metadata: {
												description: "EmbeddedObjectMetadata defines objectMeta for additional service."

												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

														type: "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

														type: "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										required: ["spec"]
										type: "object"
									}
									startupProbe: {
										description:                            "StartupProbe that will be added to CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									terminationGracePeriodSeconds: {
										description: "TerminationGracePeriodSeconds period for container graceful termination"

										format: "int64"
										type:   "integer"
									}
									tolerations: {
										description: "Tolerations If specified, the pod's tolerations."
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

													type: "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

													type: "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

													type: "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

													format: "int64"
													type:   "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									topologySpreadConstraints: {
										description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

										items: {
											description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

											required: [
												"maxSkew",
												"topologyKey",
												"whenUnsatisfiable",
											]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									updateStrategy: {
										description: "UpdateStrategy - overrides default update strategy."
										enum: [
											"Recreate",
											"RollingUpdate",
										]
										type: "string"
									}
									volumeMounts: {
										description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container, that are generated as a result of StorageSpec objects."

										items: {
											description: "VolumeMount describes a mounting of a Volume within a container."

											properties: {
												mountPath: {
													description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

													type: "string"
												}
												mountPropagation: {
													description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

													type: "string"
												}
												name: {
													description: "This must match the Name of a Volume."
													type:        "string"
												}
												readOnly: {
													description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

													type: "boolean"
												}
												subPath: {
													description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

													type: "string"
												}
												subPathExpr: {
													description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

													type: "string"
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
									volumes: {
										description: "Volumes allows configuration of additional volumes on the output Deployment definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

										items: {
											description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
								}
								required: ["replicaCount"]
								type: "object"
							}
							vmselect: {
								properties: {
									affinity: {
										description:                            "Affinity If specified, the pod's scheduling constraints."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									cacheMountPath: {
										description: "CacheMountPath allows to add cache persistent for VMSelect"

										type: "string"
									}
									claimTemplates: {
										description: "ClaimTemplates allows adding additional VolumeClaimTemplates for StatefulSet"

										items: {
											description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"

											properties: {
												apiVersion: {
													description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

													type: "string"
												}
												kind: {
													description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

													type: "string"
												}
												metadata: {
													description:                            "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												spec: {
													description: "spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

																	type: "string"
																}
																kind: {
																	description: "Kind is the type of resource being referenced"

																	type: "string"
																}
																name: {
																	description: "Name is the name of resource being referenced"

																	type: "string"
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
															description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

															properties: {
																apiGroup: {
																	description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																	type: "string"
																}
																kind: {
																	description: "Kind is the type of resource being referenced"

																	type: "string"
																}
																name: {
																	description: "Name is the name of resource being referenced"

																	type: "string"
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

																	type: "object"
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

																	type: "object"
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

																				type: "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																				type: "string"
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

																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: {
															description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

															type: "string"
														}
														volumeMode: {
															description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

															type: "string"
														}
														volumeName: {
															description: "volumeName is the binding reference to the PersistentVolume backing this claim."

															type: "string"
														}
													}
													type: "object"
												}
												status: {
													description: "status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

													properties: {
														accessModes: {
															description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

															items: type: "string"
															type: "array"
														}
														allocatedResources: {
															additionalProperties: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																"x-kubernetes-int-or-string": true
															}
															description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

															type: "object"
														}
														capacity: {
															additionalProperties: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																"x-kubernetes-int-or-string": true
															}
															description: "capacity represents the actual resources of the underlying volume."

															type: "object"
														}
														conditions: {
															description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

															items: {
																description: "PersistentVolumeClaimCondition contails details about state of pvc"

																properties: {
																	lastProbeTime: {
																		description: "lastProbeTime is the time we probed the condition."

																		format: "date-time"
																		type:   "string"
																	}
																	lastTransitionTime: {
																		description: "lastTransitionTime is the time the condition transitioned from one status to another."

																		format: "date-time"
																		type:   "string"
																	}
																	message: {
																		description: "message is the human-readable message indicating details about last transition."

																		type: "string"
																	}
																	reason: {
																		description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																		type: "string"
																	}
																	status: type: "string"
																	type: {
																		description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																		type: "string"
																	}
																}
																required: [
																	"status",
																	"type",
																]
																type: "object"
															}
															type: "array"
														}
														phase: {
															description: "phase represents the current phase of PersistentVolumeClaim."
															type:        "string"
														}
														resizeStatus: {
															description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

															type: "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										type: "array"
									}
									clusterNativeListenPort: {
										description: "ClusterNativePort for multi-level cluster setup. More details: https://docs.victoriametrics.com/Cluster-VictoriaMetrics.html#multi-level-cluster-setup"

										type: "string"
									}
									configMaps: {
										description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>."

										items: type: "string"
										type: "array"
									}
									containers: {
										description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									dnsConfig: {
										description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

										items: "x-kubernetes-preserve-unknown-fields": true
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
										description: "DNSPolicy sets DNS policy for the pod"
										type:        "string"
									}
									extraArgs: {
										additionalProperties: type: "string"
										type: "object"
									}
									extraEnvs: {
										description: "ExtraEnvs that will be added to VMSelect pod"
										items: {
											description: "EnvVar represents an environment variable present in a Container."

											properties: {
												name: {
													description: "Name of the environment variable. Must be a C_IDENTIFIER."

													type: "string"
												}
												value: {
													description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

													type: "string"
												}
											}
											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									hostNetwork: {
										description: "HostNetwork controls whether the pod may use the node network namespace"

										type: "boolean"
									}
									hpa: {
										description: "Configures horizontal pod autoscaling. Note, enabling this option disables vmselect to vmselect communication. In most cases it's not an issue."

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									image: {
										description: "Image - docker image settings for VMSelect"
										properties: {
											pullPolicy: {
												description: "PullPolicy describes how to pull docker image"
												type:        "string"
											}
											repository: {
												description: "Repository contains name of docker image + it's repository if needed"

												type: "string"
											}
											tag: {
												description: "Tag contains desired docker image version"
												type:        "string"
											}
										}
										type: "object"
									}
									initContainers: {
										description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the VMSelect configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									livenessProbe: {
										description:                            "LivenessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									logFormat: {
										description: "LogFormat for VMSelect to be configured with. default or json"

										enum: [
											"default",
											"json",
										]
										type: "string"
									}
									logLevel: {
										description: "LogLevel for VMSelect to be configured with."
										enum: [
											"INFO",
											"WARN",
											"ERROR",
											"FATAL",
											"PANIC",
										]
										type: "string"
									}
									name: {
										description: "Name is deprecated and will be removed at 0.22.0 release"

										type: "string"
									}
									nodeSelector: {
										additionalProperties: type: "string"
										description: "NodeSelector Define which Nodes the Pods are scheduled on."

										type: "object"
									}
									persistentVolume: {
										description: "Storage - add persistent volume for cacheMounthPath its useful for persistent cache use storage instead of persistentVolume."

										properties: {
											disableMountSubPath: {
												description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."

												type: "boolean"
											}
											emptyDir: {
												description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"

												properties: {
													medium: {
														description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

														type: "string"
													}
													sizeLimit: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"

														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
												}
												type: "object"
											}
											volumeClaimTemplate: {
												description:                            "A PVC spec to be used by the VMAlertManager StatefulSets."
												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										type: "object"
									}
									podDisruptionBudget: {
										description: "PodDisruptionBudget created by operator"
										properties: {
											maxUnavailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

												"x-kubernetes-int-or-string": true
											}
											minAvailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

												"x-kubernetes-int-or-string": true
											}
											selectorLabels: {
												additionalProperties: type: "string"
												description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

												type: "object"
											}
										}
										type: "object"
									}
									podMetadata: {
										description: "PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									port: {
										description: "Port listen port"
										type:        "string"
									}
									priorityClassName: {
										description: "Priority class assigned to the Pods"
										type:        "string"
									}
									readinessGates: {
										description: "ReadinessGates defines pod readiness gates"
										items: {
											description: "PodReadinessGate contains the reference to a pod condition"

											properties: conditionType: {
												description: "ConditionType refers to a condition in the pod's condition list with matching type."

												type: "string"
											}
											required: ["conditionType"]
											type: "object"
										}
										type: "array"
									}
									readinessProbe: {
										description:                            "ReadinessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									replicaCount: {
										description: "ReplicaCount is the expected size of the VMSelect cluster. The controller will eventually make the size of the running cluster equal to the expected size."

										format: "int32"
										type:   "integer"
									}
									resources: {
										description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

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

												type: "object"
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

												type: "object"
											}
										}
										type: "object"
									}
									rollingUpdateStrategy: {
										description: "RollingUpdateStrategy defines strategy for application updates Default is OnDelete, in this case operator handles update process Can be changed for RollingUpdate"

										type: "string"
									}
									runtimeClassName: {
										description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

										type: "string"
									}
									schedulerName: {
										description: "SchedulerName - defines kubernetes scheduler name"
										type:        "string"
									}
									secrets: {
										description: "Secrets is a list of Secrets in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The Secrets are mounted into /etc/vm/secrets/<secret-name>."

										items: type: "string"
										type: "array"
									}
									securityContext: {
										description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceScrapeSpec: {
										description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

										required: ["endpoints"]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceSpec: {
										description: "ServiceSpec that will be added to vmselect service spec"

										properties: {
											metadata: {
												description: "EmbeddedObjectMetadata defines objectMeta for additional service."

												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

														type: "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

														type: "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										required: ["spec"]
										type: "object"
									}
									startupProbe: {
										description:                            "StartupProbe that will be added to CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									storage: {
										description: "StorageSpec - add persistent volume claim for cacheMounthPath its needed for persistent cache"

										properties: {
											disableMountSubPath: {
												description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."

												type: "boolean"
											}
											emptyDir: {
												description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"

												properties: {
													medium: {
														description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

														type: "string"
													}
													sizeLimit: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"

														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
												}
												type: "object"
											}
											volumeClaimTemplate: {
												description: "A PVC spec to be used by the VMAlertManager StatefulSets."
												properties: {
													apiVersion: {
														description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

														type: "string"
													}
													kind: {
														description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

														type: "string"
													}
													metadata: {
														description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."

														properties: {
															annotations: {
																additionalProperties: type: "string"
																description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

																type: "object"
															}
															labels: {
																additionalProperties: type: "string"
																description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

																type: "object"
															}
															name: {
																description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

																type: "string"
															}
														}
														type: "object"
													}
													spec: {
														description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

																		type: "string"
																	}
																	kind: {
																		description: "Kind is the type of resource being referenced"

																		type: "string"
																	}
																	name: {
																		description: "Name is the name of resource being referenced"

																		type: "string"
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
																description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

																properties: {
																	apiGroup: {
																		description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																		type: "string"
																	}
																	kind: {
																		description: "Kind is the type of resource being referenced"

																		type: "string"
																	}
																	name: {
																		description: "Name is the name of resource being referenced"

																		type: "string"
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

																		type: "object"
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

																		type: "object"
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

																					type: "string"
																				}
																				operator: {
																					description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																					type: "string"
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

																		type: "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															storageClassName: {
																description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

																type: "string"
															}
															volumeMode: {
																description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

																type: "string"
															}
															volumeName: {
																description: "volumeName is the binding reference to the PersistentVolume backing this claim."

																type: "string"
															}
														}
														type: "object"
													}
													status: {
														description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

														properties: {
															accessModes: {
																description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

																items: type: "string"
																type: "array"
															}
															allocatedResources: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

																type: "object"
															}
															capacity: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "capacity represents the actual resources of the underlying volume."

																type: "object"
															}
															conditions: {
																description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

																items: {
																	description: "PersistentVolumeClaimCondition contails details about state of pvc"

																	properties: {
																		lastProbeTime: {
																			description: "lastProbeTime is the time we probed the condition."

																			format: "date-time"
																			type:   "string"
																		}
																		lastTransitionTime: {
																			description: "lastTransitionTime is the time the condition transitioned from one status to another."

																			format: "date-time"
																			type:   "string"
																		}
																		message: {
																			description: "message is the human-readable message indicating details about last transition."

																			type: "string"
																		}
																		reason: {
																			description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																			type: "string"
																		}
																		status: type: "string"
																		type: {
																			description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																			type: "string"
																		}
																	}
																	required: [
																		"status",
																		"type",
																	]
																	type: "object"
																}
																type: "array"
															}
															phase: {
																description: "phase represents the current phase of PersistentVolumeClaim."

																type: "string"
															}
															resizeStatus: {
																description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

																type: "string"
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
									terminationGracePeriodSeconds: {
										description: "TerminationGracePeriodSeconds period for container graceful termination"

										format: "int64"
										type:   "integer"
									}
									tolerations: {
										description: "Tolerations If specified, the pod's tolerations."
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

													type: "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

													type: "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

													type: "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

													format: "int64"
													type:   "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									topologySpreadConstraints: {
										description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

										items: {
											description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

											required: [
												"maxSkew",
												"topologyKey",
												"whenUnsatisfiable",
											]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									volumeMounts: {
										description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container, that are generated as a result of StorageSpec objects."

										items: {
											description: "VolumeMount describes a mounting of a Volume within a container."

											properties: {
												mountPath: {
													description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

													type: "string"
												}
												mountPropagation: {
													description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

													type: "string"
												}
												name: {
													description: "This must match the Name of a Volume."
													type:        "string"
												}
												readOnly: {
													description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

													type: "boolean"
												}
												subPath: {
													description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

													type: "string"
												}
												subPathExpr: {
													description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

													type: "string"
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
									volumes: {
										description: "Volumes allows configuration of additional volumes on the output Deployment definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

										items: {
											description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
								}
								required: ["replicaCount"]
								type: "object"
							}
							vmstorage: {
								properties: {
									affinity: {
										description:                            "Affinity If specified, the pod's scheduling constraints."
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									claimTemplates: {
										description: "ClaimTemplates allows adding additional VolumeClaimTemplates for StatefulSet"

										items: {
											description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"

											properties: {
												apiVersion: {
													description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

													type: "string"
												}
												kind: {
													description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

													type: "string"
												}
												metadata: {
													description:                            "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												spec: {
													description: "spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

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

																	type: "string"
																}
																kind: {
																	description: "Kind is the type of resource being referenced"

																	type: "string"
																}
																name: {
																	description: "Name is the name of resource being referenced"

																	type: "string"
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
															description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

															properties: {
																apiGroup: {
																	description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																	type: "string"
																}
																kind: {
																	description: "Kind is the type of resource being referenced"

																	type: "string"
																}
																name: {
																	description: "Name is the name of resource being referenced"

																	type: "string"
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

																	type: "object"
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

																	type: "object"
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

																				type: "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																				type: "string"
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

																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: {
															description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

															type: "string"
														}
														volumeMode: {
															description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

															type: "string"
														}
														volumeName: {
															description: "volumeName is the binding reference to the PersistentVolume backing this claim."

															type: "string"
														}
													}
													type: "object"
												}
												status: {
													description: "status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

													properties: {
														accessModes: {
															description: "accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

															items: type: "string"
															type: "array"
														}
														allocatedResources: {
															additionalProperties: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																"x-kubernetes-int-or-string": true
															}
															description: "allocatedResources is the storage resource within AllocatedResources tracks the capacity allocated to a PVC. It may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

															type: "object"
														}
														capacity: {
															additionalProperties: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																"x-kubernetes-int-or-string": true
															}
															description: "capacity represents the actual resources of the underlying volume."

															type: "object"
														}
														conditions: {
															description: "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."

															items: {
																description: "PersistentVolumeClaimCondition contails details about state of pvc"

																properties: {
																	lastProbeTime: {
																		description: "lastProbeTime is the time we probed the condition."

																		format: "date-time"
																		type:   "string"
																	}
																	lastTransitionTime: {
																		description: "lastTransitionTime is the time the condition transitioned from one status to another."

																		format: "date-time"
																		type:   "string"
																	}
																	message: {
																		description: "message is the human-readable message indicating details about last transition."

																		type: "string"
																	}
																	reason: {
																		description: "reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."

																		type: "string"
																	}
																	status: type: "string"
																	type: {
																		description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"

																		type: "string"
																	}
																}
																required: [
																	"status",
																	"type",
																]
																type: "object"
															}
															type: "array"
														}
														phase: {
															description: "phase represents the current phase of PersistentVolumeClaim."
															type:        "string"
														}
														resizeStatus: {
															description: "resizeStatus stores status of resize operation. ResizeStatus is not set by default but when expansion is complete resizeStatus is set to empty string by resize controller or kubelet. This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature."

															type: "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										type: "array"
									}
									configMaps: {
										description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>."

										items: type: "string"
										type: "array"
									}
									containers: {
										description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									dnsConfig: {
										description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

										items: "x-kubernetes-preserve-unknown-fields": true
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
										description: "DNSPolicy sets DNS policy for the pod"
										type:        "string"
									}
									extraArgs: {
										additionalProperties: type: "string"
										type: "object"
									}
									extraEnvs: {
										description: "ExtraEnvs that will be added to VMSelect pod"
										items: {
											description: "EnvVar represents an environment variable present in a Container."

											properties: {
												name: {
													description: "Name of the environment variable. Must be a C_IDENTIFIER."

													type: "string"
												}
												value: {
													description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

													type: "string"
												}
											}
											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									hostNetwork: {
										description: "HostNetwork controls whether the pod may use the node network namespace"

										type: "boolean"
									}
									image: {
										description: "Image - docker image settings for VMStorage"
										properties: {
											pullPolicy: {
												description: "PullPolicy describes how to pull docker image"
												type:        "string"
											}
											repository: {
												description: "Repository contains name of docker image + it's repository if needed"

												type: "string"
											}
											tag: {
												description: "Tag contains desired docker image version"
												type:        "string"
											}
										}
										type: "object"
									}
									initContainers: {
										description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the VMSelect configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

										items: {
											description: "A single application container that you want to run within a pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									livenessProbe: {
										description:                            "LivenessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									logFormat: {
										description: "LogFormat for VMSelect to be configured with. default or json"

										enum: [
											"default",
											"json",
										]
										type: "string"
									}
									logLevel: {
										description: "LogLevel for VMSelect to be configured with."
										enum: [
											"INFO",
											"WARN",
											"ERROR",
											"FATAL",
											"PANIC",
										]
										type: "string"
									}
									maintenanceInsertNodeIDs: {
										description: "MaintenanceInsertNodeIDs - excludes given node ids from insert requests routing, must contain pod suffixes - for pod-0, id will be 0 and etc. lets say, you have pod-0, pod-1, pod-2, pod-3. to exclude pod-0 and pod-3 from insert routing, define nodeIDs: [0,3]. Useful at storage expanding, when you want to rebalance some data at cluster."

										items: {
											format: "int32"
											type:   "integer"
										}
										type: "array"
									}
									maintenanceSelectNodeIDs: {
										description: "MaintenanceInsertNodeIDs - excludes given node ids from select requests routing, must contain pod suffixes - for pod-0, id will be 0 and etc."

										items: {
											format: "int32"
											type:   "integer"
										}
										type: "array"
									}
									name: {
										description: "Name is deprecated and will be removed at 0.22.0 release"

										type: "string"
									}
									nodeSelector: {
										additionalProperties: type: "string"
										description: "NodeSelector Define which Nodes the Pods are scheduled on."

										type: "object"
									}
									podDisruptionBudget: {
										description: "PodDisruptionBudget created by operator"
										properties: {
											maxUnavailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at most \"maxUnavailable\" pods selected by \"selector\" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with \"minAvailable\"."

												"x-kubernetes-int-or-string": true
											}
											minAvailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "An eviction is allowed if at least \"minAvailable\" pods selected by \"selector\" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying \"100%\"."

												"x-kubernetes-int-or-string": true
											}
											selectorLabels: {
												additionalProperties: type: "string"
												description: "replaces default labels selector generated by operator it's useful when you need to create custom budget"

												type: "object"
											}
										}
										type: "object"
									}
									podMetadata: {
										description: "PodMetadata configures Labels and Annotations which are propagated to the VMSelect pods."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									port: {
										description: "Port for health check connetions"
										type:        "string"
									}
									priorityClassName: {
										description: "Priority class assigned to the Pods"
										type:        "string"
									}
									readinessGates: {
										description: "ReadinessGates defines pod readiness gates"
										items: {
											description: "PodReadinessGate contains the reference to a pod condition"

											properties: conditionType: {
												description: "ConditionType refers to a condition in the pod's condition list with matching type."

												type: "string"
											}
											required: ["conditionType"]
											type: "object"
										}
										type: "array"
									}
									readinessProbe: {
										description:                            "ReadinessProbe that will be added CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									replicaCount: {
										description: "ReplicaCount is the expected size of the VMStorage cluster. The controller will eventually make the size of the running cluster equal to the expected size."

										format: "int32"
										type:   "integer"
									}
									resources: {
										description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

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

												type: "object"
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

												type: "object"
											}
										}
										type: "object"
									}
									rollingUpdateStrategy: {
										description: "RollingUpdateStrategy defines strategy for application updates Default is OnDelete, in this case operator handles update process Can be changed for RollingUpdate"

										type: "string"
									}
									runtimeClassName: {
										description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

										type: "string"
									}
									schedulerName: {
										description: "SchedulerName - defines kubernetes scheduler name"
										type:        "string"
									}
									secrets: {
										description: "Secrets is a list of Secrets in the same namespace as the VMSelect object, which shall be mounted into the VMSelect Pods. The Secrets are mounted into /etc/vm/secrets/<secret-name>."

										items: type: "string"
										type: "array"
									}
									securityContext: {
										description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceScrapeSpec: {
										description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

										required: ["endpoints"]
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									serviceSpec: {
										description: "ServiceSpec that will be create additional service for vmstorage"

										properties: {
											metadata: {
												description: "EmbeddedObjectMetadata defines objectMeta for additional service."

												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

														type: "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

														type: "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										required: ["spec"]
										type: "object"
									}
									startupProbe: {
										description:                            "StartupProbe that will be added to CRD pod"
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									storage: {
										description: "Storage - add persistent volume for StorageDataPath its useful for persistent cache"

										properties: {
											disableMountSubPath: {
												description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."

												type: "boolean"
											}
											emptyDir: {
												description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"

												properties: {
													medium: {
														description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

														type: "string"
													}
													sizeLimit: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"

														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
												}
												type: "object"
											}
											volumeClaimTemplate: {
												description:                            "A PVC spec to be used by the VMAlertManager StatefulSets."
												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										type: "object"
									}
									storageDataPath: {
										description: "StorageDataPath - path to storage data"
										type:        "string"
									}
									terminationGracePeriodSeconds: {
										description: "TerminationGracePeriodSeconds period for container graceful termination"

										format: "int64"
										type:   "integer"
									}
									tolerations: {
										description: "Tolerations If specified, the pod's tolerations."
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

													type: "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

													type: "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

													type: "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

													format: "int64"
													type:   "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									topologySpreadConstraints: {
										description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

										items: {
											description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

											required: [
												"maxSkew",
												"topologyKey",
												"whenUnsatisfiable",
											]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
									vmBackup: {
										description: "VMBackup configuration for backup"
										properties: {
											acceptEULA: {
												description: "AcceptEULA accepts enterprise feature usage, must be set to true. otherwise backupmanager cannot be added to single/cluster version. https://victoriametrics.com/legal/eula/"

												type: "boolean"
											}
											concurrency: {
												description: "Defines number of concurrent workers. Higher concurrency may reduce backup duration (default 10)"

												format: "int32"
												type:   "integer"
											}
											credentialsSecret: {
												description: "CredentialsSecret is secret in the same namespace for access to remote storage The secret is mounted into /etc/vm/creds."

												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											customS3Endpoint: {
												description: "Custom S3 endpoint for use with S3-compatible storages (e.g. MinIO). S3 is used if not set"

												type: "string"
											}
											destination: {
												description: "Defines destination for backup"
												type:        "string"
											}
											destinationDisableSuffixAdd: {
												description: "DestinationDisableSuffixAdd - disables suffix adding for cluster version backups each vmstorage backup must have unique backup folder so operator adds POD_NAME as suffix for backup destination folder."

												type: "boolean"
											}
											disableDaily: {
												description: "Defines if daily backups disabled (default false)"
												type:        "boolean"
											}
											disableHourly: {
												description: "Defines if hourly backups disabled (default false)"
												type:        "boolean"
											}
											disableMonthly: {
												description: "Defines if monthly backups disabled (default false)"

												type: "boolean"
											}
											disableWeekly: {
												description: "Defines if weekly backups disabled (default false)"
												type:        "boolean"
											}
											extraArgs: {
												additionalProperties: type: "string"
												description: "extra args like maxBytesPerSecond default 0"
												type:        "object"
											}
											extraEnvs: {
												items: {
													description: "EnvVar represents an environment variable present in a Container."

													properties: {
														name: {
															description: "Name of the environment variable. Must be a C_IDENTIFIER."

															type: "string"
														}
														value: {
															description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

															type: "string"
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

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the ConfigMap or its key must be defined"

																			type: "boolean"
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

																			type: "string"
																		}
																		fieldPath: {
																			description: "Path of the field to select in the specified API version."

																			type: "string"
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

																			type: "string"
																		}
																		divisor: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			description: "Specifies the output format of the exposed resources, defaults to \"1\""

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

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
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
											image: {
												description: "Image - docker image settings for VMBackuper"
												properties: {
													pullPolicy: {
														description: "PullPolicy describes how to pull docker image"
														type:        "string"
													}
													repository: {
														description: "Repository contains name of docker image + it's repository if needed"

														type: "string"
													}
													tag: {
														description: "Tag contains desired docker image version"
														type:        "string"
													}
												}
												type: "object"
											}
											logFormat: {
												description: "LogFormat for VMSelect to be configured with. default or json"

												enum: [
													"default",
													"json",
												]
												type: "string"
											}
											logLevel: {
												description: "LogLevel for VMSelect to be configured with."
												enum: [
													"INFO",
													"WARN",
													"ERROR",
													"FATAL",
													"PANIC",
												]
												type: "string"
											}
											port: {
												description: "Port for health check connections"
												type:        "string"
											}
											resources: {
												description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ if not defined default resources from operator config will be used"

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

														type: "object"
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

														type: "object"
													}
												}
												type: "object"
											}
											restore: {
												description: "Restore Allows to enable restore options for pod Read more: https://docs.victoriametrics.com/vmbackupmanager.html#restore-commands"

												properties: onStart: {
													description: "OnStart defines configuration for restore on pod start"

													properties: enabled: {
														description: "Enabled defines if restore on start enabled"
														type:        "boolean"
													}
													type: "object"
												}
												type: "object"
											}
											snapshotCreateURL: {
												description: "SnapshotCreateURL overwrites url for snapshot create"

												type: "string"
											}
											snapshotDeleteURL: {
												description: "SnapShotDeleteURL overwrites url for snapshot delete"

												type: "string"
											}
											volumeMounts: {
												description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the vmbackupmanager container, that are generated as a result of StorageSpec objects."

												items: {
													description: "VolumeMount describes a mounting of a Volume within a container."

													properties: {
														mountPath: {
															description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

															type: "string"
														}
														mountPropagation: {
															description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

															type: "string"
														}
														name: {
															description: "This must match the Name of a Volume."
															type:        "string"
														}
														readOnly: {
															description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

															type: "boolean"
														}
														subPath: {
															description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

															type: "string"
														}
														subPathExpr: {
															description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

															type: "string"
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
										}
										required: ["acceptEULA"]
										type: "object"
									}
									vmInsertPort: {
										description: "VMInsertPort for VMInsert connections"
										type:        "string"
									}
									vmSelectPort: {
										description: "VMSelectPort for VMSelect connections"
										type:        "string"
									}
									volumeMounts: {
										description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMSelect container, that are generated as a result of StorageSpec objects."

										items: {
											description: "VolumeMount describes a mounting of a Volume within a container."

											properties: {
												mountPath: {
													description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

													type: "string"
												}
												mountPropagation: {
													description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

													type: "string"
												}
												name: {
													description: "This must match the Name of a Volume."
													type:        "string"
												}
												readOnly: {
													description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

													type: "boolean"
												}
												subPath: {
													description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

													type: "string"
												}
												subPathExpr: {
													description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

													type: "string"
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
									volumes: {
										description: "Volumes allows configuration of additional volumes on the output Deployment definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

										items: {
											description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

											required: ["name"]
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										type: "array"
									}
								}
								required: ["replicaCount"]
								type: "object"
							}
						}, required: [
							"retentionPeriod",
						], type:
							"object"
					}, status: {
						description:
							"VMClusterStatus defines the observed state of VMCluster", properties: {

							clusterStatus: type: "string"
							lastSync: {
								description: "Deprecated."
								type:        "string"
							}
							reason: type: "string"
							updateFailCount: {
								description: "Deprecated."
								type:        "integer"
							}
						}, required: [
							"clusterStatus",
							"updateFailCount",
						], type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmnodescrapes.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMNodeScrape"
				listKind:
					"VMNodeScrapeList", plural: "vmnodescrapes"
				singular:
					"vmnodescrape"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMNodeScrape defines discovery for targets placed on kubernetes nodes, usually its node-exporters and other host services. InternalIP is used as __address__ for scraping."

				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMNodeScrapeSpec defines specification for VMNodeScrape.", properties: {

							authorization: {
								description: "Authorization with http header Authorization"
								properties: {
									credentials: {
										description: "Reference to the secret with value for authorization"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									credentialsFile: {
										description: "File with value for authorization"
										type:        "string"
									}
									type: {
										description: "Type of authorization, default to bearer"
										type:        "string"
									}
								}
								type: "object"
							}
							basicAuth: {
								description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"

								properties: {
									password: {
										description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									password_file: {
										description: "PasswordFile defines path to password file at disk"
										type:        "string"
									}
									username: {
										description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
								}
								type: "object"
							}
							bearerTokenFile: {
								description: "File to read bearer token for scraping targets."
								type:        "string"
							}
							bearerTokenSecret: {
								description: "Secret to mount to read bearer token for scraping targets. The secret needs to be  accessible by the victoria-metrics operator."

								nullable: true
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
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
							follow_redirects: {
								description: "FollowRedirects controls redirects for scraping."
								type:        "boolean"
							}
							honorLabels: {
								description: "HonorLabels chooses the metric's labels on collisions with target labels."

								type: "boolean"
							}
							honorTimestamps: {
								description: "HonorTimestamps controls whether vmagent respects the timestamps present in scraped data."

								type: "boolean"
							}
							interval: {
								description: "Interval at which metrics should be scraped"
								type:        "string"
							}
							jobLabel: {
								description: "The label to use to retrieve the job name from."
								type:        "string"
							}
							metricRelabelConfigs: {
								description: "MetricRelabelConfigs to apply to samples before ingestion."
								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							oauth2: {
								description: "OAuth2 defines auth configuration"
								properties: {
									client_id: {
										description: "The secret or configmap containing the OAuth2 client id"

										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									client_secret: {
										description: "The secret containing the OAuth2 client secret"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									client_secret_file: {
										description: "ClientSecretFile defines path for client secret file."
										type:        "string"
									}
									endpoint_params: {
										additionalProperties: type: "string"
										description: "Parameters to append to the token URL"
										type:        "object"
									}
									scopes: {
										description: "OAuth2 scopes used for the token request"
										items: type: "string"
										type: "array"
									}
									token_url: {
										description: "The URL to fetch the token from"
										minLength:   1
										type:        "string"
									}
								}
								required: [
									"client_id",
									"token_url",
								]
								type: "object"
							}
							params: {
								additionalProperties: {
									items: type: "string"
									type: "array"
								}
								description: "Optional HTTP URL parameters"
								type:        "object"
							}
							path: {
								description: "HTTP path to scrape for metrics."
								type:        "string"
							}
							port: {
								description: "Name of the port exposed at Node."
								type:        "string"
							}
							proxyURL: {
								description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."

								type: "string"
							}
							relabelConfigs: {
								description: "RelabelConfigs to apply to samples before scraping. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"

								items: {
									description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

									properties: {
										action: {
											description: "Action to perform based on regex matching. Default is 'replace'"

											type: "string"
										}
										if: {
											description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels is used together with Match for `action: graphite`"

											type: "object"
										}
										match: {
											description: "Match is used together with Labels for `action: graphite`"

											type: "string"
										}
										modulus: {
											description: "Modulus to take of the hash of the source label values."

											format: "int64"
											type:   "integer"
										}
										regex: {
											description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

											type: "string"
										}
										replacement: {
											description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

											type: "string"
										}
										separator: {
											description: "Separator placed between concatenated source label values. default is ';'."

											type: "string"
										}
										source_labels: {
											description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											items: type: "string"
											type: "array"
										}
										sourceLabels: {
											description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

											items: type: "string"
											type: "array"
										}
										target_label: {
											description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

											type: "string"
										}
										targetLabel: {
											description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

								format: "int64"
								type:   "integer"
							}
							scheme: {
								description: "HTTP scheme to use for scraping."
								type:        "string"
							}
							scrape_interval: {
								description: "ScrapeInterval is the same as Interval and has priority over it. one of scrape_interval or interval can be used"

								type: "string"
							}
							scrapeTimeout: {
								description: "Timeout after which the scrape is ended"
								type:        "string"
							}
							selector: {
								description: "Selector to select kubernetes Nodes."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							targetLabels: {
								description: "TargetLabels transfers labels on the Kubernetes Node onto the target."

								items: type: "string"
								type: "array"
							}
							tlsConfig: {
								description: "TLSConfig specifies TLSConfig configuration parameters."
								properties: {
									ca: {
										description: "Stuct containing the CA cert to use for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									caFile: {
										description: "Path to the CA cert in the container to use for the targets."

										type: "string"
									}
									cert: {
										description: "Struct containing the client cert file for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									certFile: {
										description: "Path to the client cert file in the container for the targets."

										type: "string"
									}
									insecureSkipVerify: {
										description: "Disable target certificate validation."
										type:        "boolean"
									}
									keyFile: {
										description: "Path to the client key file in the container for the targets."

										type: "string"
									}
									keySecret: {
										description: "Secret containing the client key file for the targets."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									serverName: {
										description: "Used to verify the hostname for the targets."
										type:        "string"
									}
								}
								type: "object"
							}
							vm_scrape_params: {
								description: "VMScrapeParams defines VictoriaMetrics specific scrape parametrs"

								properties: {
									disable_compression: type: "boolean"
									disable_keep_alive: type:  "boolean"
									headers: {
										description: "Headers allows sending custom headers to scrape targets must be in of semicolon separated header with it's value eg: headerName: headerValue vmagent supports since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									metric_relabel_debug: type: "boolean"
									no_stale_markers: type:     "boolean"
									proxy_client_config: {
										description: "ProxyClientConfig configures proxy auth settings for scraping See feature description https://docs.victoriametrics.com/vmagent.html#scraping-targets-via-a-proxy"

										properties: {
											basic_auth: {
												description: "BasicAuth allow an endpoint to authenticate over basic authentication"

												properties: {
													password: {
														description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													password_file: {
														description: "PasswordFile defines path to password file at disk"

														type: "string"
													}
													username: {
														description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											bearer_token: {
												description: "SecretKeySelector selects a key of a Secret."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											bearer_token_file: type: "string"
											tls_config: {
												description: "TLSConfig specifies TLSConfig configuration parameters."
												properties: {
													ca: {
														description: "Stuct containing the CA cert to use for the targets."

														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																description: "Secret containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													caFile: {
														description: "Path to the CA cert in the container to use for the targets."

														type: "string"
													}
													cert: {
														description: "Struct containing the client cert file for the targets."

														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																description: "Secret containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													certFile: {
														description: "Path to the client cert file in the container for the targets."

														type: "string"
													}
													insecureSkipVerify: {
														description: "Disable target certificate validation."
														type:        "boolean"
													}
													keyFile: {
														description: "Path to the client key file in the container for the targets."

														type: "string"
													}
													keySecret: {
														description: "Secret containing the client key file for the targets."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													serverName: {
														description: "Used to verify the hostname for the targets."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									relabel_debug: type:         "boolean"
									scrape_align_interval: type: "string"
									scrape_offset: type:         "string"
									stream_parse: type:          "boolean"
								}
								type: "object"
							}
						}, type:
							"object"
					}, status: {
						description:
							"VMNodeScrapeStatus defines the observed state of VMNodeScrape", type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmpodscrapes.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMPodScrape"
				listKind:
					"VMPodScrapeList", plural: "vmpodscrapes"
				singular:
					"vmpodscrape"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMPodScrape is scrape configuration for pods, it generates vmagent's config for scraping pod targets based on selectors."
				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMPodScrapeSpec defines the desired state of VMPodScrape", properties: {

							jobLabel: {
								description: "The label to use to retrieve the job name from."
								type:        "string"
							}
							namespaceSelector: {
								description: "Selector to select which namespaces the Endpoints objects are discovered from."

								properties: {
									any: {
										description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."

										type: "boolean"
									}
									matchNames: {
										description: "List of namespace names."
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podMetricsEndpoints: {
								description: "A list of endpoints allowed as part of this PodMonitor."
								items: {
									description: "PodMetricsEndpoint defines a scrapeable endpoint of a Kubernetes Pod serving Prometheus metrics."

									properties: {
										attach_metadata: {
											description: "AttachMetadata configures metadata attaching from service discovery"

											properties: node: {
												description: "Node instructs vmagent to add node specific metadata from service discovery Valid for roles: pod, endpoints, endpointslice."

												type: "boolean"
											}
											type: "object"
										}
										authorization: {
											description: "Authorization with http header Authorization"
											properties: {
												credentials: {
													description: "Reference to the secret with value for authorization"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: {
													description: "File with value for authorization"
													type:        "string"
												}
												type: {
													description: "Type of authorization, default to bearer"
													type:        "string"
												}
											}
											type: "object"
										}
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"

											properties: {
												password: {
													description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												password_file: {
													description: "PasswordFile defines path to password file at disk"

													type: "string"
												}
												username: {
													description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenFile: {
											description: "File to read bearer token for scraping targets."
											type:        "string"
										}
										bearerTokenSecret: {
											description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service scrape and accessible by the victoria-metrics operator."

											nullable: true
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."

													type: "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"

													type: "boolean"
												}
											}
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										filterRunning: {
											description: "FilterRunning applies filter with pod status == running it prevents from scrapping metrics at failed or succeed state pods. enabled by default"

											type: "boolean"
										}
										follow_redirects: {
											description: "FollowRedirects controls redirects for scraping."
											type:        "boolean"
										}
										honorLabels: {
											description: "HonorLabels chooses the metric's labels on collisions with target labels."

											type: "boolean"
										}
										honorTimestamps: {
											description: "HonorTimestamps controls whether vmagent respects the timestamps present in scraped data."

											type: "boolean"
										}
										interval: {
											description: "Interval at which metrics should be scraped"
											type:        "string"
										}
										metricRelabelConfigs: {
											description: "MetricRelabelConfigs to apply to samples before ingestion."

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											description: "OAuth2 defines auth configuration"
											properties: {
												client_id: {
													description: "The secret or configmap containing the OAuth2 client id"

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												client_secret: {
													description: "The secret containing the OAuth2 client secret"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												client_secret_file: {
													description: "ClientSecretFile defines path for client secret file."

													type: "string"
												}
												endpoint_params: {
													additionalProperties: type: "string"
													description: "Parameters to append to the token URL"
													type:        "object"
												}
												scopes: {
													description: "OAuth2 scopes used for the token request"
													items: type: "string"
													type: "array"
												}
												token_url: {
													description: "The URL to fetch the token from"
													minLength:   1
													type:        "string"
												}
											}
											required: [
												"client_id",
												"token_url",
											]
											type: "object"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											description: "Optional HTTP URL parameters"
											type:        "object"
										}
										path: {
											description: "HTTP path to scrape for metrics."
											type:        "string"
										}
										port: {
											description: "Name of the pod port this endpoint refers to. Mutually exclusive with targetPort."

											type: "string"
										}
										proxyURL: {
											description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."

											type: "string"
										}
										relabelConfigs: {
											description: "RelabelConfigs to apply to samples before ingestion. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										sampleLimit: {
											description: "SampleLimit defines per-podEndpoint limit on number of scraped samples that will be accepted."

											format: "int64"
											type:   "integer"
										}
										scheme: {
											description: "HTTP scheme to use for scraping."
											type:        "string"
										}
										scrape_interval: {
											description: "ScrapeInterval is the same as Interval and has priority over it. one of scrape_interval or interval can be used"

											type: "string"
										}
										scrapeTimeout: {
											description: "Timeout after which the scrape is ended"
											type:        "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description:                  "Deprecated: Use 'port' instead."
											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											description: "TLSConfig configuration to use when scraping the endpoint"

											properties: {
												ca: {
													description: "Stuct containing the CA cert to use for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the container to use for the targets."

													type: "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the container for the targets."

													type: "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the container for the targets."

													type: "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										vm_scrape_params: {
											description: "VMScrapeParams defines VictoriaMetrics specific scrape parametrs"

											properties: {
												disable_compression: type: "boolean"
												disable_keep_alive: type:  "boolean"
												headers: {
													description: "Headers allows sending custom headers to scrape targets must be in of semicolon separated header with it's value eg: headerName: headerValue vmagent supports since 1.79.0 version"

													items: type: "string"
													type: "array"
												}
												metric_relabel_debug: type: "boolean"
												no_stale_markers: type:     "boolean"
												proxy_client_config: {
													description: "ProxyClientConfig configures proxy auth settings for scraping See feature description https://docs.victoriametrics.com/vmagent.html#scraping-targets-via-a-proxy"

													properties: {
														basic_auth: {
															description: "BasicAuth allow an endpoint to authenticate over basic authentication"

															properties: {
																password: {
																	description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																password_file: {
																	description: "PasswordFile defines path to password file at disk"

																	type: "string"
																}
																username: {
																	description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
															}
															type: "object"
														}
														bearer_token: {
															description: "SecretKeySelector selects a key of a Secret."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														bearer_token_file: type: "string"
														tls_config: {
															description: "TLSConfig specifies TLSConfig configuration parameters."

															properties: {
																ca: {
																	description: "Stuct containing the CA cert to use for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																caFile: {
																	description: "Path to the CA cert in the container to use for the targets."

																	type: "string"
																}
																cert: {
																	description: "Struct containing the client cert file for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																certFile: {
																	description: "Path to the client cert file in the container for the targets."

																	type: "string"
																}
																insecureSkipVerify: {
																	description: "Disable target certificate validation."
																	type:        "boolean"
																}
																keyFile: {
																	description: "Path to the client key file in the container for the targets."

																	type: "string"
																}
																keySecret: {
																	description: "Secret containing the client key file for the targets."

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																serverName: {
																	description: "Used to verify the hostname for the targets."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												relabel_debug: type:         "boolean"
												scrape_align_interval: type: "string"
												scrape_offset: type:         "string"
												stream_parse: type:          "boolean"
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							podTargetLabels: {
								description: "PodTargetLabels transfers labels on the Kubernetes Pod onto the target."

								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

								format: "int64"
								type:   "integer"
							}
							selector: {
								description: "Selector to select Pod objects."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
						}, required: [
							"podMetricsEndpoints",
						], type:
							"object"
					}, status: {
						description:
							"VMPodScrapeStatus defines the observed state of VMPodScrape", type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmprobes.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMProbe"
				listKind:
					"VMProbeList", plural: "vmprobes"
				singular:
					"vmprobe"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMProbe defines a probe for targets, that will be executed with prober, like blackbox exporter. It helps to monitor reachability of target with various checks."

				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMProbeSpec contains specification parameters for a Probe.", properties: {

							authorization: {
								description: "Authorization with http header Authorization"
								properties: {
									credentials: {
										description: "Reference to the secret with value for authorization"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									credentialsFile: {
										description: "File with value for authorization"
										type:        "string"
									}
									type: {
										description: "Type of authorization, default to bearer"
										type:        "string"
									}
								}
								type: "object"
							}
							basicAuth: {
								description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"

								properties: {
									password: {
										description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									password_file: {
										description: "PasswordFile defines path to password file at disk"
										type:        "string"
									}
									username: {
										description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
								}
								type: "object"
							}
							bearerTokenFile: {
								description: "File to read bearer token for scraping targets."
								type:        "string"
							}
							bearerTokenSecret: {
								description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service scrape and accessible by the victoria-metrics operator."

								nullable: true
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
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
							follow_redirects: {
								description: "FollowRedirects controls redirects for scraping."
								type:        "boolean"
							}
							interval: {
								description: "Interval at which targets are probed using the configured prober. If not specified Prometheus' global scrape interval is used."

								type: "string"
							}
							jobName: {
								description: "The job name assigned to scraped metrics by default."
								type:        "string"
							}
							module: {
								description: "The module to use for probing specifying how to probe the target. Example module configuring in the blackbox exporter: https://github.com/prometheus/blackbox_exporter/blob/master/example.yml"

								type: "string"
							}
							oauth2: {
								description: "OAuth2 defines auth configuration"
								properties: {
									client_id: {
										description: "The secret or configmap containing the OAuth2 client id"

										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									client_secret: {
										description: "The secret containing the OAuth2 client secret"
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									client_secret_file: {
										description: "ClientSecretFile defines path for client secret file."
										type:        "string"
									}
									endpoint_params: {
										additionalProperties: type: "string"
										description: "Parameters to append to the token URL"
										type:        "object"
									}
									scopes: {
										description: "OAuth2 scopes used for the token request"
										items: type: "string"
										type: "array"
									}
									token_url: {
										description: "The URL to fetch the token from"
										minLength:   1
										type:        "string"
									}
								}
								required: [
									"client_id",
									"token_url",
								]
								type: "object"
							}
							params: {
								additionalProperties: {
									items: type: "string"
									type: "array"
								}
								description: "Optional HTTP URL parameters"
								type:        "object"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

								format: "int64"
								type:   "integer"
							}
							scrape_interval: {
								description: "ScrapeInterval is the same as Interval and has priority over it. one of scrape_interval or interval can be used"

								type: "string"
							}
							scrapeTimeout: {
								description: "Timeout for scraping metrics from the Prometheus exporter."
								type:        "string"
							}
							targets: {
								description: "Targets defines a set of static and/or dynamically discovered targets to be probed using the prober."

								properties: {
									ingress: {
										description: "Ingress defines the set of dynamically discovered ingress objects which hosts are considered for probing."

										properties: {
											namespaceSelector: {
												description: "Select Ingress objects by namespace."
												properties: {
													any: {
														description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."

														type: "boolean"
													}
													matchNames: {
														description: "List of namespace names."
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											relabelingConfigs: {
												description: "RelabelConfigs to apply to samples before ingestion. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"

												items: {
													description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

													properties: {
														action: {
															description: "Action to perform based on regex matching. Default is 'replace'"

															type: "string"
														}
														if: {
															description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

															type: "string"
														}
														labels: {
															additionalProperties: type: "string"
															description: "Labels is used together with Match for `action: graphite`"

															type: "object"
														}
														match: {
															description: "Match is used together with Labels for `action: graphite`"

															type: "string"
														}
														modulus: {
															description: "Modulus to take of the hash of the source label values."

															format: "int64"
															type:   "integer"
														}
														regex: {
															description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

															type: "string"
														}
														replacement: {
															description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

															type: "string"
														}
														separator: {
															description: "Separator placed between concatenated source label values. default is ';'."

															type: "string"
														}
														source_labels: {
															description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

															items: type: "string"
															type: "array"
														}
														sourceLabels: {
															description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

															items: type: "string"
															type: "array"
														}
														target_label: {
															description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

															type: "string"
														}
														targetLabel: {
															description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											selector: {
												description: "Select Ingress objects by labels."
												properties: {
													matchExpressions: {
														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

														items: {
															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

															properties: {
																key: {
																	description: "key is the label key that the selector applies to."

																	type: "string"
																}
																operator: {
																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																	type: "string"
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

														type: "object"
													}
												}
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									staticConfig: {
										description: "StaticConfig defines static targets which are considers for probing. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config."

										properties: {
											labels: {
												additionalProperties: type: "string"
												description: "Labels assigned to all metrics scraped from the targets."

												type: "object"
											}
											relabelingConfigs: {
												description: "More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
												items: {
													description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

													properties: {
														action: {
															description: "Action to perform based on regex matching. Default is 'replace'"

															type: "string"
														}
														if: {
															description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

															type: "string"
														}
														labels: {
															additionalProperties: type: "string"
															description: "Labels is used together with Match for `action: graphite`"

															type: "object"
														}
														match: {
															description: "Match is used together with Labels for `action: graphite`"

															type: "string"
														}
														modulus: {
															description: "Modulus to take of the hash of the source label values."

															format: "int64"
															type:   "integer"
														}
														regex: {
															description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

															type: "string"
														}
														replacement: {
															description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

															type: "string"
														}
														separator: {
															description: "Separator placed between concatenated source label values. default is ';'."

															type: "string"
														}
														source_labels: {
															description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

															items: type: "string"
															type: "array"
														}
														sourceLabels: {
															description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

															items: type: "string"
															type: "array"
														}
														target_label: {
															description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

															type: "string"
														}
														targetLabel: {
															description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											targets: {
												description: "Targets is a list of URLs to probe using the configured prober."

												items: type: "string"
												type: "array"
											}
										}
										required: ["targets"]
										type: "object"
									}
								}
								type: "object"
							}
							tlsConfig: {
								description: "TLSConfig configuration to use when scraping the endpoint"
								properties: {
									ca: {
										description: "Stuct containing the CA cert to use for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									caFile: {
										description: "Path to the CA cert in the container to use for the targets."

										type: "string"
									}
									cert: {
										description: "Struct containing the client cert file for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									certFile: {
										description: "Path to the client cert file in the container for the targets."

										type: "string"
									}
									insecureSkipVerify: {
										description: "Disable target certificate validation."
										type:        "boolean"
									}
									keyFile: {
										description: "Path to the client key file in the container for the targets."

										type: "string"
									}
									keySecret: {
										description: "Secret containing the client key file for the targets."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									serverName: {
										description: "Used to verify the hostname for the targets."
										type:        "string"
									}
								}
								type: "object"
							}
							vm_scrape_params: {
								description: "VMScrapeParams defines VictoriaMetrics specific scrape parametrs"

								properties: {
									disable_compression: type: "boolean"
									disable_keep_alive: type:  "boolean"
									headers: {
										description: "Headers allows sending custom headers to scrape targets must be in of semicolon separated header with it's value eg: headerName: headerValue vmagent supports since 1.79.0 version"

										items: type: "string"
										type: "array"
									}
									metric_relabel_debug: type: "boolean"
									no_stale_markers: type:     "boolean"
									proxy_client_config: {
										description: "ProxyClientConfig configures proxy auth settings for scraping See feature description https://docs.victoriametrics.com/vmagent.html#scraping-targets-via-a-proxy"

										properties: {
											basic_auth: {
												description: "BasicAuth allow an endpoint to authenticate over basic authentication"

												properties: {
													password: {
														description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													password_file: {
														description: "PasswordFile defines path to password file at disk"

														type: "string"
													}
													username: {
														description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											bearer_token: {
												description: "SecretKeySelector selects a key of a Secret."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."

														type: "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

														type: "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"

														type: "boolean"
													}
												}
												required: ["key"]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											bearer_token_file: type: "string"
											tls_config: {
												description: "TLSConfig specifies TLSConfig configuration parameters."
												properties: {
													ca: {
														description: "Stuct containing the CA cert to use for the targets."

														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																description: "Secret containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													caFile: {
														description: "Path to the CA cert in the container to use for the targets."

														type: "string"
													}
													cert: {
														description: "Struct containing the client cert file for the targets."

														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																description: "Secret containing data to use for the targets."

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													certFile: {
														description: "Path to the client cert file in the container for the targets."

														type: "string"
													}
													insecureSkipVerify: {
														description: "Disable target certificate validation."
														type:        "boolean"
													}
													keyFile: {
														description: "Path to the client key file in the container for the targets."

														type: "string"
													}
													keySecret: {
														description: "Secret containing the client key file for the targets."

														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."

																type: "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"

																type: "boolean"
															}
														}
														required: ["key"]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													serverName: {
														description: "Used to verify the hostname for the targets."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									relabel_debug: type:         "boolean"
									scrape_align_interval: type: "string"
									scrape_offset: type:         "string"
									stream_parse: type:          "boolean"
								}
								type: "object"
							}
							vmProberSpec: {
								description: "Specification for the prober to use for probing targets. The prober.URL parameter is required. Targets cannot be probed if left empty."

								properties: {
									path: {
										description: "Path to collect metrics from. Defaults to `/probe`."
										type:        "string"
									}
									scheme: {
										description: "HTTP scheme to use for scraping. Defaults to `http`."
										type:        "string"
									}
									url: {
										description: "Mandatory URL of the prober."
										type:        "string"
									}
								}
								required: ["url"]
								type: "object"
							}
						}, required: [
							"vmProberSpec",
						], type:
							"object"
					}, status: {
						description:
							"VMProbeStatus defines the observed state of VMProbe", type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmrules.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMRule"
				listKind:
					"VMRuleList", plural: "vmrules"
				singular:
					"vmrule"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMRule defines rule records for vmalert application", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMRuleSpec defines the desired state of VMRule", properties: groups: {
							description: "Groups list of group rules"
							items: {
								description: "RuleGroup is a list of sequentially evaluated recording and alerting rules."

								properties: {
									concurrency: {
										description: "Concurrency defines how many rules execute at once."
										type:        "integer"
									}
									extra_filter_labels: {
										additionalProperties: type: "string"
										description: "ExtraFilterLabels optional list of label filters applied to every rule's request withing a group. Is compatible only with VM datasource. See more details at https://docs.victoriametrics.com#prometheus-querying-api-enhancements Deprecated, use params instead"

										type: "object"
									}
									headers: {
										description: "Headers contains optional HTTP headers added to each rule request Must be in form `header-name: value` For example: headers: - \"CustomHeader: foo\" - \"CustomHeader2: bar\""

										items: type: "string"
										type: "array"
									}
									interval: {
										description: "evaluation interval for group"
										type:        "string"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels optional list of labels added to every rule within a group. It has priority over the external labels. Labels are commonly used for adding environment or tenant-specific tag."

										type: "object"
									}
									limit: {
										description: "Limit the number of alerts an alerting rule and series a recording rule can produce"

										type: "integer"
									}
									name: {
										description: "Name of group"
										type:        "string"
									}
									notifier_headers: {
										description: "NotifierHeaders contains optional HTTP headers added to each alert request which will send to notifier Must be in form `header-name: value` For example: headers: - \"CustomHeader: foo\" - \"CustomHeader2: bar\""

										items: type: "string"
										type: "array"
									}
									params: {
										additionalProperties: {
											items: type: "string"
											type: "array"
										}
										description: "Params optional HTTP URL parameters added to each rule request"

										type: "object"
									}
									rules: {
										description: "Rules list of alert rules"
										items: {
											description: "Rule describes an alerting or recording rule."
											properties: {
												alert: {
													description: "Alert is a name for alert"
													type:        "string"
												}
												annotations: {
													additionalProperties: type: "string"
													description: "Annotations will be added to rule configuration"
													type:        "object"
												}
												debug: {
													description: "Debug enables logging for rule it useful for tracking"

													type: "boolean"
												}
												expr: {
													description: "Expr is query, that will be evaluated at dataSource"

													type: "string"
												}
												for: {
													description: "For evaluation interval in time.Duration format 30s, 1m, 1h  or nanoseconds"

													type: "string"
												}
												labels: {
													additionalProperties: type: "string"
													description: "Labels will be added to rule configuration"
													type:        "object"
												}
												record: {
													description: "Record represents a query, that will be recorded to dataSource"

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									tenant: {
										description: "Tenant id for group, can be used only with enterprise version of vmalert See more details at https://docs.victoriametrics.com/vmalert.html#multitenancy"

										type: "string"
									}
									type: {
										description: "Type defines datasource type for enterprise version of vmalert possible values - prometheus,graphite"

										type: "string"
									}
								}
								required: [
									"name",
									"rules",
								]
								type: "object"
							}
							type: "array"
						}, required: [
							"groups",
						], type:
							"object"
					}, status: {
						description:
							"VMRuleStatus defines the observed state of VMRule", type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmservicescrapes.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMServiceScrape"
				listKind:
					"VMServiceScrapeList", plural: "vmservicescrapes"
				singular:
					"vmservicescrape"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMServiceScrape is scrape configuration for endpoints associated with kubernetes service, it generates scrape configuration for vmagent based on selectors. result config will scrape service endpoints"

				properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMServiceScrapeSpec defines the desired state of VMServiceScrape", properties: {

							discoveryRole: {
								description: "DiscoveryRole - defines kubernetes_sd role for objects discovery. by default, its endpoints. can be changed to service or endpointslices. note, that with service setting, you have to use port: \"name\" and cannot use targetPort for endpoints."

								enum: [
									"endpoints",
									"service",
									"endpointslices",
								]
								type: "string"
							}
							endpoints: {
								description: "A list of endpoints allowed as part of this ServiceScrape."
								items: {
									description: "Endpoint defines a scrapeable endpoint serving Prometheus metrics."

									properties: {
										attach_metadata: {
											description: "AttachMetadata configures metadata attaching from service discovery"

											properties: node: {
												description: "Node instructs vmagent to add node specific metadata from service discovery Valid for roles: pod, endpoints, endpointslice."

												type: "boolean"
											}
											type: "object"
										}
										authorization: {
											description: "Authorization with http header Authorization"
											properties: {
												credentials: {
													description: "Reference to the secret with value for authorization"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: {
													description: "File with value for authorization"
													type:        "string"
												}
												type: {
													description: "Type of authorization, default to bearer"
													type:        "string"
												}
											}
											type: "object"
										}
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"

											properties: {
												password: {
													description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												password_file: {
													description: "PasswordFile defines path to password file at disk"

													type: "string"
												}
												username: {
													description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenFile: {
											description: "File to read bearer token for scraping targets."
											type:        "string"
										}
										bearerTokenSecret: {
											description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service scrape and accessible by the victoria-metrics operator."

											nullable: true
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."

													type: "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"

													type: "boolean"
												}
											}
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										follow_redirects: {
											description: "FollowRedirects controls redirects for scraping."
											type:        "boolean"
										}
										honorLabels: {
											description: "HonorLabels chooses the metric's labels on collisions with target labels."

											type: "boolean"
										}
										honorTimestamps: {
											description: "HonorTimestamps controls whether vmagent respects the timestamps present in scraped data."

											type: "boolean"
										}
										interval: {
											description: "Interval at which metrics should be scraped"
											type:        "string"
										}
										metricRelabelConfigs: {
											description: "MetricRelabelConfigs to apply to samples before ingestion."

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											description: "OAuth2 defines auth configuration"
											properties: {
												client_id: {
													description: "The secret or configmap containing the OAuth2 client id"

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												client_secret: {
													description: "The secret containing the OAuth2 client secret"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												client_secret_file: {
													description: "ClientSecretFile defines path for client secret file."

													type: "string"
												}
												endpoint_params: {
													additionalProperties: type: "string"
													description: "Parameters to append to the token URL"
													type:        "object"
												}
												scopes: {
													description: "OAuth2 scopes used for the token request"
													items: type: "string"
													type: "array"
												}
												token_url: {
													description: "The URL to fetch the token from"
													minLength:   1
													type:        "string"
												}
											}
											required: [
												"client_id",
												"token_url",
											]
											type: "object"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											description: "Optional HTTP URL parameters"
											type:        "object"
										}
										path: {
											description: "HTTP path to scrape for metrics."
											type:        "string"
										}
										port: {
											description: "Name of the service port this endpoint refers to. Mutually exclusive with targetPort."

											type: "string"
										}
										proxyURL: {
											description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."

											type: "string"
										}
										relabelConfigs: {
											description: "RelabelConfigs to apply to samples before scraping. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										sampleLimit: {
											description: "SampleLimit defines per-endpoint limit on number of scraped samples that will be accepted."

											format: "int64"
											type:   "integer"
										}
										scheme: {
											description: "HTTP scheme to use for scraping."
											type:        "string"
										}
										scrape_interval: {
											description: "ScrapeInterval is the same as Interval and has priority over it. one of scrape_interval or interval can be used"

											type: "string"
										}
										scrapeTimeout: {
											description: "Timeout after which the scrape is ended"
											type:        "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description: "Name or number of the pod port this endpoint refers to. Mutually exclusive with port."

											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											description: "TLSConfig configuration to use when scraping the endpoint"

											properties: {
												ca: {
													description: "Stuct containing the CA cert to use for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the container to use for the targets."

													type: "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the container for the targets."

													type: "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the container for the targets."

													type: "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										vm_scrape_params: {
											description: "VMScrapeParams defines VictoriaMetrics specific scrape parametrs"

											properties: {
												disable_compression: type: "boolean"
												disable_keep_alive: type:  "boolean"
												headers: {
													description: "Headers allows sending custom headers to scrape targets must be in of semicolon separated header with it's value eg: headerName: headerValue vmagent supports since 1.79.0 version"

													items: type: "string"
													type: "array"
												}
												metric_relabel_debug: type: "boolean"
												no_stale_markers: type:     "boolean"
												proxy_client_config: {
													description: "ProxyClientConfig configures proxy auth settings for scraping See feature description https://docs.victoriametrics.com/vmagent.html#scraping-targets-via-a-proxy"

													properties: {
														basic_auth: {
															description: "BasicAuth allow an endpoint to authenticate over basic authentication"

															properties: {
																password: {
																	description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																password_file: {
																	description: "PasswordFile defines path to password file at disk"

																	type: "string"
																}
																username: {
																	description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
															}
															type: "object"
														}
														bearer_token: {
															description: "SecretKeySelector selects a key of a Secret."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														bearer_token_file: type: "string"
														tls_config: {
															description: "TLSConfig specifies TLSConfig configuration parameters."

															properties: {
																ca: {
																	description: "Stuct containing the CA cert to use for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																caFile: {
																	description: "Path to the CA cert in the container to use for the targets."

																	type: "string"
																}
																cert: {
																	description: "Struct containing the client cert file for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																certFile: {
																	description: "Path to the client cert file in the container for the targets."

																	type: "string"
																}
																insecureSkipVerify: {
																	description: "Disable target certificate validation."
																	type:        "boolean"
																}
																keyFile: {
																	description: "Path to the client key file in the container for the targets."

																	type: "string"
																}
																keySecret: {
																	description: "Secret containing the client key file for the targets."

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																serverName: {
																	description: "Used to verify the hostname for the targets."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												relabel_debug: type:         "boolean"
												scrape_align_interval: type: "string"
												scrape_offset: type:         "string"
												stream_parse: type:          "boolean"
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							jobLabel: {
								description: "The label to use to retrieve the job name from."
								type:        "string"
							}
							namespaceSelector: {
								description: "Selector to select which namespaces the Endpoints objects are discovered from."

								properties: {
									any: {
										description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."

										type: "boolean"
									}
									matchNames: {
										description: "List of namespace names."
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podTargetLabels: {
								description: "PodTargetLabels transfers labels on the Kubernetes Pod onto the target."

								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

								format: "int64"
								type:   "integer"
							}
							selector: {
								description: "Selector to select Endpoints objects by corresponding Service labels."

								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

											properties: {
												key: {
													description: "key is the label key that the selector applies to."

													type: "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

													type: "string"
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

										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							targetLabels: {
								description: "TargetLabels transfers labels on the Kubernetes Service onto the target."

								items: type: "string"
								type: "array"
							}
						}, required: [
							"endpoints",
						], type:
							"object"
					}, status: {
						description:
							"VMServiceScrapeStatus defines the observed state of VMServiceScrape", type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmsingles.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMSingle"
				listKind:
					"VMSingleList", plural: "vmsingles"
				singular:
					"vmsingle"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMSingle  is fast, cost-effective and scalable time-series database.", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMSingleSpec defines the desired state of VMSingle", properties: {

							affinity: {
								description:                            "Affinity If specified, the pod's scheduling constraints."
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the VMSingle object, which shall be mounted into the VMSingle Pods."

								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers property allows to inject additions sidecars or to patch existing containers. It can be useful for proxies, backup, etc."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							dnsConfig: {
								description: "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy."

								items: "x-kubernetes-preserve-unknown-fields": true
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
								description: "DNSPolicy sets DNS policy for the pod"
								type:        "string"
							}
							extraArgs: {
								additionalProperties: type: "string"
								description: "ExtraArgs that will be passed to  VMSingle pod for example remoteWrite.tmpDataPath: /tmp"

								type: "object"
							}
							extraEnvs: {
								description: "ExtraEnvs that will be added to VMSingle pod"
								items: {
									description: "EnvVar represents an environment variable present in a Container."

									properties: {
										name: {
											description: "Name of the environment variable. Must be a C_IDENTIFIER."
											type:        "string"
										}
										value: {
											description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

											type: "string"
										}
									}
									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							hostAliases: {
								description: "HostAliases provides mapping for ip and hostname, that would be propagated to pod, cannot be used with HostNetwork."

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
							hostNetwork: {
								description: "HostNetwork controls whether the pod may use the node network namespace"

								type: "boolean"
							}
							image: {
								description: "Image - docker image settings for VMSingle if no specified operator uses default config version"

								properties: {
									pullPolicy: {
										description: "PullPolicy describes how to pull docker image"
										type:        "string"
									}
									repository: {
										description: "Repository contains name of docker image + it's repository if needed"

										type: "string"
									}
									tag: {
										description: "Tag contains desired docker image version"
										type:        "string"
									}
								}
								type: "object"
							}
							imagePullSecrets: {
								description: "ImagePullSecrets An optional list of references to secrets in the same namespace to use for pulling images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the vmSingle configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."

								items: {
									description: "A single application container that you want to run within a pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							insertPorts: {
								description: "InsertPorts - additional listen ports for data ingestion."
								properties: {
									graphitePort: {
										description: "GraphitePort listen port"
										type:        "string"
									}
									influxPort: {
										description: "InfluxPort listen port"
										type:        "string"
									}
									openTSDBHTTPPort: {
										description: "OpenTSDBHTTPPort for http connections."
										type:        "string"
									}
									openTSDBPort: {
										description: "OpenTSDBPort for tcp and udp listen"
										type:        "string"
									}
								}
								type: "object"
							}
							livenessProbe: {
								description:                            "LivenessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logFormat: {
								description: "LogFormat for VMSingle to be configured with."
								enum: [
									"default",
									"json",
								]
								type: "string"
							}
							logLevel: {
								description: "LogLevel for victoria metrics single to be configured with."

								enum: [
									"INFO",
									"WARN",
									"ERROR",
									"FATAL",
									"PANIC",
								]
								type: "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector Define which Nodes the Pods are scheduled on."

								type: "object"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the VMSingle pods."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							podSecurityPolicyName: {
								description: "PodSecurityPolicyName - defines name for podSecurityPolicy in case of empty value, prefixedName will be used."

								type: "string"
							}
							port: {
								description: "Port listen port"
								type:        "string"
							}
							priorityClassName: {
								description: "PriorityClassName assigned to the Pods"
								type:        "string"
							}
							readinessGates: {
								description: "ReadinessGates defines pod readiness gates"
								items: {
									description: "PodReadinessGate contains the reference to a pod condition"
									properties: conditionType: {
										description: "ConditionType refers to a condition in the pod's condition list with matching type."

										type: "string"
									}
									required: ["conditionType"]
									type: "object"
								}
								type: "array"
							}
							readinessProbe: {
								description:                            "ReadinessProbe that will be added CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							removePvcAfterDelete: {
								description: "RemovePvcAfterDelete - if true, controller adds ownership to pvc and after VMSingle objest deletion - pvc will be garbage collected by controller manager"

								type: "boolean"
							}
							replicaCount: {
								description: "ReplicaCount is the expected size of the VMSingle it can be 0 or 1 if you need more - use vm cluster"

								format: "int32"
								type:   "integer"
							}
							resources: {
								description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ if not defined default resources from operator config will be used"

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

										type: "object"
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

										type: "object"
									}
								}
								type: "object"
							}
							retentionPeriod: {
								description: "RetentionPeriod for the stored metrics Note VictoriaMetrics has data/ and indexdb/ folders metrics from data/ removed eventually as soon as partition leaves retention period reverse index data at indexdb rotates once at the half of configured retention period https://docs.victoriametrics.com/Single-server-VictoriaMetrics.html#retention"

								type: "string"
							}
							runtimeClassName: {
								description: "RuntimeClassName - defines runtime class for kubernetes pod. https://kubernetes.io/docs/concepts/containers/runtime-class/"

								type: "string"
							}
							schedulerName: {
								description: "SchedulerName - defines kubernetes scheduler name"
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the VMSingle object, which shall be mounted into the VMSingle Pods."

								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."

								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the VMSingle Pods."

								type: "string"
							}
							serviceScrapeSpec: {
								description: "ServiceScrapeSpec that will be added to vmselect VMServiceScrape spec"

								required: ["endpoints"]
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							serviceSpec: {
								description: "ServiceSpec that will be added to vmsingle service spec"
								properties: {
									metadata: {
										description: "EmbeddedObjectMetadata defines objectMeta for additional service."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

												type: "object"
											}
											name: {
												description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

												type: "string"
											}
										}
										type: "object"
									}
									spec: {
										description: "ServiceSpec describes the attributes that a user creates on a service. More info: https://kubernetes.io/docs/concepts/services-networking/service/"

										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: ["spec"]
								type: "object"
							}
							startupProbe: {
								description:                            "StartupProbe that will be added to CRD pod"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							storage: {
								description: "Storage is the definition of how storage will be used by the VMSingle by default it`s empty dir"

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

												type: "string"
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
										description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled."

										properties: {
											apiGroup: {
												description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

												type: "string"
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

												type: "object"
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

												type: "object"
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

															type: "string"
														}
														operator: {
															description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

															type: "string"
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

												type: "object"
											}
										}
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									storageClassName: {
										description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

										type: "string"
									}
									volumeMode: {
										description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

										type: "string"
									}
									volumeName: {
										description: "volumeName is the binding reference to the PersistentVolume backing this claim."

										type: "string"
									}
								}
								type: "object"
							}
							storageDataPath: {
								description: "StorageDataPath disables spec.storage option and overrides arg for victoria-metrics binary --storageDataPath, its users responsibility to mount proper device into given path."

								type: "string"
							}
							storageMetadata: {
								description: "StorageMeta defines annotations and labels attached to PVC for given vmsingle CR"

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"

										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"

										type: "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"

										type: "string"
									}
								}
								type: "object"
							}
							streamAggrConfig: {
								description: "StreamAggrConfig defines stream aggregation configuration for VMSingle"

								properties: {
									dedupInterval: {
										description: "Allows setting different de-duplication intervals per each configured remote storage"

										type: "string"
									}
									keepInput: {
										description: "Allows writing both raw and aggregate data"
										type:        "boolean"
									}
									rules: {
										description: "Stream aggregation rules"
										items: {
											description: "StreamAggrRule defines the rule in stream aggregation config"

											properties: {
												by: {
													description: """
		By is an optional list of labels for grouping input series.
		 See also Without.
		 If neither By nor Without are set, then the Outputs are calculated individually per each input time series.
		"""

													items: type: "string"
													type: "array"
												}
												input_relabel_configs: {
													description: "InputRelabelConfigs is an optional relabeling rules, which are applied on the input before aggregation."

													items: {
														description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

														properties: {
															action: {
																description: "Action to perform based on regex matching. Default is 'replace'"

																type: "string"
															}
															if: {
																description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

																type: "string"
															}
															labels: {
																additionalProperties: type: "string"
																description: "Labels is used together with Match for `action: graphite`"

																type: "object"
															}
															match: {
																description: "Match is used together with Labels for `action: graphite`"

																type: "string"
															}
															modulus: {
																description: "Modulus to take of the hash of the source label values."

																format: "int64"
																type:   "integer"
															}
															regex: {
																description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

																type: "string"
															}
															replacement: {
																description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

																type: "string"
															}
															separator: {
																description: "Separator placed between concatenated source label values. default is ';'."

																type: "string"
															}
															source_labels: {
																description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																items: type: "string"
																type: "array"
															}
															sourceLabels: {
																description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

																items: type: "string"
																type: "array"
															}
															target_label: {
																description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																type: "string"
															}
															targetLabel: {
																description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

																type: "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												interval: {
													description: "Interval is the interval between aggregations."
													type:        "string"
												}
												match: {
													description: """
		Match is a label selector for filtering time series for the given selector.
		 If the match isn't set, then all the input time series are processed.
		"""

													type: "string"
												}
												output_relabel_configs: {
													description: "OutputRelabelConfigs is an optional relabeling rules, which are applied on the aggregated output before being sent to remote storage."

													items: {
														description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

														properties: {
															action: {
																description: "Action to perform based on regex matching. Default is 'replace'"

																type: "string"
															}
															if: {
																description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

																type: "string"
															}
															labels: {
																additionalProperties: type: "string"
																description: "Labels is used together with Match for `action: graphite`"

																type: "object"
															}
															match: {
																description: "Match is used together with Labels for `action: graphite`"

																type: "string"
															}
															modulus: {
																description: "Modulus to take of the hash of the source label values."

																format: "int64"
																type:   "integer"
															}
															regex: {
																description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

																type: "string"
															}
															replacement: {
																description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

																type: "string"
															}
															separator: {
																description: "Separator placed between concatenated source label values. default is ';'."

																type: "string"
															}
															source_labels: {
																description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																items: type: "string"
																type: "array"
															}
															sourceLabels: {
																description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

																items: type: "string"
																type: "array"
															}
															target_label: {
																description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

																type: "string"
															}
															targetLabel: {
																description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

																type: "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												outputs: {
													description: """
		Outputs is a list of output aggregate functions to produce.
		 The following names are allowed:
		 - total - aggregates input counters - increase - counts the increase over input counters - count_series - counts the input series - count_samples - counts the input samples - sum_samples - sums the input samples - last - the last biggest sample value - min - the minimum sample value - max - the maximum sample value - avg - the average value across all the samples - stddev - standard deviation across all the samples - stdvar - standard variance across all the samples - histogram_bucket - creates VictoriaMetrics histogram for input samples - quantiles(phi1, ..., phiN) - quantiles' estimation for phi in the range [0..1]
		 The output time series will have the following names:
		 input_name:aggr_<interval>_<output>
		"""

													items: type: "string"
													type: "array"
												}
												without: {
													description: """
		Without is an optional list of labels, which must be excluded when grouping input series.
		 See also By.
		 If neither By nor Without are set, then the Outputs are calculated individually per each input time series.
		"""

													items: type: "string"
													type: "array"
												}
											}
											required: [
												"interval",
												"outputs",
											]
											type: "object"
										}
										type: "array"
									}
								}
								required: ["rules"]
								type: "object"
							}
							terminationGracePeriodSeconds: {
								description: "TerminationGracePeriodSeconds period for container graceful termination"

								format: "int64"
								type:   "integer"
							}
							tolerations: {
								description: "Tolerations If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."

									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."

											type: "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."

											type: "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."

											type: "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."

											format: "int64"
											type:   "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "TopologySpreadConstraints embedded kubernetes pod configuration option, controls how pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/"

								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."

									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
							vmBackup: {
								description: "VMBackup configuration for backup"
								properties: {
									acceptEULA: {
										description: "AcceptEULA accepts enterprise feature usage, must be set to true. otherwise backupmanager cannot be added to single/cluster version. https://victoriametrics.com/legal/eula/"

										type: "boolean"
									}
									concurrency: {
										description: "Defines number of concurrent workers. Higher concurrency may reduce backup duration (default 10)"

										format: "int32"
										type:   "integer"
									}
									credentialsSecret: {
										description: "CredentialsSecret is secret in the same namespace for access to remote storage The secret is mounted into /etc/vm/creds."

										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."

												type: "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

												type: "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"

												type: "boolean"
											}
										}
										required: ["key"]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									customS3Endpoint: {
										description: "Custom S3 endpoint for use with S3-compatible storages (e.g. MinIO). S3 is used if not set"

										type: "string"
									}
									destination: {
										description: "Defines destination for backup"
										type:        "string"
									}
									destinationDisableSuffixAdd: {
										description: "DestinationDisableSuffixAdd - disables suffix adding for cluster version backups each vmstorage backup must have unique backup folder so operator adds POD_NAME as suffix for backup destination folder."

										type: "boolean"
									}
									disableDaily: {
										description: "Defines if daily backups disabled (default false)"
										type:        "boolean"
									}
									disableHourly: {
										description: "Defines if hourly backups disabled (default false)"
										type:        "boolean"
									}
									disableMonthly: {
										description: "Defines if monthly backups disabled (default false)"
										type:        "boolean"
									}
									disableWeekly: {
										description: "Defines if weekly backups disabled (default false)"
										type:        "boolean"
									}
									extraArgs: {
										additionalProperties: type: "string"
										description: "extra args like maxBytesPerSecond default 0"
										type:        "object"
									}
									extraEnvs: {
										items: {
											description: "EnvVar represents an environment variable present in a Container."

											properties: {
												name: {
													description: "Name of the environment variable. Must be a C_IDENTIFIER."

													type: "string"
												}
												value: {
													description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

													type: "string"
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

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
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

																	type: "string"
																}
																fieldPath: {
																	description: "Path of the field to select in the specified API version."

																	type: "string"
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

																	type: "string"
																}
																divisor: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description: "Specifies the output format of the exposed resources, defaults to \"1\""

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

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
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
									image: {
										description: "Image - docker image settings for VMBackuper"
										properties: {
											pullPolicy: {
												description: "PullPolicy describes how to pull docker image"
												type:        "string"
											}
											repository: {
												description: "Repository contains name of docker image + it's repository if needed"

												type: "string"
											}
											tag: {
												description: "Tag contains desired docker image version"
												type:        "string"
											}
										}
										type: "object"
									}
									logFormat: {
										description: "LogFormat for VMSelect to be configured with. default or json"

										enum: [
											"default",
											"json",
										]
										type: "string"
									}
									logLevel: {
										description: "LogLevel for VMSelect to be configured with."
										enum: [
											"INFO",
											"WARN",
											"ERROR",
											"FATAL",
											"PANIC",
										]
										type: "string"
									}
									port: {
										description: "Port for health check connections"
										type:        "string"
									}
									resources: {
										description: "Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ if not defined default resources from operator config will be used"

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

												type: "object"
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

												type: "object"
											}
										}
										type: "object"
									}
									restore: {
										description: "Restore Allows to enable restore options for pod Read more: https://docs.victoriametrics.com/vmbackupmanager.html#restore-commands"

										properties: onStart: {
											description: "OnStart defines configuration for restore on pod start"

											properties: enabled: {
												description: "Enabled defines if restore on start enabled"
												type:        "boolean"
											}
											type: "object"
										}
										type: "object"
									}
									snapshotCreateURL: {
										description: "SnapshotCreateURL overwrites url for snapshot create"
										type:        "string"
									}
									snapshotDeleteURL: {
										description: "SnapShotDeleteURL overwrites url for snapshot delete"
										type:        "string"
									}
									volumeMounts: {
										description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the vmbackupmanager container, that are generated as a result of StorageSpec objects."

										items: {
											description: "VolumeMount describes a mounting of a Volume within a container."

											properties: {
												mountPath: {
													description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

													type: "string"
												}
												mountPropagation: {
													description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

													type: "string"
												}
												name: {
													description: "This must match the Name of a Volume."
													type:        "string"
												}
												readOnly: {
													description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

													type: "boolean"
												}
												subPath: {
													description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

													type: "string"
												}
												subPathExpr: {
													description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

													type: "string"
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
								}
								required: ["acceptEULA"]
								type: "object"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition. VolumeMounts specified will be appended to other VolumeMounts in the VMSingle container, that are generated as a result of StorageSpec objects."

								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."

									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

											type: "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

											type: "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

											type: "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

											type: "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

											type: "string"
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
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output deploy definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."

								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

									required: ["name"]
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								type: "array"
							}
						}, required: [
							"retentionPeriod",
						], type:
							"object"
					}, status: {
						description:
							"VMSingleStatus defines the observed state of VMSingle", properties: {

							availableReplicas: {
								description: "AvailableReplicas Total number of available pods (ready for at least minReadySeconds) targeted by this VMAlert cluster."

								format: "int32"
								type:   "integer"
							}
							replicas: {
								description: "ReplicaCount Total number of non-terminated pods targeted by this VMAlert cluster (their labels match the selector)."

								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								description: "UnavailableReplicas Total number of unavailable pods targeted by this VMAlert cluster."

								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								description: "UpdatedReplicas Total number of non-terminated pods targeted by this VMAlert cluster that have the desired version spec."

								format: "int32"
								type:   "integer"
							}
						}, required: [
							"availableReplicas",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						], type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmstaticscrapes.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMStaticScrape"
				listKind:
					"VMStaticScrapeList", plural: "vmstaticscrapes"
				singular:
					"vmstaticscrape"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMStaticScrape  defines static targets configuration for scraping.", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMStaticScrapeSpec defines the desired state of VMStaticScrape.", properties: {

							jobName: {
								description: "JobName name of job."
								type:        "string"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

								format: "int64"
								type:   "integer"
							}
							targetEndpoints: {
								description: "A list of target endpoints to scrape metrics from."
								items: {
									description: "TargetEndpoint defines single static target endpoint."
									properties: {
										authorization: {
											description: "Authorization with http header Authorization"
											properties: {
												credentials: {
													description: "Reference to the secret with value for authorization"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: {
													description: "File with value for authorization"
													type:        "string"
												}
												type: {
													description: "Type of authorization, default to bearer"
													type:        "string"
												}
											}
											type: "object"
										}
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"

											properties: {
												password: {
													description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												password_file: {
													description: "PasswordFile defines path to password file at disk"

													type: "string"
												}
												username: {
													description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenFile: {
											description: "File to read bearer token for scraping targets."
											type:        "string"
										}
										bearerTokenSecret: {
											description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service scrape and accessible by the victoria-metrics operator."

											nullable: true
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."

													type: "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

													type: "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"

													type: "boolean"
												}
											}
											required: ["key"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										follow_redirects: {
											description: "FollowRedirects controls redirects for scraping."
											type:        "boolean"
										}
										honorLabels: {
											description: "HonorLabels chooses the metric's labels on collisions with target labels."

											type: "boolean"
										}
										honorTimestamps: {
											description: "HonorTimestamps controls whether vmagent respects the timestamps present in scraped data."

											type: "boolean"
										}
										interval: {
											description: "Interval at which metrics should be scraped"
											type:        "string"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels static labels for targets."
											type:        "object"
										}
										metricRelabelConfigs: {
											description: "MetricRelabelConfigs to apply to samples before ingestion."

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											description: "OAuth2 defines auth configuration"
											properties: {
												client_id: {
													description: "The secret or configmap containing the OAuth2 client id"

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												client_secret: {
													description: "The secret containing the OAuth2 client secret"
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												client_secret_file: {
													description: "ClientSecretFile defines path for client secret file."

													type: "string"
												}
												endpoint_params: {
													additionalProperties: type: "string"
													description: "Parameters to append to the token URL"
													type:        "object"
												}
												scopes: {
													description: "OAuth2 scopes used for the token request"
													items: type: "string"
													type: "array"
												}
												token_url: {
													description: "The URL to fetch the token from"
													minLength:   1
													type:        "string"
												}
											}
											required: [
												"client_id",
												"token_url",
											]
											type: "object"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											description: "Optional HTTP URL parameters"
											type:        "object"
										}
										path: {
											description: "HTTP path to scrape for metrics."
											type:        "string"
										}
										port: {
											description: "Default port for target."
											type:        "string"
										}
										proxyURL: {
											description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."

											type: "string"
										}
										relabelConfigs: {
											description: "RelabelConfigs to apply to samples before scraping. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"

											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"

												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"

														type: "string"
													}
													if: {
														description: "If represents metricsQL match expression: '{__name__=~\"foo_.*\"}'"

														type: "string"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Labels is used together with Match for `action: graphite`"

														type: "object"
													}
													match: {
														description: "Match is used together with Labels for `action: graphite`"

														type: "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."

														format: "int64"
														type:   "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"

														type: "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"

														type: "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."

														type: "string"
													}
													source_labels: {
														description: "UnderScoreSourceLabels - additional form of source labels source_labels for compatibility with original relabel config. if set  both sourceLabels and source_labels, sourceLabels has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														items: type: "string"
														type: "array"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."

														items: type: "string"
														type: "array"
													}
													target_label: {
														description: "UnderScoreTargetLabel - additional form of target label - target_label for compatibility with original relabel config. if set  both targetLabel and target_label, targetLabel has priority. for details https://github.com/VictoriaMetrics/operator/issues/131"

														type: "string"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."

														type: "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										sampleLimit: {
											description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."

											format: "int64"
											type:   "integer"
										}
										scheme: {
											description: "HTTP scheme to use for scraping."
											type:        "string"
										}
										scrape_interval: {
											description: "ScrapeInterval is the same as Interval and has priority over it. one of scrape_interval or interval can be used"

											type: "string"
										}
										scrapeTimeout: {
											description: "Timeout after which the scrape is ended"
											type:        "string"
										}
										targets: {
											description: "Targets static targets addresses in form of [\"192.122.55.55:9100\",\"some-name:9100\"]."
											items: type: "string"
											type: "array"
										}
										tlsConfig: {
											description: "TLSConfig configuration to use when scraping the endpoint"

											properties: {
												ca: {
													description: "Stuct containing the CA cert to use for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the container to use for the targets."

													type: "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."

													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."

															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the container for the targets."

													type: "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the container for the targets."

													type: "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."

													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."

															type: "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

															type: "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"

															type: "boolean"
														}
													}
													required: ["key"]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										vm_scrape_params: {
											description: "VMScrapeParams defines VictoriaMetrics specific scrape parametrs"

											properties: {
												disable_compression: type: "boolean"
												disable_keep_alive: type:  "boolean"
												headers: {
													description: "Headers allows sending custom headers to scrape targets must be in of semicolon separated header with it's value eg: headerName: headerValue vmagent supports since 1.79.0 version"

													items: type: "string"
													type: "array"
												}
												metric_relabel_debug: type: "boolean"
												no_stale_markers: type:     "boolean"
												proxy_client_config: {
													description: "ProxyClientConfig configures proxy auth settings for scraping See feature description https://docs.victoriametrics.com/vmagent.html#scraping-targets-via-a-proxy"

													properties: {
														basic_auth: {
															description: "BasicAuth allow an endpoint to authenticate over basic authentication"

															properties: {
																password: {
																	description: "The secret in the service scrape namespace that contains the password for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																password_file: {
																	description: "PasswordFile defines path to password file at disk"

																	type: "string"
																}
																username: {
																	description: "The secret in the service scrape namespace that contains the username for authentication. It must be at them same namespace as CRD"

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
															}
															type: "object"
														}
														bearer_token: {
															description: "SecretKeySelector selects a key of a Secret."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."

																	type: "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"

																	type: "boolean"
																}
															}
															required: ["key"]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														bearer_token_file: type: "string"
														tls_config: {
															description: "TLSConfig specifies TLSConfig configuration parameters."

															properties: {
																ca: {
																	description: "Stuct containing the CA cert to use for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																caFile: {
																	description: "Path to the CA cert in the container to use for the targets."

																	type: "string"
																}
																cert: {
																	description: "Struct containing the client cert file for the targets."

																	properties: {
																		configMap: {
																			description: "ConfigMap containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key to select."
																					type:        "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the ConfigMap or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		secret: {
																			description: "Secret containing data to use for the targets."

																			properties: {
																				key: {
																					description: "The key of the secret to select from.  Must be a valid secret key."

																					type: "string"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "Specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			required: ["key"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	type: "object"
																}
																certFile: {
																	description: "Path to the client cert file in the container for the targets."

																	type: "string"
																}
																insecureSkipVerify: {
																	description: "Disable target certificate validation."
																	type:        "boolean"
																}
																keyFile: {
																	description: "Path to the client key file in the container for the targets."

																	type: "string"
																}
																keySecret: {
																	description: "Secret containing the client key file for the targets."

																	properties: {
																		key: {
																			description: "The key of the secret to select from.  Must be a valid secret key."

																			type: "string"
																		}
																		name: {
																			description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																			type: "string"
																		}
																		optional: {
																			description: "Specify whether the Secret or its key must be defined"

																			type: "boolean"
																		}
																	}
																	required: ["key"]
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																serverName: {
																	description: "Used to verify the hostname for the targets."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												relabel_debug: type:         "boolean"
												scrape_align_interval: type: "string"
												scrape_offset: type:         "string"
												stream_parse: type:          "boolean"
											}
											type: "object"
										}
									}
									required: ["targets"]
									type: "object"
								}
								type: "array"
							}
						}, required: [
							"targetEndpoints",
						], type:
							"object"
					}, status: {
						description:
							"VMStaticScrapeStatus defines the observed state of VMStaticScrape", type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}, {
	apiVersion:
		"apiextensions.k8s.io/v1"
	kind: "CustomResourceDefinition"
	metadata: {annotations: "controller-gen.kubebuilder.io/version":
		"v0.10.0", name: "vmusers.operator.victoriametrics.com"
	}
	spec: {group:
		"operator.victoriametrics.com"
		names: {
				kind: "VMUser"
				listKind:
					"VMUserList", plural: "vmusers"
				singular:
					"vmuser"
		}, scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description:
					"VMUser is the Schema for the vmusers API", properties: {
					apiVersion: {
						description:
							"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type:
							"string"
					}, kind: {
						description:
							"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type:
							"string"
					}, metadata: type:
						"object", spec: {
						description:
							"VMUserSpec defines the desired state of VMUser", properties: {

							bearerToken: {
								description: "BearerToken Authorization header value for accessing protected endpoint."

								type: "string"
							}
							default_url: {
								description: "DefaultURLs backend url for non-matching paths filter usually used for default backend with error message"

								items: type: "string"
								type: "array"
							}
							generatePassword: {
								description: "GeneratePassword instructs operator to generate password for user if spec.password if empty."

								type: "boolean"
							}
							name: {
								description: "Name of the VMUser object."
								type:        "string"
							}
							password: {
								description: "Password basic auth password for accessing protected endpoint."

								type: "string"
							}
							passwordRef: {
								description: "PasswordRef allows fetching password from user-create secret by its name and key."

								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
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
							targetRefs: {
								description: "TargetRefs - reference to endpoints, which user may access."
								items: {
									description: "TargetRef describes target for user traffic forwarding. one of target types can be chosen: crd or static per targetRef. user can define multiple targetRefs with different ref Types."

									properties: {
										crd: {
											description: "CRD describes exist operator's CRD object, operator generates access url based on CRD params."

											properties: {
												kind: {
													description: "Kind one of: VMAgent VMAlert VMCluster VMSingle or VMAlertManager"

													type: "string"
												}
												name: {
													description: "Name target CRD object name"
													type:        "string"
												}
												namespace: {
													description: "Namespace target CRD object namespace."
													type:        "string"
												}
											}
											required: [
												"kind",
												"name",
												"namespace",
											]
											type: "object"
										}
										headers: {
											description: "Headers represent additional http headers, that vmauth uses in form of [\"header_key: header_value\"] multiple values for header key: [\"header_key: value1,value2\"] it's available since 1.68.0 version of vmauth"

											items: type: "string"
											type: "array"
										}
										ip_filters: {
											description: "IPFilters defines per target src ip filters supported only with enterprise version of vmauth https://docs.victoriametrics.com/vmauth.html#ip-filters"

											properties: {
												allow_list: {
													items: type: "string"
													type: "array"
												}
												deny_list: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										paths: {
											description: "Paths - matched path to route."
											items: type: "string"
											type: "array"
										}
										static: {
											description: "Static - user defined url for traffic forward, for instance http://vmsingle:8429"

											properties: {
												url: {
													description: "URL http url for given staticRef."
													type:        "string"
												}
												urls: {
													description: "URLs allows setting multiple urls for load-balancing at vmauth-side."

													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										target_path_suffix: {
											description: "QueryParams []string `json:\"queryParams,omitempty\"` TargetPathSuffix allows to add some suffix to the target path It allows to hide tenant configuration from user with crd as ref. it also may contain any url encoded params."

											type: "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							tokenRef: {
								description: "TokenRef allows fetching token from user-created secrets by its name and key."

								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."

										type: "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
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
							username: {
								description: "UserName basic auth user name for accessing protected endpoint, will be replaced with metadata.name of VMUser if omitted."

								type: "string"
							}
						}, required: [
							"targetRefs",
						], type:
							"object"
					}, status: {
						description:
							"VMUserStatus defines the observed state of VMUser", type:
							"object"
					}
					}, type:
						"object"
			}, served: true
			storage:
				true, subresources: status: {}
		}]
	}
}]
