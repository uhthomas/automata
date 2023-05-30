package kubevirt

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
	metadata: {
		name: "kubevirts.kubevirt.io"
		labels: "operator.kubevirt.io": ""
	}
	spec: {
		group: "kubevirt.io"
		names: {
			categories: [
				"all",
			]
			kind:   "KubeVirt"
			plural: "kubevirts"
			shortNames: [
				"kv",
				"kvs",
			]
			singular: "kubevirt"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "KubeVirt represents the object deploying all KubeVirt resources"
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
						properties: {
							certificateRotateStrategy: {
								properties: selfSigned: {
									properties: {
										ca: {
											description: "CA configuration CA certs are kept in the CA bundle as long as they are valid"

											properties: {
												duration: {
													description: "The requested 'duration' (i.e. lifetime) of the Certificate."

													type: "string"
												}
												renewBefore: {
													description: "The amount of time before the currently issued certificate's \"notAfter\" time that we will begin to attempt to renew the certificate."

													type: "string"
												}
											}
											type: "object"
										}
										caOverlapInterval: {
											description: "Deprecated. Use CA.Duration and CA.RenewBefore instead"

											type: "string"
										}
										caRotateInterval: {
											description: "Deprecated. Use CA.Duration instead"
											type:        "string"
										}
										certRotateInterval: {
											description: "Deprecated. Use Server.Duration instead"
											type:        "string"
										}
										server: {
											description: "Server configuration Certs are rotated and discarded"
											properties: {
												duration: {
													description: "The requested 'duration' (i.e. lifetime) of the Certificate."

													type: "string"
												}
												renewBefore: {
													description: "The amount of time before the currently issued certificate's \"notAfter\" time that we will begin to attempt to renew the certificate."

													type: "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "object"
							}
							configuration: {
								description: "holds kubevirt configurations. same as the virt-configMap"
								properties: {
									apiConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									controllerConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									cpuModel: type: "string"
									cpuRequest: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									defaultRuntimeClass: type: "string"
									developerConfiguration: {
										description: "DeveloperConfiguration holds developer options"
										properties: {
											cpuAllocationRatio: {
												description: "For each requested virtual CPU, CPUAllocationRatio defines how much physical CPU to request per VMI from the hosting node. The value is in fraction of a CPU thread (or core on non-hyperthreaded nodes). For example, a value of 1 means 1 physical CPU thread per VMI CPU thread. A value of 100 would be 1% of a physical thread allocated for each requested VMI thread. This option has no effect on VMIs that request dedicated CPUs. More information at: https://kubevirt.io/user-guide/operations/node_overcommit/#node-cpu-allocation-ratio Defaults to 10"

												type: "integer"
											}
											diskVerification: {
												description: "DiskVerification holds container disks verification limits"

												properties: memoryLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												required: [
													"memoryLimit",
												]
												type: "object"
											}
											featureGates: {
												description: "FeatureGates is the list of experimental features to enable. Defaults to none"

												items: type: "string"
												type: "array"
											}
											logVerbosity: {
												description: "LogVerbosity sets log verbosity level of  various components"

												properties: {
													nodeVerbosity: {
														additionalProperties: type: "integer"
														description: "NodeVerbosity represents a map of nodes with a specific verbosity level"

														type: "object"
													}
													virtAPI: type:        "integer"
													virtController: type: "integer"
													virtHandler: type:    "integer"
													virtLauncher: type:   "integer"
													virtOperator: type:   "integer"
												}
												type: "object"
											}
											memoryOvercommit: {
												description: "MemoryOvercommit is the percentage of memory we want to give VMIs compared to the amount given to its parent pod (virt-launcher). For example, a value of 102 means the VMI will \"see\" 2% more memory than its parent pod. Values under 100 are effectively \"undercommits\". Overcommits can lead to memory exhaustion, which in turn can lead to crashes. Use carefully. Defaults to 100"

												type: "integer"
											}
											minimumClusterTSCFrequency: {
												description: "Allow overriding the automatically determined minimum TSC frequency of the cluster and fixate the minimum to this frequency."

												format: "int64"
												type:   "integer"
											}
											minimumReservePVCBytes: {
												description: "MinimumReservePVCBytes is the amount of space, in bytes, to leave unused on disks. Defaults to 131072 (128KiB)"

												format: "int64"
												type:   "integer"
											}
											nodeSelectors: {
												additionalProperties: type: "string"
												description: "NodeSelectors allows restricting VMI creation to nodes that match a set of labels. Defaults to none"

												type: "object"
											}
											pvcTolerateLessSpaceUpToPercent: {
												description: "LessPVCSpaceToleration determines how much smaller, in percentage, disk PVCs are allowed to be compared to the requested size (to account for various overheads). Defaults to 10"

												type: "integer"
											}
											useEmulation: {
												description: "UseEmulation can be set to true to allow fallback to software emulation in case hardware-assisted emulation is not available. Defaults to false"

												type: "boolean"
											}
										}
										type: "object"
									}
									emulatedMachines: {
										items: type: "string"
										type: "array"
									}
									evictionStrategy: {
										description: "EvictionStrategy defines at the cluster level if the VirtualMachineInstance should be migrated instead of shut-off in case of a node drain. If the VirtualMachineInstance specific field is set it overrides the cluster level one."

										type: "string"
									}
									handlerConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									imagePullPolicy: {
										description: "PullPolicy describes a policy for if/when to pull a container image"

										type: "string"
									}
									machineType: type: "string"
									mediatedDevicesConfiguration: {
										description: "MediatedDevicesConfiguration holds information about MDEV types to be defined, if available"

										properties: {
											mediatedDeviceTypes: {
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											mediatedDevicesTypes: {
												description: "Deprecated. Use mediatedDeviceTypes instead."
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											nodeMediatedDeviceTypes: {
												items: {
													description: "NodeMediatedDeviceTypesConfig holds information about MDEV types to be defined in a specifc node that matches the NodeSelector field."

													properties: {
														mediatedDeviceTypes: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mediatedDevicesTypes: {
															description: "Deprecated. Use mediatedDeviceTypes instead."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														nodeSelector: {
															additionalProperties: type: "string"
															description: "NodeSelector is a selector which must be true for the vmi to fit on a node. Selector which must match a node's labels for the vmi to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"

															type: "object"
														}
													}
													required: [
														"nodeSelector",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
										}
										type: "object"
									}
									memBalloonStatsPeriod: {
										format: "int32"
										type:   "integer"
									}
									migrations: {
										description: "MigrationConfiguration holds migration options. Can be overridden for specific groups of VMs though migration policies. Visit https://kubevirt.io/user-guide/operations/migration_policies/ for more information."

										properties: {
											allowAutoConverge: {
												description: "AllowAutoConverge allows the platform to compromise performance/availability of VMIs to guarantee successful VMI live migrations. Defaults to false"

												type: "boolean"
											}
											allowPostCopy: {
												description: "AllowPostCopy enables post-copy live migrations. Such migrations allow even the busiest VMIs to successfully live-migrate. However, events like a network failure can cause a VMI crash. If set to true, migrations will still start in pre-copy, but switch to post-copy when CompletionTimeoutPerGiB triggers. Defaults to false"

												type: "boolean"
											}
											bandwidthPerMigration: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "BandwidthPerMigration limits the amount of network bandwith live migrations are allowed to use. The value is in quantity per second. Defaults to 0 (no limit)"

												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
											completionTimeoutPerGiB: {
												description: "CompletionTimeoutPerGiB is the maximum number of seconds per GiB a migration is allowed to take. If a live-migration takes longer to migrate than this value multiplied by the size of the VMI, the migration will be cancelled, unless AllowPostCopy is true. Defaults to 800"

												format: "int64"
												type:   "integer"
											}
											disableTLS: {
												description: "When set to true, DisableTLS will disable the additional layer of live migration encryption provided by KubeVirt. This is usually a bad idea. Defaults to false"

												type: "boolean"
											}
											network: {
												description: "Network is the name of the CNI network to use for live migrations. By default, migrations go through the pod network."

												type: "string"
											}
											nodeDrainTaintKey: {
												description: "NodeDrainTaintKey defines the taint key that indicates a node should be drained. Note: this option relies on the deprecated node taint feature. Default: kubevirt.io/drain"

												type: "string"
											}
											parallelMigrationsPerCluster: {
												description: "ParallelMigrationsPerCluster is the total number of concurrent live migrations allowed cluster-wide. Defaults to 5"

												format: "int32"
												type:   "integer"
											}
											parallelOutboundMigrationsPerNode: {
												description: "ParallelOutboundMigrationsPerNode is the maximum number of concurrent outgoing live migrations allowed per node. Defaults to 2"

												format: "int32"
												type:   "integer"
											}
											progressTimeout: {
												description: "ProgressTimeout is the maximum number of seconds a live migration is allowed to make no progress. Hitting this timeout means a migration transferred 0 data for that many seconds. The migration is then considered stuck and therefore cancelled. Defaults to 150"

												format: "int64"
												type:   "integer"
											}
											unsafeMigrationOverride: {
												description: "UnsafeMigrationOverride allows live migrations to occur even if the compatibility check indicates the migration will be unsafe to the guest. Defaults to false"

												type: "boolean"
											}
										}
										type: "object"
									}
									minCPUModel: type: "string"
									network: {
										description: "NetworkConfiguration holds network options"
										properties: {
											defaultNetworkInterface: type:           "string"
											permitBridgeInterfaceOnPodNetwork: type: "boolean"
											permitSlirpInterface: type:              "boolean"
										}
										type: "object"
									}
									obsoleteCPUModels: {
										additionalProperties: type: "boolean"
										type: "object"
									}
									ovmfPath: type: "string"
									permittedHostDevices: {
										description: "PermittedHostDevices holds information about devices allowed for passthrough"

										properties: {
											mediatedDevices: {
												items: {
													description: "MediatedHostDevice represents a host mediated device allowed for passthrough"

													properties: {
														externalResourceProvider: type: "boolean"
														mdevNameSelector: type:         "string"
														resourceName: type:             "string"
													}
													required: [
														"mdevNameSelector",
														"resourceName",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											pciHostDevices: {
												items: {
													description: "PciHostDevice represents a host PCI device allowed for passthrough"

													properties: {
														externalResourceProvider: {
															description: "If true, KubeVirt will leave the allocation and monitoring to an external device plugin"

															type: "boolean"
														}
														pciVendorSelector: {
															description: "The vendor_id:product_id tuple of the PCI device"

															type: "string"
														}
														resourceName: {
															description: "The name of the resource that is representing the device. Exposed by a device plugin and requested by VMs. Typically of the form vendor.com/product_nameThe name of the resource that is representing the device. Exposed by a device plugin and requested by VMs. Typically of the form vendor.com/product_name"

															type: "string"
														}
													}
													required: [
														"pciVendorSelector",
														"resourceName",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
										}
										type: "object"
									}
									seccompConfiguration: {
										description: "SeccompConfiguration holds Seccomp configuration for Kubevirt components"

										properties: virtualMachineInstanceProfile: {
											description: "VirtualMachineInstanceProfile defines what profile should be used with virt-launcher. Defaults to none"

											properties: customProfile: {
												description: "CustomProfile allows to request arbitrary profile for virt-launcher"

												properties: {
													localhostProfile: type:      "string"
													runtimeDefaultProfile: type: "boolean"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									selinuxLauncherType: type: "string"
									smbios: {
										properties: {
											family: type:       "string"
											manufacturer: type: "string"
											product: type:      "string"
											sku: type:          "string"
											version: type:      "string"
										}
										type: "object"
									}
									supportedGuestAgentVersions: {
										description: "deprecated"
										items: type: "string"
										type: "array"
									}
									tlsConfiguration: {
										description: "TLSConfiguration holds TLS options"
										properties: {
											ciphers: {
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "set"
											}
											minTLSVersion: {
												description: """
		MinTLSVersion is a way to specify the minimum protocol version that is acceptable for TLS connections. Protocol versions are based on the following most common TLS configurations:
		   https://ssl-config.mozilla.org/
		 Note that SSLv3.0 is not a supported protocol version due to well known vulnerabilities such as POODLE: https://en.wikipedia.org/wiki/POODLE
		"""

												enum: [
													"VersionTLS10",
													"VersionTLS11",
													"VersionTLS12",
													"VersionTLS13",
												]
												type: "string"
											}
										}
										type: "object"
									}
									virtualMachineInstancesPerNode: type: "integer"
									webhookConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
								}
								type: "object"
							}
							customizeComponents: {
								properties: {
									flags: {
										description: "Configure the value used for deployment and daemonset resources"

										properties: {
											api: {
												additionalProperties: type: "string"
												type: "object"
											}
											controller: {
												additionalProperties: type: "string"
												type: "object"
											}
											handler: {
												additionalProperties: type: "string"
												type: "object"
											}
										}
										type: "object"
									}
									patches: {
										items: {
											properties: {
												patch: type: "string"
												resourceName: {
													minLength: 1
													type:      "string"
												}
												resourceType: {
													minLength: 1
													type:      "string"
												}
												type: type: "string"
											}
											required: [
												"patch",
												"resourceName",
												"resourceType",
												"type",
											]
											type: "object"
										}
										type:                     "array"
										"x-kubernetes-list-type": "atomic"
									}
								}
								type: "object"
							}
							imagePullPolicy: {
								description: "The ImagePullPolicy to use."
								type:        "string"
							}
							imagePullSecrets: {
								description: "The imagePullSecrets to pull the container images from Defaults to none"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type: "object"
								}
								type:                     "array"
								"x-kubernetes-list-type": "atomic"
							}
							imageRegistry: {
								description: "The image registry to pull the container images from Defaults to the same registry the operator's container image is pulled from."

								type: "string"
							}
							imageTag: {
								description: "The image tag to use for the continer images installed. Defaults to the same tag as the operator's container image."

								type: "string"
							}
							infra: {
								description: "selectors and tolerations that should apply to KubeVirt infrastructure components"

								properties: {
									nodePlacement: {
										description: "nodePlacement describes scheduling configuration for specific KubeVirt components"

										properties: {
											affinity: {
												description: "affinity enables pod affinity/anti-affinity placement expanding the types of constraints that can be expressed with nodeSelector. affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity"

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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																			format: "int32"
																			type:   "integer"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
											nodeSelector: {
												additionalProperties: type: "string"
												description: "nodeSelector is the node selector applied to the relevant kind of pods It specifies a map of key-value pairs: for the pod to be eligible to run on a node, the node must have each of the indicated key-value pairs as labels (it can have additional labels as well). See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector"

												type: "object"
											}
											tolerations: {
												description: "tolerations is a list of tolerations applied to the relevant kind of pods See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ for more info. These are additional tolerations other than default ones."

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
										}
										type: "object"
									}
									replicas: {
										description: "replicas indicates how many replicas should be created for each KubeVirt infrastructure component (like virt-api or virt-controller). Defaults to 2. WARNING: this is an advanced feature that prevents auto-scaling for core kubevirt components. Please use with caution!"

										type: "integer"
									}
								}
								type: "object"
							}
							monitorAccount: {
								description: "The name of the Prometheus service account that needs read-access to KubeVirt endpoints Defaults to prometheus-k8s"

								type: "string"
							}
							monitorNamespace: {
								description: "The namespace Prometheus is deployed in Defaults to openshift-monitor"
								type:        "string"
							}
							productComponent: {
								description: "Designate the apps.kubevirt.io/component label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductComponent is not specified, the component label default value is kubevirt."

								type: "string"
							}
							productName: {
								description: "Designate the apps.kubevirt.io/part-of label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductName is not specified, the part-of label will be omitted."

								type: "string"
							}
							productVersion: {
								description: "Designate the apps.kubevirt.io/version label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductVersion is not specified, KubeVirt's version will be used."

								type: "string"
							}
							serviceMonitorNamespace: {
								description: "The namespace the service monitor will be deployed  When ServiceMonitorNamespace is set, then we'll install the service monitor object in that namespace otherwise we will use the monitoring namespace."

								type: "string"
							}
							uninstallStrategy: {
								description: "Specifies if kubevirt can be deleted if workloads are still present. This is mainly a precaution to avoid accidental data loss"

								type: "string"
							}
							workloadUpdateStrategy: {
								description: "WorkloadUpdateStrategy defines at the cluster level how to handle automated workload updates"

								properties: {
									batchEvictionInterval: {
										description: """
		BatchEvictionInterval Represents the interval to wait before issuing the next batch of shutdowns
		 Defaults to 1 minute
		"""

										type: "string"
									}
									batchEvictionSize: {
										description: """
		BatchEvictionSize Represents the number of VMIs that can be forced updated per the BatchShutdownInteral interval
		 Defaults to 10
		"""

										type: "integer"
									}
									workloadUpdateMethods: {
										description: """
		WorkloadUpdateMethods defines the methods that can be used to disrupt workloads during automated workload updates. When multiple methods are present, the least disruptive method takes precedence over more disruptive methods. For example if both LiveMigrate and Shutdown methods are listed, only VMs which are not live migratable will be restarted/shutdown
		 An empty list defaults to no automated workload updating
		"""

										items: type: "string"
										type:                     "array"
										"x-kubernetes-list-type": "atomic"
									}
								}
								type: "object"
							}
							workloads: {
								description: "selectors and tolerations that should apply to KubeVirt workloads"

								properties: {
									nodePlacement: {
										description: "nodePlacement describes scheduling configuration for specific KubeVirt components"

										properties: {
											affinity: {
												description: "affinity enables pod affinity/anti-affinity placement expanding the types of constraints that can be expressed with nodeSelector. affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity"

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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																			format: "int32"
																			type:   "integer"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
											nodeSelector: {
												additionalProperties: type: "string"
												description: "nodeSelector is the node selector applied to the relevant kind of pods It specifies a map of key-value pairs: for the pod to be eligible to run on a node, the node must have each of the indicated key-value pairs as labels (it can have additional labels as well). See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector"

												type: "object"
											}
											tolerations: {
												description: "tolerations is a list of tolerations applied to the relevant kind of pods See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ for more info. These are additional tolerations other than default ones."

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
										}
										type: "object"
									}
									replicas: {
										description: "replicas indicates how many replicas should be created for each KubeVirt infrastructure component (like virt-api or virt-controller). Defaults to 2. WARNING: this is an advanced feature that prevents auto-scaling for core kubevirt components. Please use with caution!"

										type: "integer"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "KubeVirtStatus represents information pertaining to a KubeVirt deployment."

						properties: {
							conditions: {
								items: {
									description: "KubeVirtCondition represents a condition of a KubeVirt deployment"

									properties: {
										lastProbeTime: {
											format:   "date-time"
											nullable: true
											type:     "string"
										}
										lastTransitionTime: {
											format:   "date-time"
											nullable: true
											type:     "string"
										}
										message: type: "string"
										reason: type:  "string"
										status: type:  "string"
										type: type:    "string"
									}
									required: [
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							generations: {
								items: {
									description: "GenerationStatus keeps track of the generation for a given resource so that decisions about forced updates can be made."

									properties: {
										group: {
											description: "group is the group of the thing you're tracking"
											type:        "string"
										}
										hash: {
											description: "hash is an optional field set for resources without generation that are content sensitive like secrets and configmaps"

											type: "string"
										}
										lastGeneration: {
											description: "lastGeneration is the last generation of the workload controller involved"

											format: "int64"
											type:   "integer"
										}
										name: {
											description: "name is the name of the thing you're tracking"
											type:        "string"
										}
										namespace: {
											description: "namespace is where the thing you're tracking is"
											type:        "string"
										}
										resource: {
											description: "resource is the resource type of the thing you're tracking"

											type: "string"
										}
									}
									required: [
										"group",
										"lastGeneration",
										"name",
										"resource",
									]
									type: "object"
								}
								type:                     "array"
								"x-kubernetes-list-type": "atomic"
							}
							observedDeploymentConfig: type: "string"
							observedDeploymentID: type:     "string"
							observedGeneration: {
								format: "int64"
								type:   "integer"
							}
							observedKubeVirtRegistry: type:                "string"
							observedKubeVirtVersion: type:                 "string"
							operatorVersion: type:                         "string"
							outdatedVirtualMachineInstanceWorkloads: type: "integer"
							phase: {
								description: "KubeVirtPhase is a label for the phase of a KubeVirt deployment at the current time."

								type: "string"
							}
							targetDeploymentConfig: type: "string"
							targetDeploymentID: type:     "string"
							targetKubeVirtRegistry: type: "string"
							targetKubeVirtVersion: type:  "string"
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1alpha3"
			schema: openAPIV3Schema: {
				description: "KubeVirt represents the object deploying all KubeVirt resources"
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
						properties: {
							certificateRotateStrategy: {
								properties: selfSigned: {
									properties: {
										ca: {
											description: "CA configuration CA certs are kept in the CA bundle as long as they are valid"

											properties: {
												duration: {
													description: "The requested 'duration' (i.e. lifetime) of the Certificate."

													type: "string"
												}
												renewBefore: {
													description: "The amount of time before the currently issued certificate's \"notAfter\" time that we will begin to attempt to renew the certificate."

													type: "string"
												}
											}
											type: "object"
										}
										caOverlapInterval: {
											description: "Deprecated. Use CA.Duration and CA.RenewBefore instead"

											type: "string"
										}
										caRotateInterval: {
											description: "Deprecated. Use CA.Duration instead"
											type:        "string"
										}
										certRotateInterval: {
											description: "Deprecated. Use Server.Duration instead"
											type:        "string"
										}
										server: {
											description: "Server configuration Certs are rotated and discarded"
											properties: {
												duration: {
													description: "The requested 'duration' (i.e. lifetime) of the Certificate."

													type: "string"
												}
												renewBefore: {
													description: "The amount of time before the currently issued certificate's \"notAfter\" time that we will begin to attempt to renew the certificate."

													type: "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "object"
							}
							configuration: {
								description: "holds kubevirt configurations. same as the virt-configMap"
								properties: {
									apiConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									controllerConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									cpuModel: type: "string"
									cpuRequest: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									defaultRuntimeClass: type: "string"
									developerConfiguration: {
										description: "DeveloperConfiguration holds developer options"
										properties: {
											cpuAllocationRatio: {
												description: "For each requested virtual CPU, CPUAllocationRatio defines how much physical CPU to request per VMI from the hosting node. The value is in fraction of a CPU thread (or core on non-hyperthreaded nodes). For example, a value of 1 means 1 physical CPU thread per VMI CPU thread. A value of 100 would be 1% of a physical thread allocated for each requested VMI thread. This option has no effect on VMIs that request dedicated CPUs. More information at: https://kubevirt.io/user-guide/operations/node_overcommit/#node-cpu-allocation-ratio Defaults to 10"

												type: "integer"
											}
											diskVerification: {
												description: "DiskVerification holds container disks verification limits"

												properties: memoryLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												required: [
													"memoryLimit",
												]
												type: "object"
											}
											featureGates: {
												description: "FeatureGates is the list of experimental features to enable. Defaults to none"

												items: type: "string"
												type: "array"
											}
											logVerbosity: {
												description: "LogVerbosity sets log verbosity level of  various components"

												properties: {
													nodeVerbosity: {
														additionalProperties: type: "integer"
														description: "NodeVerbosity represents a map of nodes with a specific verbosity level"

														type: "object"
													}
													virtAPI: type:        "integer"
													virtController: type: "integer"
													virtHandler: type:    "integer"
													virtLauncher: type:   "integer"
													virtOperator: type:   "integer"
												}
												type: "object"
											}
											memoryOvercommit: {
												description: "MemoryOvercommit is the percentage of memory we want to give VMIs compared to the amount given to its parent pod (virt-launcher). For example, a value of 102 means the VMI will \"see\" 2% more memory than its parent pod. Values under 100 are effectively \"undercommits\". Overcommits can lead to memory exhaustion, which in turn can lead to crashes. Use carefully. Defaults to 100"

												type: "integer"
											}
											minimumClusterTSCFrequency: {
												description: "Allow overriding the automatically determined minimum TSC frequency of the cluster and fixate the minimum to this frequency."

												format: "int64"
												type:   "integer"
											}
											minimumReservePVCBytes: {
												description: "MinimumReservePVCBytes is the amount of space, in bytes, to leave unused on disks. Defaults to 131072 (128KiB)"

												format: "int64"
												type:   "integer"
											}
											nodeSelectors: {
												additionalProperties: type: "string"
												description: "NodeSelectors allows restricting VMI creation to nodes that match a set of labels. Defaults to none"

												type: "object"
											}
											pvcTolerateLessSpaceUpToPercent: {
												description: "LessPVCSpaceToleration determines how much smaller, in percentage, disk PVCs are allowed to be compared to the requested size (to account for various overheads). Defaults to 10"

												type: "integer"
											}
											useEmulation: {
												description: "UseEmulation can be set to true to allow fallback to software emulation in case hardware-assisted emulation is not available. Defaults to false"

												type: "boolean"
											}
										}
										type: "object"
									}
									emulatedMachines: {
										items: type: "string"
										type: "array"
									}
									evictionStrategy: {
										description: "EvictionStrategy defines at the cluster level if the VirtualMachineInstance should be migrated instead of shut-off in case of a node drain. If the VirtualMachineInstance specific field is set it overrides the cluster level one."

										type: "string"
									}
									handlerConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									imagePullPolicy: {
										description: "PullPolicy describes a policy for if/when to pull a container image"

										type: "string"
									}
									machineType: type: "string"
									mediatedDevicesConfiguration: {
										description: "MediatedDevicesConfiguration holds information about MDEV types to be defined, if available"

										properties: {
											mediatedDeviceTypes: {
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											mediatedDevicesTypes: {
												description: "Deprecated. Use mediatedDeviceTypes instead."
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											nodeMediatedDeviceTypes: {
												items: {
													description: "NodeMediatedDeviceTypesConfig holds information about MDEV types to be defined in a specifc node that matches the NodeSelector field."

													properties: {
														mediatedDeviceTypes: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mediatedDevicesTypes: {
															description: "Deprecated. Use mediatedDeviceTypes instead."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														nodeSelector: {
															additionalProperties: type: "string"
															description: "NodeSelector is a selector which must be true for the vmi to fit on a node. Selector which must match a node's labels for the vmi to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"

															type: "object"
														}
													}
													required: [
														"nodeSelector",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
										}
										type: "object"
									}
									memBalloonStatsPeriod: {
										format: "int32"
										type:   "integer"
									}
									migrations: {
										description: "MigrationConfiguration holds migration options. Can be overridden for specific groups of VMs though migration policies. Visit https://kubevirt.io/user-guide/operations/migration_policies/ for more information."

										properties: {
											allowAutoConverge: {
												description: "AllowAutoConverge allows the platform to compromise performance/availability of VMIs to guarantee successful VMI live migrations. Defaults to false"

												type: "boolean"
											}
											allowPostCopy: {
												description: "AllowPostCopy enables post-copy live migrations. Such migrations allow even the busiest VMIs to successfully live-migrate. However, events like a network failure can cause a VMI crash. If set to true, migrations will still start in pre-copy, but switch to post-copy when CompletionTimeoutPerGiB triggers. Defaults to false"

												type: "boolean"
											}
											bandwidthPerMigration: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description: "BandwidthPerMigration limits the amount of network bandwith live migrations are allowed to use. The value is in quantity per second. Defaults to 0 (no limit)"

												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
											completionTimeoutPerGiB: {
												description: "CompletionTimeoutPerGiB is the maximum number of seconds per GiB a migration is allowed to take. If a live-migration takes longer to migrate than this value multiplied by the size of the VMI, the migration will be cancelled, unless AllowPostCopy is true. Defaults to 800"

												format: "int64"
												type:   "integer"
											}
											disableTLS: {
												description: "When set to true, DisableTLS will disable the additional layer of live migration encryption provided by KubeVirt. This is usually a bad idea. Defaults to false"

												type: "boolean"
											}
											network: {
												description: "Network is the name of the CNI network to use for live migrations. By default, migrations go through the pod network."

												type: "string"
											}
											nodeDrainTaintKey: {
												description: "NodeDrainTaintKey defines the taint key that indicates a node should be drained. Note: this option relies on the deprecated node taint feature. Default: kubevirt.io/drain"

												type: "string"
											}
											parallelMigrationsPerCluster: {
												description: "ParallelMigrationsPerCluster is the total number of concurrent live migrations allowed cluster-wide. Defaults to 5"

												format: "int32"
												type:   "integer"
											}
											parallelOutboundMigrationsPerNode: {
												description: "ParallelOutboundMigrationsPerNode is the maximum number of concurrent outgoing live migrations allowed per node. Defaults to 2"

												format: "int32"
												type:   "integer"
											}
											progressTimeout: {
												description: "ProgressTimeout is the maximum number of seconds a live migration is allowed to make no progress. Hitting this timeout means a migration transferred 0 data for that many seconds. The migration is then considered stuck and therefore cancelled. Defaults to 150"

												format: "int64"
												type:   "integer"
											}
											unsafeMigrationOverride: {
												description: "UnsafeMigrationOverride allows live migrations to occur even if the compatibility check indicates the migration will be unsafe to the guest. Defaults to false"

												type: "boolean"
											}
										}
										type: "object"
									}
									minCPUModel: type: "string"
									network: {
										description: "NetworkConfiguration holds network options"
										properties: {
											defaultNetworkInterface: type:           "string"
											permitBridgeInterfaceOnPodNetwork: type: "boolean"
											permitSlirpInterface: type:              "boolean"
										}
										type: "object"
									}
									obsoleteCPUModels: {
										additionalProperties: type: "boolean"
										type: "object"
									}
									ovmfPath: type: "string"
									permittedHostDevices: {
										description: "PermittedHostDevices holds information about devices allowed for passthrough"

										properties: {
											mediatedDevices: {
												items: {
													description: "MediatedHostDevice represents a host mediated device allowed for passthrough"

													properties: {
														externalResourceProvider: type: "boolean"
														mdevNameSelector: type:         "string"
														resourceName: type:             "string"
													}
													required: [
														"mdevNameSelector",
														"resourceName",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
											pciHostDevices: {
												items: {
													description: "PciHostDevice represents a host PCI device allowed for passthrough"

													properties: {
														externalResourceProvider: {
															description: "If true, KubeVirt will leave the allocation and monitoring to an external device plugin"

															type: "boolean"
														}
														pciVendorSelector: {
															description: "The vendor_id:product_id tuple of the PCI device"

															type: "string"
														}
														resourceName: {
															description: "The name of the resource that is representing the device. Exposed by a device plugin and requested by VMs. Typically of the form vendor.com/product_nameThe name of the resource that is representing the device. Exposed by a device plugin and requested by VMs. Typically of the form vendor.com/product_name"

															type: "string"
														}
													}
													required: [
														"pciVendorSelector",
														"resourceName",
													]
													type: "object"
												}
												type:                     "array"
												"x-kubernetes-list-type": "atomic"
											}
										}
										type: "object"
									}
									seccompConfiguration: {
										description: "SeccompConfiguration holds Seccomp configuration for Kubevirt components"

										properties: virtualMachineInstanceProfile: {
											description: "VirtualMachineInstanceProfile defines what profile should be used with virt-launcher. Defaults to none"

											properties: customProfile: {
												description: "CustomProfile allows to request arbitrary profile for virt-launcher"

												properties: {
													localhostProfile: type:      "string"
													runtimeDefaultProfile: type: "boolean"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									selinuxLauncherType: type: "string"
									smbios: {
										properties: {
											family: type:       "string"
											manufacturer: type: "string"
											product: type:      "string"
											sku: type:          "string"
											version: type:      "string"
										}
										type: "object"
									}
									supportedGuestAgentVersions: {
										description: "deprecated"
										items: type: "string"
										type: "array"
									}
									tlsConfiguration: {
										description: "TLSConfiguration holds TLS options"
										properties: {
											ciphers: {
												items: type: "string"
												type:                     "array"
												"x-kubernetes-list-type": "set"
											}
											minTLSVersion: {
												description: """
		MinTLSVersion is a way to specify the minimum protocol version that is acceptable for TLS connections. Protocol versions are based on the following most common TLS configurations:
		   https://ssl-config.mozilla.org/
		 Note that SSLv3.0 is not a supported protocol version due to well known vulnerabilities such as POODLE: https://en.wikipedia.org/wiki/POODLE
		"""

												enum: [
													"VersionTLS10",
													"VersionTLS11",
													"VersionTLS12",
													"VersionTLS13",
												]
												type: "string"
											}
										}
										type: "object"
									}
									virtualMachineInstancesPerNode: type: "integer"
									webhookConfiguration: {
										description: "ReloadableComponentConfiguration holds all generic k8s configuration options which can be reloaded by components without requiring a restart."

										properties: restClient: {
											description: "RestClient can be used to tune certain aspects of the k8s client in use."

											properties: rateLimiter: {
												description: "RateLimiter allows selecting and configuring different rate limiters for the k8s client."

												properties: tokenBucketRateLimiter: {
													properties: {
														burst: {
															description: "Maximum burst for throttle. If it's zero, the component default will be used"

															type: "integer"
														}
														qps: {
															description: "QPS indicates the maximum QPS to the apiserver from this client. If it's zero, the component default will be used"

															type: "number"
														}
													}
													required: [
														"burst",
														"qps",
													]
													type: "object"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
								}
								type: "object"
							}
							customizeComponents: {
								properties: {
									flags: {
										description: "Configure the value used for deployment and daemonset resources"

										properties: {
											api: {
												additionalProperties: type: "string"
												type: "object"
											}
											controller: {
												additionalProperties: type: "string"
												type: "object"
											}
											handler: {
												additionalProperties: type: "string"
												type: "object"
											}
										}
										type: "object"
									}
									patches: {
										items: {
											properties: {
												patch: type: "string"
												resourceName: {
													minLength: 1
													type:      "string"
												}
												resourceType: {
													minLength: 1
													type:      "string"
												}
												type: type: "string"
											}
											required: [
												"patch",
												"resourceName",
												"resourceType",
												"type",
											]
											type: "object"
										}
										type:                     "array"
										"x-kubernetes-list-type": "atomic"
									}
								}
								type: "object"
							}
							imagePullPolicy: {
								description: "The ImagePullPolicy to use."
								type:        "string"
							}
							imagePullSecrets: {
								description: "The imagePullSecrets to pull the container images from Defaults to none"

								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."

									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

										type: "string"
									}
									type: "object"
								}
								type:                     "array"
								"x-kubernetes-list-type": "atomic"
							}
							imageRegistry: {
								description: "The image registry to pull the container images from Defaults to the same registry the operator's container image is pulled from."

								type: "string"
							}
							imageTag: {
								description: "The image tag to use for the continer images installed. Defaults to the same tag as the operator's container image."

								type: "string"
							}
							infra: {
								description: "selectors and tolerations that should apply to KubeVirt infrastructure components"

								properties: {
									nodePlacement: {
										description: "nodePlacement describes scheduling configuration for specific KubeVirt components"

										properties: {
											affinity: {
												description: "affinity enables pod affinity/anti-affinity placement expanding the types of constraints that can be expressed with nodeSelector. affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity"

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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																			format: "int32"
																			type:   "integer"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
											nodeSelector: {
												additionalProperties: type: "string"
												description: "nodeSelector is the node selector applied to the relevant kind of pods It specifies a map of key-value pairs: for the pod to be eligible to run on a node, the node must have each of the indicated key-value pairs as labels (it can have additional labels as well). See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector"

												type: "object"
											}
											tolerations: {
												description: "tolerations is a list of tolerations applied to the relevant kind of pods See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ for more info. These are additional tolerations other than default ones."

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
										}
										type: "object"
									}
									replicas: {
										description: "replicas indicates how many replicas should be created for each KubeVirt infrastructure component (like virt-api or virt-controller). Defaults to 2. WARNING: this is an advanced feature that prevents auto-scaling for core kubevirt components. Please use with caution!"

										type: "integer"
									}
								}
								type: "object"
							}
							monitorAccount: {
								description: "The name of the Prometheus service account that needs read-access to KubeVirt endpoints Defaults to prometheus-k8s"

								type: "string"
							}
							monitorNamespace: {
								description: "The namespace Prometheus is deployed in Defaults to openshift-monitor"
								type:        "string"
							}
							productComponent: {
								description: "Designate the apps.kubevirt.io/component label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductComponent is not specified, the component label default value is kubevirt."

								type: "string"
							}
							productName: {
								description: "Designate the apps.kubevirt.io/part-of label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductName is not specified, the part-of label will be omitted."

								type: "string"
							}
							productVersion: {
								description: "Designate the apps.kubevirt.io/version label for KubeVirt components. Useful if KubeVirt is included as part of a product. If ProductVersion is not specified, KubeVirt's version will be used."

								type: "string"
							}
							serviceMonitorNamespace: {
								description: "The namespace the service monitor will be deployed  When ServiceMonitorNamespace is set, then we'll install the service monitor object in that namespace otherwise we will use the monitoring namespace."

								type: "string"
							}
							uninstallStrategy: {
								description: "Specifies if kubevirt can be deleted if workloads are still present. This is mainly a precaution to avoid accidental data loss"

								type: "string"
							}
							workloadUpdateStrategy: {
								description: "WorkloadUpdateStrategy defines at the cluster level how to handle automated workload updates"

								properties: {
									batchEvictionInterval: {
										description: """
		BatchEvictionInterval Represents the interval to wait before issuing the next batch of shutdowns
		 Defaults to 1 minute
		"""

										type: "string"
									}
									batchEvictionSize: {
										description: """
		BatchEvictionSize Represents the number of VMIs that can be forced updated per the BatchShutdownInteral interval
		 Defaults to 10
		"""

										type: "integer"
									}
									workloadUpdateMethods: {
										description: """
		WorkloadUpdateMethods defines the methods that can be used to disrupt workloads during automated workload updates. When multiple methods are present, the least disruptive method takes precedence over more disruptive methods. For example if both LiveMigrate and Shutdown methods are listed, only VMs which are not live migratable will be restarted/shutdown
		 An empty list defaults to no automated workload updating
		"""

										items: type: "string"
										type:                     "array"
										"x-kubernetes-list-type": "atomic"
									}
								}
								type: "object"
							}
							workloads: {
								description: "selectors and tolerations that should apply to KubeVirt workloads"

								properties: {
									nodePlacement: {
										description: "nodePlacement describes scheduling configuration for specific KubeVirt components"

										properties: {
											affinity: {
												description: "affinity enables pod affinity/anti-affinity placement expanding the types of constraints that can be expressed with nodeSelector. affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity"

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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																								type: "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																								type: "string"
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

																			format: "int32"
																			type:   "integer"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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

																							type: "string"
																						}
																						operator: {
																							description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."

																							type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
																					type: "object"
																				}
																				namespaceSelector: {
																					description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																					type: "object"
																				}
																				namespaces: {
																					description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																					items: type: "string"
																					type: "array"
																				}
																				topologyKey: {
																					description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																					type: "string"
																				}
																			}
																			required: [
																				"topologyKey",
																			]
																			type: "object"
																		}
																		weight: {
																			description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."

																			format: "int32"
																			type:   "integer"
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
																			type: "object"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces. This field is beta-level and is only honored when PodAffinityNamespaceSelector feature is enabled."

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
																			type: "object"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\""

																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."

																			type: "string"
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
											nodeSelector: {
												additionalProperties: type: "string"
												description: "nodeSelector is the node selector applied to the relevant kind of pods It specifies a map of key-value pairs: for the pod to be eligible to run on a node, the node must have each of the indicated key-value pairs as labels (it can have additional labels as well). See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector"

												type: "object"
											}
											tolerations: {
												description: "tolerations is a list of tolerations applied to the relevant kind of pods See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ for more info. These are additional tolerations other than default ones."

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
										}
										type: "object"
									}
									replicas: {
										description: "replicas indicates how many replicas should be created for each KubeVirt infrastructure component (like virt-api or virt-controller). Defaults to 2. WARNING: this is an advanced feature that prevents auto-scaling for core kubevirt components. Please use with caution!"

										type: "integer"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "KubeVirtStatus represents information pertaining to a KubeVirt deployment."

						properties: {
							conditions: {
								items: {
									description: "KubeVirtCondition represents a condition of a KubeVirt deployment"

									properties: {
										lastProbeTime: {
											format:   "date-time"
											nullable: true
											type:     "string"
										}
										lastTransitionTime: {
											format:   "date-time"
											nullable: true
											type:     "string"
										}
										message: type: "string"
										reason: type:  "string"
										status: type:  "string"
										type: type:    "string"
									}
									required: [
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							generations: {
								items: {
									description: "GenerationStatus keeps track of the generation for a given resource so that decisions about forced updates can be made."

									properties: {
										group: {
											description: "group is the group of the thing you're tracking"
											type:        "string"
										}
										hash: {
											description: "hash is an optional field set for resources without generation that are content sensitive like secrets and configmaps"

											type: "string"
										}
										lastGeneration: {
											description: "lastGeneration is the last generation of the workload controller involved"

											format: "int64"
											type:   "integer"
										}
										name: {
											description: "name is the name of the thing you're tracking"
											type:        "string"
										}
										namespace: {
											description: "namespace is where the thing you're tracking is"
											type:        "string"
										}
										resource: {
											description: "resource is the resource type of the thing you're tracking"

											type: "string"
										}
									}
									required: [
										"group",
										"lastGeneration",
										"name",
										"resource",
									]
									type: "object"
								}
								type:                     "array"
								"x-kubernetes-list-type": "atomic"
							}
							observedDeploymentConfig: type: "string"
							observedDeploymentID: type:     "string"
							observedGeneration: {
								format: "int64"
								type:   "integer"
							}
							observedKubeVirtRegistry: type:                "string"
							observedKubeVirtVersion: type:                 "string"
							operatorVersion: type:                         "string"
							outdatedVirtualMachineInstanceWorkloads: type: "integer"
							phase: {
								description: "KubeVirtPhase is a label for the phase of a KubeVirt deployment at the current time."

								type: "string"
							}
							targetDeploymentConfig: type: "string"
							targetDeploymentID: type:     "string"
							targetKubeVirtRegistry: type: "string"
							targetKubeVirtVersion: type:  "string"
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
