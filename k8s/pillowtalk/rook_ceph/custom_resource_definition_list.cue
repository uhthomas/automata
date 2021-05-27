package rook_ceph

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

customResourceDefinitionList: apiextensionsv1.#CustomResourceDefinitionList & {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinitionList"
	items: [...{
		apiVersion: "apiextensions.k8s.io/v1"
		kind:       "CustomResourceDefinition"
	}]
}

customResourceDefinitionList: items: [{
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephblockpools.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephBlockPool"
			listKind: "CephBlockPoolList"
			plural:   "cephblockpools"
			singular: "cephblockpool"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephBlockPool represents a Ceph Storage Pool"
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
						description: "PoolSpec represents the spec of ceph pool"
						properties: {
							compressionMode: {
								default:     "none"
								description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
								enum: [
									"none",
									"passive",
									"aggressive",
									"force",
									"",
								]
								nullable: true
								type:     "string"
							}
							crushRoot: {
								description: "The root of the crush hierarchy utilized by the pool"
								nullable:    true
								type:        "string"
							}
							deviceClass: {
								description: "The device class the OSD should set to for use in the pool"
								nullable:    true
								type:        "string"
							}
							enableRBDStats: {
								description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
								type:        "boolean"
							}
							erasureCoded: {
								description: "The erasure code settings"
								properties: {
									algorithm: {
										description: "The algorithm for erasure coding"
										type:        "string"
									}
									codingChunks: {
										description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
										maximum:     9
										minimum:     0
										type:        "integer"
									}
									dataChunks: {
										description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
										maximum:     9
										minimum:     0
										type:        "integer"
									}
								}
								required: [
									"codingChunks",
									"dataChunks",
								]
								type: "object"
							}
							failureDomain: {
								description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
								type:        "string"
							}
							mirroring: {
								description: "The mirroring settings"
								properties: {
									enabled: {
										description: "Enabled whether this pool is mirrored or not"
										type:        "boolean"
									}
									mode: {
										description: "Mode is the mirroring mode: either pool or image"
										type:        "string"
									}
									snapshotSchedules: {
										description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
										items: {
											description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
											properties: {
												interval: {
													description: "Interval represent the periodicity of the snapshot."
													type:        "string"
												}
												startTime: {
													description: "StartTime indicates when to start the snapshot"
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
							parameters: {
								additionalProperties: type: "string"
								description:                            "Parameters is a list of properties to enable on a given pool"
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							quotas: {
								description: "The quota settings"
								nullable:    true
								properties: {
									maxBytes: {
										description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
										format:      "int64"
										type:        "integer"
									}
									maxObjects: {
										description: "MaxObjects represents the quota in objects"
										format:      "int64"
										type:        "integer"
									}
									maxSize: {
										description: "MaxSize represents the quota in bytes as a string"
										pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
										type:        "string"
									}
								}
								type: "object"
							}
							replicated: {
								description: "The replication settings"
								properties: {
									replicasPerFailureDomain: {
										description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
										minimum:     1
										type:        "integer"
									}
									requireSafeReplicaSize: {
										description: "RequireSafeReplicaSize if false allows you to set replica 1"
										type:        "boolean"
									}
									size: {
										description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
										minimum:     0
										type:        "integer"
									}
									subFailureDomain: {
										description: "SubFailureDomain the name of the sub-failure domain"
										type:        "string"
									}
									targetSizeRatio: {
										description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
										type:        "number"
									}
								}
								required: [
									"size",
								]
								type: "object"
							}
							statusCheck: {
								description: "The mirroring statusCheck"
								properties: mirror: {
									description: "HealthCheckSpec represents the health check of an object store bucket"
									nullable:    true
									properties: {
										disabled: type: "boolean"
										interval: {
											description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
											type:        "string"
										}
										timeout: type: "string"
									}
									type: "object"
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
						}
						type: "object"
					}
					status: {
						description: "CephBlockPoolStatus represents the mirroring status of Ceph Storage Pool"
						properties: {
							info: {
								additionalProperties: type: "string"
								description: "Use only info and put mirroringStatus in it?"
								nullable:    true
								type:        "object"
							}
							mirroringInfo: {
								description: "MirroringInfoSpec is the status of the pool mirroring"
								properties: {
									details: type:     "string"
									lastChanged: type: "string"
									lastChecked: type: "string"
									mode: {
										description: "Mode is the mirroring mode"
										type:        "string"
									}
									peers: {
										description: "Peers are the list of peer sites connected to that cluster"
										items: {
											description: "PeersSpec contains peer details"
											properties: {
												client_name: {
													description: "ClientName is the CephX user used to connect to the peer"
													type:        "string"
												}
												direction: {
													description: "Direction is the peer mirroring direction"
													type:        "string"
												}
												mirror_uuid: {
													description: "MirrorUUID is the mirror UUID"
													type:        "string"
												}
												site_name: {
													description: "SiteName is the current site name"
													type:        "string"
												}
												uuid: {
													description: "UUID is the peer UUID"
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									site_name: {
										description: "SiteName is the current site name"
										type:        "string"
									}
								}
								type: "object"
							}
							mirroringStatus: {
								description: "MirroringStatusSpec is the status of the pool mirroring"
								properties: {
									details: {
										description: "Details contains potential status errors"
										type:        "string"
									}
									lastChanged: {
										description: "LastChanged is the last time time the status last changed"
										type:        "string"
									}
									lastChecked: {
										description: "LastChecked is the last time time the status was checked"
										type:        "string"
									}
									summary: {
										description: "Summary is the mirroring status summary"
										properties: {
											daemon_health: {
												description: "DaemonHealth is the health of the mirroring daemon"
												type:        "string"
											}
											health: {
												description: "Health is the mirroring health"
												type:        "string"
											}
											image_health: {
												description: "ImageHealth is the health of the mirrored image"
												type:        "string"
											}
											states: {
												description: "States is the various state for all mirrored images"
												nullable:    true
												properties: {
													error: {
														description: "Error is when the mirroring state is errored"
														type:        "integer"
													}
													replaying: {
														description: "Replaying is when the replay of the mirroring journal is on-going"
														type:        "integer"
													}
													starting_replay: {
														description: "StartingReplay is when the replay of the mirroring journal starts"
														type:        "integer"
													}
													stopped: {
														description: "Stopped is when the mirroring state is stopped"
														type:        "integer"
													}
													stopping_replay: {
														description: "StopReplaying is when the replay of the mirroring journal stops"
														type:        "integer"
													}
													syncing: {
														description: "Syncing is when the image is syncing"
														type:        "integer"
													}
													unknown: {
														description: "Unknown is when the mirroring state is unknown"
														type:        "integer"
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
							phase: {
								description: "ConditionType represent a resource's status"
								type:        "string"
							}
							snapshotScheduleStatus: {
								description: "SnapshotScheduleStatusSpec is the status of the snapshot schedule"
								properties: {
									details: {
										description: "Details contains potential status errors"
										type:        "string"
									}
									lastChanged: {
										description: "LastChanged is the last time time the status last changed"
										type:        "string"
									}
									lastChecked: {
										description: "LastChecked is the last time time the status was checked"
										type:        "string"
									}
									snapshotSchedules: {
										description: "SnapshotSchedules is the list of snapshots scheduled"
										items: {
											description: "SnapshotSchedulesSpec is the list of snapshot scheduled for images in a pool"
											properties: {
												image: {
													description: "Image is the mirrored image"
													type:        "string"
												}
												items: {
													description: "Items is the list schedules times for a given snapshot"
													items: {
														description: "SnapshotSchedule is a schedule"
														properties: {
															interval: {
																description: "Interval is the interval in which snapshots will be taken"
																type:        "string"
															}
															start_time: {
																description: "StartTime is the snapshot starting time"
																type:        "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												namespace: {
													description: "Namespace is the RADOS namespace the image is part of"
													type:        "string"
												}
												pool: {
													description: "Pool is the pool name"
													type:        "string"
												}
											}
											type: "object"
										}
										nullable: true
										type:     "array"
									}
								}
								type: "object"
							}
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephclients.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephClient"
			listKind: "CephClientList"
			plural:   "cephclients"
			singular: "cephclient"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephClient represents a Ceph Client"
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
						description: "Spec represents the specification of a Ceph Client"
						properties: {
							caps: {
								additionalProperties: type: "string"
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							name: type: "string"
						}
						required: [
							"caps",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of a Ceph Client"
						properties: {
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
							}
							phase: {
								description: "ConditionType represent a resource's status"
								type:        "string"
							}
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephclusters.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephCluster"
			listKind: "CephClusterList"
			plural:   "cephclusters"
			singular: "cephcluster"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "Directory used on the K8s nodes"
				jsonPath:    ".spec.dataDirHostPath"
				name:        "DataDirHostPath"
				type:        "string"
			}, {
				description: "Number of MONs"
				jsonPath:    ".spec.mon.count"
				name:        "MonCount"
				type:        "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				description: "Phase"
				jsonPath:    ".status.phase"
				name:        "Phase"
				type:        "string"
			}, {
				description: "Message"
				jsonPath:    ".status.message"
				name:        "Message"
				type:        "string"
			}, {
				description: "Ceph Health"
				jsonPath:    ".status.ceph.health"
				name:        "Health"
				type:        "string"
			}, {
				jsonPath: ".spec.external.enable"
				name:     "External"
				type:     "boolean"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephCluster is a Ceph storage cluster"
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
						description: "ClusterSpec represents the specification of Ceph Cluster"
						properties: {
							annotations: {
								additionalProperties: {
									additionalProperties: type: "string"
									description: "Annotations are annotations"
									type:        "object"
								}
								description:                            "The annotations-related configuration to add/set on each Pod related object."
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							cephVersion: {
								description: "The version information that instructs Rook to orchestrate a particular version of Ceph."
								nullable:    true
								properties: {
									allowUnsupported: {
										description: "Whether to allow unsupported versions (do not set to true in production)"
										type:        "boolean"
									}
									image: {
										description: "Image is the container image used to launch the ceph daemons, such as ceph/ceph:v15.2.11"
										type:        "string"
									}
								}
								required: [
									"image",
								]
								type: "object"
							}
							cleanupPolicy: {
								description: "Indicates user intent when deleting a cluster; blocks orchestration and should not be set if cluster deletion is not imminent."
								nullable:    true
								properties: {
									allowUninstallWithVolumes: {
										description: "AllowUninstallWithVolumes defines whether we can proceed with the uninstall if they are RBD images still present"
										type:        "boolean"
									}
									confirmation: {
										description: "Confirmation represents the cleanup confirmation"
										nullable:    true
										pattern:     "^$|^yes-really-destroy-data$"
										type:        "string"
									}
									sanitizeDisks: {
										description: "SanitizeDisks represents way we sanitize disks"
										nullable:    true
										properties: {
											dataSource: {
												description: "DataSource is the data source to use to sanitize the disk with"
												enum: [
													"zero",
													"random",
												]
												type: "string"
											}
											iteration: {
												description: "Iteration is the number of pass to apply the sanitizing"
												format:      "int32"
												type:        "integer"
											}
											method: {
												description: "Method is the method we use to sanitize disks"
												enum: [
													"complete",
													"quick",
												]
												type: "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							continueUpgradeAfterChecksEvenIfNotHealthy: {
								description: "ContinueUpgradeAfterChecksEvenIfNotHealthy defines if an upgrade should continue even if PGs are not clean"
								type:        "boolean"
							}
							crashCollector: {
								description: "A spec for the crash controller"
								nullable:    true
								properties: {
									daysToRetain: {
										description: "DaysToRetain represents the number of days to retain crash until they get pruned"
										type:        "integer"
									}
									disable: {
										description: "Disable determines whether we should enable the crash collector"
										type:        "boolean"
									}
								}
								type: "object"
							}
							dashboard: {
								description: "Dashboard settings"
								nullable:    true
								properties: {
									enabled: {
										description: "Enabled determines whether to enable the dashboard"
										type:        "boolean"
									}
									port: {
										description: "Port is the dashboard webserver port"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
									ssl: {
										description: "SSL determines whether SSL should be used"
										type:        "boolean"
									}
									urlPrefix: {
										description: "URLPrefix is a prefix for all URLs to use the dashboard with a reverse proxy"
										type:        "string"
									}
								}
								type: "object"
							}
							dataDirHostPath: {
								description: "The path on the host where config and data can be persisted"
								pattern:     "^/(\\S+)"
								type:        "string"
							}
							disruptionManagement: {
								description: "A spec for configuring disruption management."
								nullable:    true
								properties: {
									machineDisruptionBudgetNamespace: {
										description: "Namespace to look for MDBs by the machineDisruptionBudgetController"
										type:        "string"
									}
									manageMachineDisruptionBudgets: {
										description: "This enables management of machinedisruptionbudgets"
										type:        "boolean"
									}
									managePodBudgets: {
										description: "This enables management of poddisruptionbudgets"
										type:        "boolean"
									}
									osdMaintenanceTimeout: {
										description: "OSDMaintenanceTimeout sets how many additional minutes the DOWN/OUT interval is for drained failure domains it only works if managePodBudgets is true. the default is 30 minutes"
										format:      "int64"
										type:        "integer"
									}
									pgHealthCheckTimeout: {
										description: "PGHealthCheckTimeout is the time (in minutes) that the operator will wait for the placement groups to become healthy (active+clean) after a drain was completed and OSDs came back up. Rook will continue with the next drain if the timeout exceeds. It only works if managePodBudgets is true. No values or 0 means that the operator will wait until the placement groups are healthy before unblocking the next drain."
										format:      "int64"
										type:        "integer"
									}
								}
								type: "object"
							}
							external: {
								description: "Whether the Ceph Cluster is running external to this Kubernetes cluster mon, mgr, osd, mds, and discover daemons will not be created for external clusters."
								nullable:    true
								properties: enable: {
									description: "Enable determines whether external mode is enabled or not"
									type:        "boolean"
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							healthCheck: {
								description: "Internal daemon healthchecks and liveness probe"
								nullable:    true
								properties: {
									daemonHealth: {
										description: "DaemonHealth is the health check for a given daemon"
										nullable:    true
										properties: {
											mon: {
												description: "Monitor represents the health check settings for the Ceph monitor"
												nullable:    true
												properties: {
													disabled: type: "boolean"
													interval: {
														description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
														type:        "string"
													}
													timeout: type: "string"
												}
												type: "object"
											}
											osd: {
												description: "ObjectStorageDaemon represents the health check settings for the Ceph OSDs"
												nullable:    true
												properties: {
													disabled: type: "boolean"
													interval: {
														description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
														type:        "string"
													}
													timeout: type: "string"
												}
												type: "object"
											}
											status: {
												description: "Status represents the health check settings for the Ceph health"
												nullable:    true
												properties: {
													disabled: type: "boolean"
													interval: {
														description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
														type:        "string"
													}
													timeout: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
									livenessProbe: {
										additionalProperties: {
											description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
											properties: {
												disabled: {
													description: "Disabled determines whether probe is disable or not"
													type:        "boolean"
												}
												probe: {
													description: "Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic."
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
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
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
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
														timeoutSeconds: {
															description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
															format:      "int32"
															type:        "integer"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										description: "LivenessProbe allows to change the livenessprobe configuration for a given daemon"
										type:        "object"
									}
								}
								type: "object"
							}
							labels: {
								additionalProperties: {
									additionalProperties: type: "string"
									description: "Labels are label for a given daemons"
									type:        "object"
								}
								description:                            "The labels-related configuration to add/set on each Pod related object."
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							logCollector: {
								description: "Logging represents loggings settings"
								nullable:    true
								properties: {
									enabled: {
										description: "Enabled represents whether the log collector is enabled"
										type:        "boolean"
									}
									periodicity: {
										description: "Periodicity is the periodicity of the log rotation"
										type:        "string"
									}
								}
								type: "object"
							}
							mgr: {
								description: "A spec for mgr related options"
								nullable:    true
								properties: {
									allowMultiplePerNode: {
										description: "AllowMultiplePerNode allows to run multiple managers on the same node (not recommended)"
										type:        "boolean"
									}
									count: {
										description: "Count is the number of manager to run"
										maximum:     2
										minimum:     0
										type:        "integer"
									}
									modules: {
										description: "Modules is the list of ceph manager modules to enable/disable"
										items: {
											description: "Module represents mgr modules that the user wants to enable or disable"
											properties: {
												enabled: {
													description: "Enabled determines whether a module should be enabled or not"
													type:        "boolean"
												}
												name: {
													description: "Name is the name of the ceph manager module"
													type:        "string"
												}
											}
											type: "object"
										}
										nullable: true
										type:     "array"
									}
								}
								type: "object"
							}
							mon: {
								description: "A spec for mon related options"
								nullable:    true
								properties: {
									allowMultiplePerNode: {
										description: "AllowMultiplePerNode determines if we can run multiple monitors on the same node (not recommended)"
										type:        "boolean"
									}
									count: {
										description: "Count is the number of Ceph monitors"
										minimum:     0
										type:        "integer"
									}
									stretchCluster: {
										description: "StretchCluster is the stretch cluster specification"
										properties: {
											failureDomainLabel: {
												description: "FailureDomainLabel the failure domain name (e,g: zone)"
												type:        "string"
											}
											subFailureDomain: {
												description: "SubFailureDomain is the failure domain within a zone"
												type:        "string"
											}
											zones: {
												description: "Zones is the list of zones"
												items: {
													description: "StretchClusterZoneSpec represents the specification of a stretched zone in a Ceph Cluster"
													properties: {
														arbiter: {
															description: "Arbiter determines if the zone contains the arbiter"
															type:        "boolean"
														}
														name: {
															description: "Name is the name of the zone"
															type:        "string"
														}
														volumeClaimTemplate: {
															description: "VolumeClaimTemplate is the PVC template"
															properties: {
																apiVersion: {
																	description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
																	type:        "string"
																}
																kind: {
																	description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
																	type:        "string"
																}
																metadata: {
																	description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
																	properties: {
																		annotations: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																		finalizers: {
																			items: type: "string"
																			type: "array"
																		}
																		labels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																		name: type:      "string"
																		namespace: type: "string"
																	}
																	type: "object"
																}
																spec: {
																	description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																	properties: {
																		accessModes: {
																			description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																			items: type: "string"
																			type: "array"
																		}
																		dataSource: {
																			description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) * An existing custom resource that implements data population (Alpha) In order to use custom resource types that implement data population, the AnyVolumeDataSource feature gate must be enabled. If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source."
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
																			description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
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
																					description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
																					description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																					type:        "object"
																				}
																			}
																			type: "object"
																		}
																		selector: {
																			description: "A label query over volumes to consider for binding."
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
																			description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																			type:        "string"
																		}
																		volumeMode: {
																			description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
																			type:        "string"
																		}
																		volumeName: {
																			description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
																			type:        "string"
																		}
																	}
																	type: "object"
																}
																status: {
																	description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																	properties: {
																		accessModes: {
																			description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																			items: type: "string"
																			type: "array"
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
																			description: "Represents the actual resources of the underlying volume."
																			type:        "object"
																		}
																		conditions: {
																			description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
																			items: {
																				description: "PersistentVolumeClaimCondition contails details about state of pvc"
																				properties: {
																					lastProbeTime: {
																						description: "Last time we probed the condition."
																						format:      "date-time"
																						type:        "string"
																					}
																					lastTransitionTime: {
																						description: "Last time the condition transitioned from one status to another."
																						format:      "date-time"
																						type:        "string"
																					}
																					message: {
																						description: "Human-readable message indicating details about last transition."
																						type:        "string"
																					}
																					reason: {
																						description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																						type:        "string"
																					}
																					status: type: "string"
																					type: {
																						description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																						type:        "string"
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
																			description: "Phase represents the current phase of PersistentVolumeClaim."
																			type:        "string"
																		}
																	}
																	type: "object"
																}
															}
															type:                                   "object"
															"x-kubernetes-preserve-unknown-fields": true
														}
													}
													type: "object"
												}
												nullable: true
												type:     "array"
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "VolumeClaimTemplate is the PVC definition"
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											metadata: {
												description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
												properties: {
													annotations: {
														additionalProperties: type: "string"
														type: "object"
													}
													finalizers: {
														items: type: "string"
														type: "array"
													}
													labels: {
														additionalProperties: type: "string"
														type: "object"
													}
													name: type:      "string"
													namespace: type: "string"
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													dataSource: {
														description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) * An existing custom resource that implements data population (Alpha) In order to use custom resource types that implement data population, the AnyVolumeDataSource feature gate must be enabled. If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source."
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
														description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
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
																description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
																description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
														}
														type: "object"
													}
													selector: {
														description: "A label query over volumes to consider for binding."
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
														description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
														type:        "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
														type:        "string"
													}
													volumeName: {
														description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
														type:        "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
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
														description: "Represents the actual resources of the underlying volume."
														type:        "object"
													}
													conditions: {
														description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"
															properties: {
																lastProbeTime: {
																	description: "Last time we probed the condition."
																	format:      "date-time"
																	type:        "string"
																}
																lastTransitionTime: {
																	description: "Last time the condition transitioned from one status to another."
																	format:      "date-time"
																	type:        "string"
																}
																message: {
																	description: "Human-readable message indicating details about last transition."
																	type:        "string"
																}
																reason: {
																	description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																	type:        "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																	type:        "string"
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
														description: "Phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: [
									"count",
								]
								type: "object"
							}
							monitoring: {
								description: "Prometheus based Monitoring settings"
								nullable:    true
								properties: {
									enabled: {
										description: "Enabled determines whether to create the prometheus rules for the ceph cluster. If true, the prometheus types must exist or the creation will fail."
										type:        "boolean"
									}
									externalMgrEndpoints: {
										description: "ExternalMgrEndpoints points to an existing Ceph prometheus exporter endpoint"
										items: {
											description: "EndpointAddress is a tuple that describes single IP address."
											properties: {
												hostname: {
													description: "The Hostname of this endpoint"
													type:        "string"
												}
												ip: {
													description: "The IP of this endpoint. May not be loopback (127.0.0.0/8), link-local (169.254.0.0/16), or link-local multicast ((224.0.0.0/24). IPv6 is also accepted but not fully supported on all platforms. Also, certain kubernetes components, like kube-proxy, are not IPv6 ready. TODO: This should allow hostname or IP, See #4447."
													type:        "string"
												}
												nodeName: {
													description: "Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node."
													type:        "string"
												}
												targetRef: {
													description: "Reference to object providing the endpoint."
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
													type: "object"
												}
											}
											required: [
												"ip",
											]
											type: "object"
										}
										nullable: true
										type:     "array"
									}
									externalMgrPrometheusPort: {
										description: "ExternalMgrPrometheusPort Prometheus exporter port"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
									rulesNamespace: {
										description: "RulesNamespace is the namespace where the prometheus rules and alerts should be created. If empty, the same namespace as the cluster will be used."
										type:        "string"
									}
								}
								type: "object"
							}
							network: {
								description: "Network related configuration"
								nullable:    true
								properties: {
									dualStack: {
										description: "DualStack determines whether Ceph daemons should listen on both IPv4 and IPv6"
										type:        "boolean"
									}
									hostNetwork: {
										description: "HostNetwork to enable host network"
										type:        "boolean"
									}
									ipFamily: {
										default:     "IPv4"
										description: "IPFamily is the single stack IPv6 or IPv4 protocol"
										enum: [
											"IPv4",
											"IPv6",
										]
										nullable: true
										type:     "string"
									}
									provider: {
										description: "Provider is what provides network connectivity to the cluster e.g. \"host\" or \"multus\""
										nullable:    true
										type:        "string"
									}
									selectors: {
										additionalProperties: type: "string"
										description: "Selectors string values describe what networks will be used to connect the cluster. Meanwhile the keys describe each network respective responsibilities or any metadata storage provider decide."
										nullable:    true
										type:        "object"
									}
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							placement: {
								additionalProperties: {
									description: "Placement is the placement for an object"
									properties: {
										nodeAffinity: {
											description: "NodeAffinity is a group of node affinity scheduling rules"
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
											description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																	namespaces: {
																		description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
															namespaces: {
																description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
											description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																	namespaces: {
																		description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
															namespaces: {
																description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
										tolerations: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
											description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
														description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
														format:      "int32"
														type:        "integer"
													}
													topologyKey: {
														description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
														type:        "string"
													}
													whenUnsatisfiable: {
														description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
								description:                            "The placement-related configuration to pass to kubernetes (affinity, node selector, tolerations)."
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							priorityClassNames: {
								additionalProperties: type: "string"
								description:                            "PriorityClassNames sets priority classes on components"
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							removeOSDsIfOutAndSafeToRemove: {
								description: "Remove the OSD that is out and safe to remove only if this option is true"
								type:        "boolean"
							}
							resources: {
								additionalProperties: {
									description: "ResourceRequirements describes the compute resource requirements."
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
											description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
											description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											type:        "object"
										}
									}
									type: "object"
								}
								description:                            "Resources set resource requests and limits"
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							security: {
								description: "Security represents security settings"
								nullable:    true
								properties: kms: {
									description: "KeyManagementService is the main Key Management option"
									nullable:    true
									properties: {
										connectionDetails: {
											additionalProperties: type: "string"
											description:                            "ConnectionDetails contains the KMS connection details (address, port etc)"
											nullable:                               true
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										tokenSecretName: {
											description: "TokenSecretName is the kubernetes secret containing the KMS token"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "object"
							}
							skipUpgradeChecks: {
								description: "SkipUpgradeChecks defines if an upgrade should be forced even if one of the check fails"
								type:        "boolean"
							}
							storage: {
								description: "A spec for available storage in the cluster and how it should be used"
								nullable:    true
								properties: {
									config: {
										additionalProperties: type: "string"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									deviceFilter: {
										description: "A regular expression to allow more fine-grained selection of devices on nodes across the cluster"
										type:        "string"
									}
									devicePathFilter: {
										description: "A regular expression to allow more fine-grained selection of devices with path names"
										type:        "string"
									}
									devices: {
										description: "List of devices to use as storage devices"
										items: {
											description: "Device represents a disk to use in the cluster"
											properties: {
												config: {
													additionalProperties: type: "string"
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												fullpath: type: "string"
												name: type:     "string"
											}
											type: "object"
										}
										nullable:                               true
										type:                                   "array"
										"x-kubernetes-preserve-unknown-fields": true
									}
									nodes: {
										items: {
											description: "Node is a storage nodes"
											properties: {
												config: {
													additionalProperties: type: "string"
													nullable:                               true
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												deviceFilter: {
													description: "A regular expression to allow more fine-grained selection of devices on nodes across the cluster"
													type:        "string"
												}
												devicePathFilter: {
													description: "A regular expression to allow more fine-grained selection of devices with path names"
													type:        "string"
												}
												devices: {
													description: "List of devices to use as storage devices"
													items: {
														description: "Device represents a disk to use in the cluster"
														properties: {
															config: {
																additionalProperties: type: "string"
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															fullpath: type: "string"
															name: type:     "string"
														}
														type: "object"
													}
													nullable:                               true
													type:                                   "array"
													"x-kubernetes-preserve-unknown-fields": true
												}
												name: type: "string"
												resources: {
													description: "ResourceRequirements describes the compute resource requirements."
													nullable:    true
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
															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
															description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
															type:        "object"
														}
													}
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												useAllDevices: {
													description: "Whether to consume all the storage devices found on a machine"
													type:        "boolean"
												}
												volumeClaimTemplates: {
													description: "PersistentVolumeClaims to use as storage"
													items: {
														description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"
														properties: {
															apiVersion: {
																description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
																type:        "string"
															}
															kind: {
																description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
																type:        "string"
															}
															metadata: {
																description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
																properties: {
																	annotations: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	finalizers: {
																		items: type: "string"
																		type: "array"
																	}
																	labels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	name: type:      "string"
																	namespace: type: "string"
																}
																type: "object"
															}
															spec: {
																description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																properties: {
																	accessModes: {
																		description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																		items: type: "string"
																		type: "array"
																	}
																	dataSource: {
																		description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) * An existing custom resource that implements data population (Alpha) In order to use custom resource types that implement data population, the AnyVolumeDataSource feature gate must be enabled. If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source."
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
																		description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
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
																				description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
																				description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	selector: {
																		description: "A label query over volumes to consider for binding."
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
																		description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																		type:        "string"
																	}
																	volumeMode: {
																		description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
																		type:        "string"
																	}
																	volumeName: {
																		description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
																		type:        "string"
																	}
																}
																type: "object"
															}
															status: {
																description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																properties: {
																	accessModes: {
																		description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																		items: type: "string"
																		type: "array"
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
																		description: "Represents the actual resources of the underlying volume."
																		type:        "object"
																	}
																	conditions: {
																		description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
																		items: {
																			description: "PersistentVolumeClaimCondition contails details about state of pvc"
																			properties: {
																				lastProbeTime: {
																					description: "Last time we probed the condition."
																					format:      "date-time"
																					type:        "string"
																				}
																				lastTransitionTime: {
																					description: "Last time the condition transitioned from one status to another."
																					format:      "date-time"
																					type:        "string"
																				}
																				message: {
																					description: "Human-readable message indicating details about last transition."
																					type:        "string"
																				}
																				reason: {
																					description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																					type:        "string"
																				}
																				status: type: "string"
																				type: {
																					description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																					type:        "string"
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
																		description: "Phase represents the current phase of PersistentVolumeClaim."
																		type:        "string"
																	}
																}
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
										nullable: true
										type:     "array"
									}
									storageClassDeviceSets: {
										items: {
											description: "StorageClassDeviceSet is a storage class device set"
											properties: {
												config: {
													additionalProperties: type: "string"
													description:                            "Provider-specific device configuration"
													nullable:                               true
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												count: {
													description: "Count is the number of devices in this set"
													minimum:     1
													type:        "integer"
												}
												encrypted: {
													description: "Whether to encrypt the deviceSet"
													type:        "boolean"
												}
												name: {
													description: "Name is a unique identifier for the set"
													type:        "string"
												}
												placement: {
													description: "Placement is the placement for an object"
													nullable:    true
													properties: {
														nodeAffinity: {
															description: "NodeAffinity is a group of node affinity scheduling rules"
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
															description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																					namespaces: {
																						description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																			namespaces: {
																				description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
															description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																					namespaces: {
																						description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																			namespaces: {
																				description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														tolerations: {
															description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
															description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
																		description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
																		format:      "int32"
																		type:        "integer"
																	}
																	topologyKey: {
																		description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
																		type:        "string"
																	}
																	whenUnsatisfiable: {
																		description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												portable: {
													description: "Portable represents OSD portability across the hosts"
													type:        "boolean"
												}
												preparePlacement: {
													description: "Placement is the placement for an object"
													nullable:    true
													properties: {
														nodeAffinity: {
															description: "NodeAffinity is a group of node affinity scheduling rules"
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
															description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																					namespaces: {
																						description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																			namespaces: {
																				description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
															description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																					namespaces: {
																						description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																			namespaces: {
																				description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														tolerations: {
															description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
															description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
																		description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
																		format:      "int32"
																		type:        "integer"
																	}
																	topologyKey: {
																		description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
																		type:        "string"
																	}
																	whenUnsatisfiable: {
																		description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												resources: {
													description: "ResourceRequirements describes the compute resource requirements."
													nullable:    true
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
															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
															description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
															type:        "object"
														}
													}
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												schedulerName: {
													description: "Scheduler name for OSD pod placement"
													type:        "string"
												}
												tuneDeviceClass: {
													description: "TuneSlowDeviceClass Tune the OSD when running on a slow Device Class"
													type:        "boolean"
												}
												tuneFastDeviceClass: {
													description: "TuneFastDeviceClass Tune the OSD when running on a fast Device Class"
													type:        "boolean"
												}
												volumeClaimTemplates: {
													description: "VolumeClaimTemplates is a list of PVC templates for the underlying storage devices"
													items: {
														description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"
														properties: {
															apiVersion: {
																description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
																type:        "string"
															}
															kind: {
																description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
																type:        "string"
															}
															metadata: {
																description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
																properties: {
																	annotations: {
																		additionalProperties: type: "string"
																		type:                                   "object"
																		"x-kubernetes-preserve-unknown-fields": true
																	}
																	finalizers: {
																		items: type: "string"
																		type: "array"
																	}
																	labels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	name: type:      "string"
																	namespace: type: "string"
																}
																type: "object"
															}
															spec: {
																description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																properties: {
																	accessModes: {
																		description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																		items: type: "string"
																		type: "array"
																	}
																	dataSource: {
																		description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) * An existing custom resource that implements data population (Alpha) In order to use custom resource types that implement data population, the AnyVolumeDataSource feature gate must be enabled. If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source."
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
																		description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
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
																				description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
																				description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																				type:        "object"
																			}
																		}
																		type: "object"
																	}
																	selector: {
																		description: "A label query over volumes to consider for binding."
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
																		description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
																		type:        "string"
																	}
																	volumeMode: {
																		description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
																		type:        "string"
																	}
																	volumeName: {
																		description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
																		type:        "string"
																	}
																}
																type: "object"
															}
															status: {
																description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
																properties: {
																	accessModes: {
																		description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
																		items: type: "string"
																		type: "array"
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
																		description: "Represents the actual resources of the underlying volume."
																		type:        "object"
																	}
																	conditions: {
																		description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
																		items: {
																			description: "PersistentVolumeClaimCondition contails details about state of pvc"
																			properties: {
																				lastProbeTime: {
																					description: "Last time we probed the condition."
																					format:      "date-time"
																					type:        "string"
																				}
																				lastTransitionTime: {
																					description: "Last time the condition transitioned from one status to another."
																					format:      "date-time"
																					type:        "string"
																				}
																				message: {
																					description: "Human-readable message indicating details about last transition."
																					type:        "string"
																				}
																				reason: {
																					description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																					type:        "string"
																				}
																				status: type: "string"
																				type: {
																					description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																					type:        "string"
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
																		description: "Phase represents the current phase of PersistentVolumeClaim."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: [
												"count",
												"name",
												"volumeClaimTemplates",
											]
											type: "object"
										}
										nullable: true
										type:     "array"
									}
									useAllDevices: {
										description: "Whether to consume all the storage devices found on a machine"
										type:        "boolean"
									}
									useAllNodes: type: "boolean"
									volumeClaimTemplates: {
										description: "PersistentVolumeClaims to use as storage"
										items: {
											description: "PersistentVolumeClaim is a user's request for and claim to a persistent volume"
											properties: {
												apiVersion: {
													description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
													type:        "string"
												}
												kind: {
													description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
													type:        "string"
												}
												metadata: {
													description: "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata"
													properties: {
														annotations: {
															additionalProperties: type: "string"
															type: "object"
														}
														finalizers: {
															items: type: "string"
															type: "array"
														}
														labels: {
															additionalProperties: type: "string"
															type: "object"
														}
														name: type:      "string"
														namespace: type: "string"
													}
													type: "object"
												}
												spec: {
													description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													properties: {
														accessModes: {
															description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
															items: type: "string"
															type: "array"
														}
														dataSource: {
															description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) * An existing custom resource that implements data population (Alpha) In order to use custom resource types that implement data population, the AnyVolumeDataSource feature gate must be enabled. If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source."
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
															description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
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
																	description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
																	description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																	type:        "object"
																}
															}
															type: "object"
														}
														selector: {
															description: "A label query over volumes to consider for binding."
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
															description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
															type:        "string"
														}
														volumeMode: {
															description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
															type:        "string"
														}
														volumeName: {
															description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
															type:        "string"
														}
													}
													type: "object"
												}
												status: {
													description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													properties: {
														accessModes: {
															description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
															items: type: "string"
															type: "array"
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
															description: "Represents the actual resources of the underlying volume."
															type:        "object"
														}
														conditions: {
															description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
															items: {
																description: "PersistentVolumeClaimCondition contails details about state of pvc"
																properties: {
																	lastProbeTime: {
																		description: "Last time we probed the condition."
																		format:      "date-time"
																		type:        "string"
																	}
																	lastTransitionTime: {
																		description: "Last time the condition transitioned from one status to another."
																		format:      "date-time"
																		type:        "string"
																	}
																	message: {
																		description: "Human-readable message indicating details about last transition."
																		type:        "string"
																	}
																	reason: {
																		description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																		type:        "string"
																	}
																	status: type: "string"
																	type: {
																		description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																		type:        "string"
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
															description: "Phase represents the current phase of PersistentVolumeClaim."
															type:        "string"
														}
													}
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
							waitTimeoutForHealthyOSDInMinutes: {
								description: "WaitTimeoutForHealthyOSDInMinutes defines the time the operator would wait before an OSD can be stopped for upgrade or restart. If the timeout exceeds and OSD is not ok to stop, then the operator would skip upgrade for the current OSD and proceed with the next one if `continueUpgradeAfterChecksEvenIfNotHealthy` is `false`. If `continueUpgradeAfterChecksEvenIfNotHealthy` is `true`, then operator would continue with the upgrade of an OSD even if its not ok to stop after the timeout. This timeout won't be applied if `skipUpgradeChecks` is `true`. The default wait timeout is 10 minutes."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
					status: {
						description: "ClusterStatus represents the status of a Ceph cluster"
						nullable:    true
						properties: {
							ceph: {
								description: "CephStatus is the details health of a Ceph Cluster"
								properties: {
									capacity: {
										description: "Capacity is the capacity information of a Ceph Cluster"
										properties: {
											bytesAvailable: {
												format: "int64"
												type:   "integer"
											}
											bytesTotal: {
												format: "int64"
												type:   "integer"
											}
											bytesUsed: {
												format: "int64"
												type:   "integer"
											}
											lastUpdated: type: "string"
										}
										type: "object"
									}
									details: {
										additionalProperties: {
											description: "CephHealthMessage represents the health message of a Ceph Cluster"
											properties: {
												message: type:  "string"
												severity: type: "string"
											}
											required: [
												"message",
												"severity",
											]
											type: "object"
										}
										type: "object"
									}
									health: type:         "string"
									lastChanged: type:    "string"
									lastChecked: type:    "string"
									previousHealth: type: "string"
									versions: {
										description: "CephDaemonsVersions show the current ceph version for different ceph daemons"
										properties: {
											"cephfs-mirror": {
												additionalProperties: type: "integer"
												description: "CephFSMirror shows CephFSMirror Ceph version"
												type:        "object"
											}
											mds: {
												additionalProperties: type: "integer"
												description: "Mds shows Mds Ceph version"
												type:        "object"
											}
											mgr: {
												additionalProperties: type: "integer"
												description: "Mgr shows Mgr Ceph version"
												type:        "object"
											}
											mon: {
												additionalProperties: type: "integer"
												description: "Mon shows Mon Ceph version"
												type:        "object"
											}
											osd: {
												additionalProperties: type: "integer"
												description: "Osd shows Osd Ceph version"
												type:        "object"
											}
											overall: {
												additionalProperties: type: "integer"
												description: "Overall shows overall Ceph version"
												type:        "object"
											}
											"rbd-mirror": {
												additionalProperties: type: "integer"
												description: "RbdMirror shows RbdMirror Ceph version"
												type:        "object"
											}
											rgw: {
												additionalProperties: type: "integer"
												description: "Rgw shows Rgw Ceph version"
												type:        "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							conditions: {
								items: {
									description: "Condition represents"
									properties: {
										lastHeartbeatTime: {
											format: "date-time"
											type:   "string"
										}
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										reason: {
											description: "ClusterReasonType is cluster reason"
											type:        "string"
										}
										status: type: "string"
										type: {
											description: "ConditionType represent a resource's status"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							message: type: "string"
							phase: {
								description: "ConditionType represent a resource's status"
								type:        "string"
							}
							state: {
								description: "ClusterState represents the state of a Ceph Cluster"
								type:        "string"
							}
							storage: {
								description: "CephStorage represents flavors of Ceph Cluster Storage"
								properties: deviceClasses: {
									items: {
										description: "DeviceClasses represents device classes of a Ceph Cluster"
										properties: name: type: "string"
										type: "object"
									}
									type: "array"
								}
								type: "object"
							}
							version: {
								description: "ClusterVersion represents the version of a Ceph Cluster"
								properties: {
									image: type:   "string"
									version: type: "string"
								}
								type: "object"
							}
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephfilesystemmirrors.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephFilesystemMirror"
			listKind: "CephFilesystemMirrorList"
			plural:   "cephfilesystemmirrors"
			singular: "cephfilesystemmirror"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephFilesystemMirror is the Ceph Filesystem Mirror object definition"
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
						description: "FilesystemMirroringSpec is the filesystem mirorring specification"
						properties: {
							annotations: {
								additionalProperties: type: "string"
								description: "The annotations-related configuration to add/set on each Pod related object."
								nullable:    true
								type:        "object"
							}
							labels: {
								additionalProperties: type: "string"
								description: "The labels-related configuration to add/set on each Pod related object."
								nullable:    true
								type:        "object"
							}
							placement: {
								description: "The affinity to place the rgw pods (default is to place on any available node)"
								nullable:    true
								properties: {
									nodeAffinity: {
										description: "NodeAffinity is a group of node affinity scheduling rules"
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
										description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
										description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
									tolerations: {
										description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
										description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
													description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
													format:      "int32"
													type:        "integer"
												}
												topologyKey: {
													description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
													type:        "string"
												}
												whenUnsatisfiable: {
													description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
							priorityClassName: {
								description: "PriorityClassName sets priority class on the cephfs-mirror pods"
								type:        "string"
							}
							resources: {
								description: "The resource requirements for the cephfs-mirror pods"
								nullable:    true
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
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type: "object"
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephfilesystems.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephFilesystem"
			listKind: "CephFilesystemList"
			plural:   "cephfilesystems"
			singular: "cephfilesystem"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "Number of desired active MDS daemons"
				jsonPath:    ".spec.metadataServer.activeCount"
				name:        "ActiveMDS"
				type:        "string"
			}, {
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
				description: "CephFilesystem represents a Ceph Filesystem"
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
						description: "FilesystemSpec represents the spec of a file system"
						properties: {
							dataPools: {
								description: "The data pool settings"
								items: {
									description: "PoolSpec represents the spec of ceph pool"
									properties: {
										compressionMode: {
											default:     "none"
											description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
											enum: [
												"none",
												"passive",
												"aggressive",
												"force",
												"",
											]
											nullable: true
											type:     "string"
										}
										crushRoot: {
											description: "The root of the crush hierarchy utilized by the pool"
											nullable:    true
											type:        "string"
										}
										deviceClass: {
											description: "The device class the OSD should set to for use in the pool"
											nullable:    true
											type:        "string"
										}
										enableRBDStats: {
											description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
											type:        "boolean"
										}
										erasureCoded: {
											description: "The erasure code settings"
											properties: {
												algorithm: {
													description: "The algorithm for erasure coding"
													type:        "string"
												}
												codingChunks: {
													description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
													maximum:     9
													minimum:     0
													type:        "integer"
												}
												dataChunks: {
													description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
													maximum:     9
													minimum:     0
													type:        "integer"
												}
											}
											required: [
												"codingChunks",
												"dataChunks",
											]
											type: "object"
										}
										failureDomain: {
											description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
											type:        "string"
										}
										mirroring: {
											description: "The mirroring settings"
											properties: {
												enabled: {
													description: "Enabled whether this pool is mirrored or not"
													type:        "boolean"
												}
												mode: {
													description: "Mode is the mirroring mode: either pool or image"
													type:        "string"
												}
												snapshotSchedules: {
													description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
													items: {
														description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
														properties: {
															interval: {
																description: "Interval represent the periodicity of the snapshot."
																type:        "string"
															}
															startTime: {
																description: "StartTime indicates when to start the snapshot"
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
										parameters: {
											additionalProperties: type: "string"
											description:                            "Parameters is a list of properties to enable on a given pool"
											nullable:                               true
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										quotas: {
											description: "The quota settings"
											nullable:    true
											properties: {
												maxBytes: {
													description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
													format:      "int64"
													type:        "integer"
												}
												maxObjects: {
													description: "MaxObjects represents the quota in objects"
													format:      "int64"
													type:        "integer"
												}
												maxSize: {
													description: "MaxSize represents the quota in bytes as a string"
													pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
													type:        "string"
												}
											}
											type: "object"
										}
										replicated: {
											description: "The replication settings"
											properties: {
												replicasPerFailureDomain: {
													description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
													minimum:     1
													type:        "integer"
												}
												requireSafeReplicaSize: {
													description: "RequireSafeReplicaSize if false allows you to set replica 1"
													type:        "boolean"
												}
												size: {
													description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
													minimum:     0
													type:        "integer"
												}
												subFailureDomain: {
													description: "SubFailureDomain the name of the sub-failure domain"
													type:        "string"
												}
												targetSizeRatio: {
													description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
													type:        "number"
												}
											}
											required: [
												"size",
											]
											type: "object"
										}
										statusCheck: {
											description: "The mirroring statusCheck"
											properties: mirror: {
												description: "HealthCheckSpec represents the health check of an object store bucket"
												nullable:    true
												properties: {
													disabled: type: "boolean"
													interval: {
														description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
														type:        "string"
													}
													timeout: type: "string"
												}
												type: "object"
											}
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
									}
									type: "object"
								}
								nullable: true
								type:     "array"
							}
							metadataPool: {
								description: "The metadata pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										default:     "none"
										description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
										enum: [
											"none",
											"passive",
											"aggressive",
											"force",
											"",
										]
										nullable: true
										type:     "string"
									}
									crushRoot: {
										description: "The root of the crush hierarchy utilized by the pool"
										nullable:    true
										type:        "string"
									}
									deviceClass: {
										description: "The device class the OSD should set to for use in the pool"
										nullable:    true
										type:        "string"
									}
									enableRBDStats: {
										description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
										type:        "boolean"
									}
									erasureCoded: {
										description: "The erasure code settings"
										properties: {
											algorithm: {
												description: "The algorithm for erasure coding"
												type:        "string"
											}
											codingChunks: {
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
										}
										required: [
											"codingChunks",
											"dataChunks",
										]
										type: "object"
									}
									failureDomain: {
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
										type:        "string"
									}
									mirroring: {
										description: "The mirroring settings"
										properties: {
											enabled: {
												description: "Enabled whether this pool is mirrored or not"
												type:        "boolean"
											}
											mode: {
												description: "Mode is the mirroring mode: either pool or image"
												type:        "string"
											}
											snapshotSchedules: {
												description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
												items: {
													description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
													properties: {
														interval: {
															description: "Interval represent the periodicity of the snapshot."
															type:        "string"
														}
														startTime: {
															description: "StartTime indicates when to start the snapshot"
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
									parameters: {
										additionalProperties: type: "string"
										description:                            "Parameters is a list of properties to enable on a given pool"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									quotas: {
										description: "The quota settings"
										nullable:    true
										properties: {
											maxBytes: {
												description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
												format:      "int64"
												type:        "integer"
											}
											maxObjects: {
												description: "MaxObjects represents the quota in objects"
												format:      "int64"
												type:        "integer"
											}
											maxSize: {
												description: "MaxSize represents the quota in bytes as a string"
												pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
												type:        "string"
											}
										}
										type: "object"
									}
									replicated: {
										description: "The replication settings"
										properties: {
											replicasPerFailureDomain: {
												description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
												minimum:     1
												type:        "integer"
											}
											requireSafeReplicaSize: {
												description: "RequireSafeReplicaSize if false allows you to set replica 1"
												type:        "boolean"
											}
											size: {
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
												type:        "number"
											}
										}
										required: [
											"size",
										]
										type: "object"
									}
									statusCheck: {
										description: "The mirroring statusCheck"
										properties: mirror: {
											description: "HealthCheckSpec represents the health check of an object store bucket"
											nullable:    true
											properties: {
												disabled: type: "boolean"
												interval: {
													description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
													type:        "string"
												}
												timeout: type: "string"
											}
											type: "object"
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								type: "object"
							}
							metadataServer: {
								description: "The mds pod info"
								properties: {
									activeCount: {
										description: "The number of metadata servers that are active. The remaining servers in the cluster will be in standby mode."
										format:      "int32"
										maximum:     10
										minimum:     1
										type:        "integer"
									}
									activeStandby: {
										description: "Whether each active MDS instance will have an active standby with a warm metadata cache for faster failover. If false, standbys will still be available, but will not have a warm metadata cache."
										type:        "boolean"
									}
									annotations: {
										additionalProperties: type: "string"
										description:                            "The annotations-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									labels: {
										additionalProperties: type: "string"
										description:                            "The labels-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									placement: {
										description: "The affinity to place the mds pods (default is to place on all available node) with a daemonset"
										nullable:    true
										properties: {
											nodeAffinity: {
												description: "NodeAffinity is a group of node affinity scheduling rules"
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
															description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
															format:      "int32"
															type:        "integer"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									priorityClassName: {
										description: "PriorityClassName sets priority classes on components"
										type:        "string"
									}
									resources: {
										description: "The resource requirements for the rgw pods"
										nullable:    true
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
												description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
												type:        "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: [
									"activeCount",
								]
								type: "object"
							}
							mirroring: {
								description: "The mirroring settings"
								nullable:    true
								properties: enabled: {
									description: "Enabled whether this filesystem is mirrored or not"
									type:        "boolean"
								}
								type: "object"
							}
							preserveFilesystemOnDelete: {
								description: "Preserve the fs in the cluster on CephFilesystem CR deletion. Setting this to true automatically implies PreservePoolsOnDelete is true."
								type:        "boolean"
							}
							preservePoolsOnDelete: {
								description: "Preserve pools on filesystem deletion"
								type:        "boolean"
							}
						}
						required: [
							"dataPools",
							"metadataPool",
							"metadataServer",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephnfses.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephNFS"
			listKind: "CephNFSList"
			plural:   "cephnfses"
			shortNames: [
				"nfs",
			]
			singular: "cephnfs"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephNFS represents a Ceph NFS"
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
						description: "NFSGaneshaSpec represents the spec of an nfs ganesha server"
						properties: {
							rados: {
								description: "RADOS is the Ganesha RADOS specification"
								properties: {
									namespace: {
										description: "Namespace is the RADOS namespace where NFS client recovery data is stored."
										type:        "string"
									}
									pool: {
										description: "Pool is the RADOS pool where NFS client recovery data is stored."
										type:        "string"
									}
								}
								required: [
									"namespace",
									"pool",
								]
								type: "object"
							}
							server: {
								description: "Server is the Ganesha Server specification"
								properties: {
									active: {
										description: "The number of active Ganesha servers"
										type:        "integer"
									}
									annotations: {
										additionalProperties: type: "string"
										description:                            "The annotations-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									labels: {
										additionalProperties: type: "string"
										description:                            "The labels-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									logLevel: {
										description: "LogLevel set logging level"
										type:        "string"
									}
									placement: {
										description: "The affinity to place the ganesha pods"
										nullable:    true
										properties: {
											nodeAffinity: {
												description: "NodeAffinity is a group of node affinity scheduling rules"
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
															description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
															format:      "int32"
															type:        "integer"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									priorityClassName: {
										description: "PriorityClassName sets the priority class on the pods"
										type:        "string"
									}
									resources: {
										description: "Resources set resource requests and limits"
										nullable:    true
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
												description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
												type:        "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: [
									"active",
								]
								type: "object"
							}
						}
						required: [
							"rados",
							"server",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephobjectrealms.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectRealm"
			listKind: "CephObjectRealmList"
			plural:   "cephobjectrealms"
			singular: "cephobjectrealm"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectRealm represents a Ceph Object Store Gateway Realm"
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
						description: "ObjectRealmSpec represent the spec of an ObjectRealm"
						nullable:    true
						properties: pull: {
							description: "PullSpec represents the pulling specification of a Ceph Object Storage Gateway Realm"
							properties: endpoint: type: "string"
							required: [
								"endpoint",
							]
							type: "object"
						}
						required: [
							"pull",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephobjectstores.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectStore"
			listKind: "CephObjectStoreList"
			plural:   "cephobjectstores"
			singular: "cephobjectstore"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectStore represents a Ceph Object Store Gateway"
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
						description: "ObjectStoreSpec represent the spec of a pool"
						properties: {
							dataPool: {
								description: "The data pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										default:     "none"
										description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
										enum: [
											"none",
											"passive",
											"aggressive",
											"force",
											"",
										]
										nullable: true
										type:     "string"
									}
									crushRoot: {
										description: "The root of the crush hierarchy utilized by the pool"
										nullable:    true
										type:        "string"
									}
									deviceClass: {
										description: "The device class the OSD should set to for use in the pool"
										nullable:    true
										type:        "string"
									}
									enableRBDStats: {
										description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
										type:        "boolean"
									}
									erasureCoded: {
										description: "The erasure code settings"
										properties: {
											algorithm: {
												description: "The algorithm for erasure coding"
												type:        "string"
											}
											codingChunks: {
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
										}
										required: [
											"codingChunks",
											"dataChunks",
										]
										type: "object"
									}
									failureDomain: {
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
										type:        "string"
									}
									mirroring: {
										description: "The mirroring settings"
										properties: {
											enabled: {
												description: "Enabled whether this pool is mirrored or not"
												type:        "boolean"
											}
											mode: {
												description: "Mode is the mirroring mode: either pool or image"
												type:        "string"
											}
											snapshotSchedules: {
												description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
												items: {
													description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
													properties: {
														interval: {
															description: "Interval represent the periodicity of the snapshot."
															type:        "string"
														}
														startTime: {
															description: "StartTime indicates when to start the snapshot"
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
									parameters: {
										additionalProperties: type: "string"
										description:                            "Parameters is a list of properties to enable on a given pool"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									quotas: {
										description: "The quota settings"
										nullable:    true
										properties: {
											maxBytes: {
												description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
												format:      "int64"
												type:        "integer"
											}
											maxObjects: {
												description: "MaxObjects represents the quota in objects"
												format:      "int64"
												type:        "integer"
											}
											maxSize: {
												description: "MaxSize represents the quota in bytes as a string"
												pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
												type:        "string"
											}
										}
										type: "object"
									}
									replicated: {
										description: "The replication settings"
										properties: {
											replicasPerFailureDomain: {
												description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
												minimum:     1
												type:        "integer"
											}
											requireSafeReplicaSize: {
												description: "RequireSafeReplicaSize if false allows you to set replica 1"
												type:        "boolean"
											}
											size: {
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
												type:        "number"
											}
										}
										required: [
											"size",
										]
										type: "object"
									}
									statusCheck: {
										description: "The mirroring statusCheck"
										properties: mirror: {
											description: "HealthCheckSpec represents the health check of an object store bucket"
											nullable:    true
											properties: {
												disabled: type: "boolean"
												interval: {
													description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
													type:        "string"
												}
												timeout: type: "string"
											}
											type: "object"
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								type: "object"
							}
							gateway: {
								description: "The rgw pod info"
								nullable:    true
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description:                            "The annotations-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									externalRgwEndpoints: {
										description: "ExternalRgwEndpoints points to external rgw endpoint(s)"
										items: {
											description: "EndpointAddress is a tuple that describes single IP address."
											properties: {
												hostname: {
													description: "The Hostname of this endpoint"
													type:        "string"
												}
												ip: {
													description: "The IP of this endpoint. May not be loopback (127.0.0.0/8), link-local (169.254.0.0/16), or link-local multicast ((224.0.0.0/24). IPv6 is also accepted but not fully supported on all platforms. Also, certain kubernetes components, like kube-proxy, are not IPv6 ready. TODO: This should allow hostname or IP, See #4447."
													type:        "string"
												}
												nodeName: {
													description: "Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node."
													type:        "string"
												}
												targetRef: {
													description: "Reference to object providing the endpoint."
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
													type: "object"
												}
											}
											required: [
												"ip",
											]
											type: "object"
										}
										nullable: true
										type:     "array"
									}
									instances: {
										description: "The number of pods in the rgw replicaset."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									labels: {
										additionalProperties: type: "string"
										description:                            "The labels-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									placement: {
										description: "The affinity to place the rgw pods (default is to place on any available node)"
										nullable:    true
										properties: {
											nodeAffinity: {
												description: "NodeAffinity is a group of node affinity scheduling rules"
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																		namespaces: {
																			description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
												description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
															description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
															format:      "int32"
															type:        "integer"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									port: {
										description: "The port the rgw service will be listening on (http)"
										format:      "int32"
										type:        "integer"
									}
									priorityClassName: {
										description: "PriorityClassName sets priority classes on the rgw pods"
										type:        "string"
									}
									resources: {
										description: "The resource requirements for the rgw pods"
										nullable:    true
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
												description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
												type:        "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									securePort: {
										description: "The port the rgw service will be listening on (https)"
										format:      "int32"
										maximum:     65535
										minimum:     0
										nullable:    true
										type:        "integer"
									}
									service: {
										description: "The configuration related to add/set on each rgw service."
										nullable:    true
										properties: annotations: {
											additionalProperties: type: "string"
											description: "The annotations-related configuration to add/set on each rgw service. nullable optional"
											type:        "object"
										}
										type: "object"
									}
									sslCertificateRef: {
										description: "The name of the secret that stores the ssl certificate for secure rgw connections"
										nullable:    true
										type:        "string"
									}
								}
								required: [
									"instances",
								]
								type: "object"
							}
							healthCheck: {
								description: "The rgw Bucket healthchecks and liveness probe"
								nullable:    true
								properties: {
									bucket: {
										description: "HealthCheckSpec represents the health check of an object store bucket"
										properties: {
											disabled: type: "boolean"
											interval: {
												description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
												type:        "string"
											}
											timeout: type: "string"
										}
										type: "object"
									}
									livenessProbe: {
										description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic."
												properties: {
													exec: {
														description: "One and only one of the following should be specified. Exec specifies the action to take."
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
														description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
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
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
														format:      "int32"
														type:        "integer"
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
							metadataPool: {
								description: "The metadata pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										default:     "none"
										description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
										enum: [
											"none",
											"passive",
											"aggressive",
											"force",
											"",
										]
										nullable: true
										type:     "string"
									}
									crushRoot: {
										description: "The root of the crush hierarchy utilized by the pool"
										nullable:    true
										type:        "string"
									}
									deviceClass: {
										description: "The device class the OSD should set to for use in the pool"
										nullable:    true
										type:        "string"
									}
									enableRBDStats: {
										description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
										type:        "boolean"
									}
									erasureCoded: {
										description: "The erasure code settings"
										properties: {
											algorithm: {
												description: "The algorithm for erasure coding"
												type:        "string"
											}
											codingChunks: {
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
										}
										required: [
											"codingChunks",
											"dataChunks",
										]
										type: "object"
									}
									failureDomain: {
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
										type:        "string"
									}
									mirroring: {
										description: "The mirroring settings"
										properties: {
											enabled: {
												description: "Enabled whether this pool is mirrored or not"
												type:        "boolean"
											}
											mode: {
												description: "Mode is the mirroring mode: either pool or image"
												type:        "string"
											}
											snapshotSchedules: {
												description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
												items: {
													description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
													properties: {
														interval: {
															description: "Interval represent the periodicity of the snapshot."
															type:        "string"
														}
														startTime: {
															description: "StartTime indicates when to start the snapshot"
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
									parameters: {
										additionalProperties: type: "string"
										description:                            "Parameters is a list of properties to enable on a given pool"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									quotas: {
										description: "The quota settings"
										nullable:    true
										properties: {
											maxBytes: {
												description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
												format:      "int64"
												type:        "integer"
											}
											maxObjects: {
												description: "MaxObjects represents the quota in objects"
												format:      "int64"
												type:        "integer"
											}
											maxSize: {
												description: "MaxSize represents the quota in bytes as a string"
												pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
												type:        "string"
											}
										}
										type: "object"
									}
									replicated: {
										description: "The replication settings"
										properties: {
											replicasPerFailureDomain: {
												description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
												minimum:     1
												type:        "integer"
											}
											requireSafeReplicaSize: {
												description: "RequireSafeReplicaSize if false allows you to set replica 1"
												type:        "boolean"
											}
											size: {
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
												type:        "number"
											}
										}
										required: [
											"size",
										]
										type: "object"
									}
									statusCheck: {
										description: "The mirroring statusCheck"
										properties: mirror: {
											description: "HealthCheckSpec represents the health check of an object store bucket"
											nullable:    true
											properties: {
												disabled: type: "boolean"
												interval: {
													description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
													type:        "string"
												}
												timeout: type: "string"
											}
											type: "object"
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								type: "object"
							}
							preservePoolsOnDelete: {
								description: "Preserve pools on object store deletion"
								type:        "boolean"
							}
							security: {
								description: "Security represents security settings"
								nullable:    true
								properties: kms: {
									description: "KeyManagementService is the main Key Management option"
									nullable:    true
									properties: {
										connectionDetails: {
											additionalProperties: type: "string"
											description:                            "ConnectionDetails contains the KMS connection details (address, port etc)"
											nullable:                               true
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
										tokenSecretName: {
											description: "TokenSecretName is the kubernetes secret containing the KMS token"
											type:        "string"
										}
									}
									type: "object"
								}
								type: "object"
							}
							zone: {
								description: "The multisite info"
								nullable:    true
								properties: name: {
									description: "RGW Zone the Object Store is in"
									type:        "string"
								}
								required: [
									"name",
								]
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "ObjectStoreStatus represents the status of a Ceph Object Store resource"
						properties: {
							bucketStatus: {
								description: "BucketStatus represents the status of a bucket"
								properties: {
									details: type: "string"
									health: {
										description: "ConditionType represent a resource's status"
										type:        "string"
									}
									lastChanged: type: "string"
									lastChecked: type: "string"
								}
								type: "object"
							}
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
							}
							message: type: "string"
							phase: {
								description: "ConditionType represent a resource's status"
								type:        "string"
							}
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephobjectstoreusers.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectStoreUser"
			listKind: "CephObjectStoreUserList"
			plural:   "cephobjectstoreusers"
			shortNames: [
				"rcou",
				"objectuser",
			]
			singular: "cephobjectstoreuser"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectStoreUser represents a Ceph Object Store Gateway User"
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
						description: "ObjectStoreUserSpec represent the spec of an Objectstoreuser"
						properties: {
							displayName: {
								description: "The display name for the ceph users"
								type:        "string"
							}
							store: {
								description: "The store the user will be created in"
								type:        "string"
							}
						}
						type: "object"
					}
					status: {
						description: "ObjectStoreUserStatus represents the status Ceph Object Store Gateway User"
						properties: {
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
							}
							phase: type: "string"
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephobjectzonegroups.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectZoneGroup"
			listKind: "CephObjectZoneGroupList"
			plural:   "cephobjectzonegroups"
			singular: "cephobjectzonegroup"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectZoneGroup represents a Ceph Object Store Gateway Zone Group"
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
						description: "ObjectZoneGroupSpec represent the spec of an ObjectZoneGroup"
						properties: realm: {
							description: "The display name for the ceph users"
							type:        "string"
						}
						required: [
							"realm",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephobjectzones.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectZone"
			listKind: "CephObjectZoneList"
			plural:   "cephobjectzones"
			singular: "cephobjectzone"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectZone represents a Ceph Object Store Gateway Zone"
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
						description: "ObjectZoneSpec represent the spec of an ObjectZone"
						properties: {
							dataPool: {
								description: "The data pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										default:     "none"
										description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
										enum: [
											"none",
											"passive",
											"aggressive",
											"force",
											"",
										]
										nullable: true
										type:     "string"
									}
									crushRoot: {
										description: "The root of the crush hierarchy utilized by the pool"
										nullable:    true
										type:        "string"
									}
									deviceClass: {
										description: "The device class the OSD should set to for use in the pool"
										nullable:    true
										type:        "string"
									}
									enableRBDStats: {
										description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
										type:        "boolean"
									}
									erasureCoded: {
										description: "The erasure code settings"
										properties: {
											algorithm: {
												description: "The algorithm for erasure coding"
												type:        "string"
											}
											codingChunks: {
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
										}
										required: [
											"codingChunks",
											"dataChunks",
										]
										type: "object"
									}
									failureDomain: {
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
										type:        "string"
									}
									mirroring: {
										description: "The mirroring settings"
										properties: {
											enabled: {
												description: "Enabled whether this pool is mirrored or not"
												type:        "boolean"
											}
											mode: {
												description: "Mode is the mirroring mode: either pool or image"
												type:        "string"
											}
											snapshotSchedules: {
												description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
												items: {
													description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
													properties: {
														interval: {
															description: "Interval represent the periodicity of the snapshot."
															type:        "string"
														}
														startTime: {
															description: "StartTime indicates when to start the snapshot"
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
									parameters: {
										additionalProperties: type: "string"
										description:                            "Parameters is a list of properties to enable on a given pool"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									quotas: {
										description: "The quota settings"
										nullable:    true
										properties: {
											maxBytes: {
												description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
												format:      "int64"
												type:        "integer"
											}
											maxObjects: {
												description: "MaxObjects represents the quota in objects"
												format:      "int64"
												type:        "integer"
											}
											maxSize: {
												description: "MaxSize represents the quota in bytes as a string"
												pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
												type:        "string"
											}
										}
										type: "object"
									}
									replicated: {
										description: "The replication settings"
										properties: {
											replicasPerFailureDomain: {
												description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
												minimum:     1
												type:        "integer"
											}
											requireSafeReplicaSize: {
												description: "RequireSafeReplicaSize if false allows you to set replica 1"
												type:        "boolean"
											}
											size: {
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
												type:        "number"
											}
										}
										required: [
											"size",
										]
										type: "object"
									}
									statusCheck: {
										description: "The mirroring statusCheck"
										properties: mirror: {
											description: "HealthCheckSpec represents the health check of an object store bucket"
											nullable:    true
											properties: {
												disabled: type: "boolean"
												interval: {
													description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
													type:        "string"
												}
												timeout: type: "string"
											}
											type: "object"
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								type: "object"
							}
							metadataPool: {
								description: "The metadata pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										default:     "none"
										description: "The inline compression mode in Bluestore OSD to set to (options are: none, passive, aggressive, force)"
										enum: [
											"none",
											"passive",
											"aggressive",
											"force",
											"",
										]
										nullable: true
										type:     "string"
									}
									crushRoot: {
										description: "The root of the crush hierarchy utilized by the pool"
										nullable:    true
										type:        "string"
									}
									deviceClass: {
										description: "The device class the OSD should set to for use in the pool"
										nullable:    true
										type:        "string"
									}
									enableRBDStats: {
										description: "EnableRBDStats is used to enable gathering of statistics for all RBD images in the pool"
										type:        "boolean"
									}
									erasureCoded: {
										description: "The erasure code settings"
										properties: {
											algorithm: {
												description: "The algorithm for erasure coding"
												type:        "string"
											}
											codingChunks: {
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool type)"
												maximum:     9
												minimum:     0
												type:        "integer"
											}
										}
										required: [
											"codingChunks",
											"dataChunks",
										]
										type: "object"
									}
									failureDomain: {
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush map"
										type:        "string"
									}
									mirroring: {
										description: "The mirroring settings"
										properties: {
											enabled: {
												description: "Enabled whether this pool is mirrored or not"
												type:        "boolean"
											}
											mode: {
												description: "Mode is the mirroring mode: either pool or image"
												type:        "string"
											}
											snapshotSchedules: {
												description: "SnapshotSchedules is the scheduling of snapshot for mirrored images/pools"
												items: {
													description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
													properties: {
														interval: {
															description: "Interval represent the periodicity of the snapshot."
															type:        "string"
														}
														startTime: {
															description: "StartTime indicates when to start the snapshot"
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
									parameters: {
										additionalProperties: type: "string"
										description:                            "Parameters is a list of properties to enable on a given pool"
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									quotas: {
										description: "The quota settings"
										nullable:    true
										properties: {
											maxBytes: {
												description: "MaxBytes represents the quota in bytes Deprecated in favor of MaxSize"
												format:      "int64"
												type:        "integer"
											}
											maxObjects: {
												description: "MaxObjects represents the quota in objects"
												format:      "int64"
												type:        "integer"
											}
											maxSize: {
												description: "MaxSize represents the quota in bytes as a string"
												pattern:     "^[0-9]+[\\.]?[0-9]*([KMGTPE]i|[kMGTPE])?$"
												type:        "string"
											}
										}
										type: "object"
									}
									replicated: {
										description: "The replication settings"
										properties: {
											replicasPerFailureDomain: {
												description: "ReplicasPerFailureDomain the number of replica in the specified failure domain"
												minimum:     1
												type:        "integer"
											}
											requireSafeReplicaSize: {
												description: "RequireSafeReplicaSize if false allows you to set replica 1"
												type:        "boolean"
											}
											size: {
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (required for replicated pool type)"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capacity"
												type:        "number"
											}
										}
										required: [
											"size",
										]
										type: "object"
									}
									statusCheck: {
										description: "The mirroring statusCheck"
										properties: mirror: {
											description: "HealthCheckSpec represents the health check of an object store bucket"
											nullable:    true
											properties: {
												disabled: type: "boolean"
												interval: {
													description: "Interval is the internal in second or minute for the health check to run like 60s for 60 seconds"
													type:        "string"
												}
												timeout: type: "string"
											}
											type: "object"
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								type: "object"
							}
							zoneGroup: {
								description: "The display name for the ceph users"
								type:        "string"
							}
						}
						required: [
							"dataPool",
							"metadataPool",
							"zoneGroup",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "cephrbdmirrors.ceph.rook.io"
	}
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephRBDMirror"
			listKind: "CephRBDMirrorList"
			plural:   "cephrbdmirrors"
			singular: "cephrbdmirror"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephRBDMirror represents a Ceph RBD Mirror"
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
						description: "RBDMirroringSpec represents the specification of an RBD mirror daemon"
						properties: {
							annotations: {
								additionalProperties: type: "string"
								description:                            "The annotations-related configuration to add/set on each Pod related object."
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							count: {
								description: "Count represents the number of rbd mirror instance to run"
								minimum:     1
								type:        "integer"
							}
							labels: {
								additionalProperties: type: "string"
								description:                            "The labels-related configuration to add/set on each Pod related object."
								nullable:                               true
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							peers: {
								description: "RBDMirroringPeerSpec represents the peers spec"
								nullable:    true
								properties: secretNames: {
									description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror peers"
									items: type: "string"
									type: "array"
								}
								type: "object"
							}
							placement: {
								description: "The affinity to place the rgw pods (default is to place on any available node)"
								nullable:    true
								properties: {
									nodeAffinity: {
										description: "NodeAffinity is a group of node affinity scheduling rules"
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
										description: "PodAffinity is a group of inter pod affinity scheduling rules"
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
										description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
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
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
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
									tolerations: {
										description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>"
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
										description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology"
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
													description: "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed."
													format:      "int32"
													type:        "integer"
												}
												topologyKey: {
													description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
													type:        "string"
												}
												whenUnsatisfiable: {
													description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,   but giving higher precedence to topologies that would help reduce the   skew. A constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assigment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
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
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
							priorityClassName: {
								description: "PriorityClassName sets priority class on the rbd mirror pods"
								type:        "string"
							}
							resources: {
								description: "The resource requirements for the rbd mirror pods"
								nullable:    true
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
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
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
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
						}
						required: [
							"count",
						]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: phase: type: "string"
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: name: "objectbucketclaims.objectbucket.io"
	spec: {
		group: "objectbucket.io"
		names: {
			kind:     "ObjectBucketClaim"
			listKind: "ObjectBucketClaimList"
			plural:   "objectbucketclaims"
			singular: "objectbucketclaim"
			shortNames: [
				"obc",
				"obcs",
			]
		}
		scope: "Namespaced"
		versions: [{
			name:    "v1alpha1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				type: "object"
				properties: {
					spec: {
						type: "object"
						properties: {
							storageClassName: type:   "string"
							bucketName: type:         "string"
							generateBucketName: type: "string"
							additionalConfig: {
								type:                                   "object"
								nullable:                               true
								"x-kubernetes-preserve-unknown-fields": true
							}
							objectBucketName: type: "string"
						}
					}
					status: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
			}
			subresources: status: {}
		}]
	}
}, {
	metadata: name: "objectbuckets.objectbucket.io"
	spec: {
		group: "objectbucket.io"
		names: {
			kind:     "ObjectBucket"
			listKind: "ObjectBucketList"
			plural:   "objectbuckets"
			singular: "objectbucket"
			shortNames: [
				"ob",
				"obs",
			]
		}
		scope: "Cluster"
		versions: [{
			name:    "v1alpha1"
			served:  true
			storage: true
			schema: openAPIV3Schema: {
				type: "object"
				properties: {
					spec: {
						type: "object"
						properties: {
							storageClassName: type: "string"
							endpoint: {
								type:     "object"
								nullable: true
								properties: {
									bucketHost: type: "string"
									bucketPort: {
										type:   "integer"
										format: "int32"
									}
									bucketName: type: "string"
									region: type:     "string"
									subRegion: type:  "string"
									additionalConfig: {
										type:                                   "object"
										nullable:                               true
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
							}
							authentication: {
								type:     "object"
								nullable: true
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
							}
							additionalState: {
								type:                                   "object"
								nullable:                               true
								"x-kubernetes-preserve-unknown-fields": true
							}
							reclaimPolicy: type: "string"
							claimRef: {
								type:                                   "object"
								nullable:                               true
								"x-kubernetes-preserve-unknown-fields": true
							}
						}
					}
					status: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
			}
			subresources: status: {}
		}]
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "volumereplicationclasses.replication.storage.openshift.io"
	}
	spec: {
		group: "replication.storage.openshift.io"
		names: {
			kind:     "VolumeReplicationClass"
			listKind: "VolumeReplicationClassList"
			plural:   "volumereplicationclasses"
			singular: "volumereplicationclass"
		}
		scope: "Cluster"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "VolumeReplicationClass is the Schema for the volumereplicationclasses API"
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
						description: "VolumeReplicationClassSpec specifies parameters that an underlying storage system uses when creating a volume replica. A specific VolumeReplicationClass is used by specifying its name in a VolumeReplication object."
						properties: {
							parameters: {
								additionalProperties: type: "string"
								description: "Parameters is a key-value map with storage provisioner specific configurations for creating volume replicas"
								type:        "object"
							}
							provisioner: {
								description: "Provisioner is the name of storage provisioner"
								type:        "string"
							}
						}
						required: [
							"provisioner",
						]
						type: "object"
					}
					status: {
						description: "VolumeReplicationClassStatus defines the observed state of VolumeReplicationClass"
						type:        "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "volumereplications.replication.storage.openshift.io"
	}
	spec: {
		group: "replication.storage.openshift.io"
		names: {
			kind:     "VolumeReplication"
			listKind: "VolumeReplicationList"
			plural:   "volumereplications"
			singular: "volumereplication"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "VolumeReplication is the Schema for the volumereplications API"
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
						description: "VolumeReplicationSpec defines the desired state of VolumeReplication"
						properties: {
							dataSource: {
								description: "DataSource represents the object associated with the volume"
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
							replicationState: {
								description: "ReplicationState represents the replication operation to be performed on the volume. Supported operations are \"primary\", \"secondary\" and \"resync\""
								type:        "string"
							}
							volumeReplicationClass: {
								description: "VolumeReplicationClass is the VolumeReplicationClass name for this VolumeReplication resource"
								type:        "string"
							}
						}
						required: [
							"dataSource",
							"replicationState",
							"volumeReplicationClass",
						]
						type: "object"
					}
					status: {
						description: "VolumeReplicationStatus defines the observed state of VolumeReplication"
						properties: {
							conditions: {
								description: "Conditions are the list of conditions and their status."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"`
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
							lastCompletionTime: {
								format: "date-time"
								type:   "string"
							}
							lastStartTime: {
								format: "date-time"
								type:   "string"
							}
							message: type: "string"
							observedGeneration: {
								description: "observedGeneration is the last generation change the operator has dealt with"
								format:      "int64"
								type:        "integer"
							}
							state: {
								description: "State captures the latest state of the replication operation"
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
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.5.1-0.20210420220833-f284e2e8098c"
		name: "volumes.rook.io"
	}
	spec: {
		group: "rook.io"
		names: {
			kind:     "Volume"
			listKind: "VolumeList"
			plural:   "volumes"
			shortNames: [
				"rv",
			]
			singular: "volume"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					attachments: {
						items: {
							properties: {
								clusterName: type:  "string"
								mountDir: type:     "string"
								node: type:         "string"
								podName: type:      "string"
								podNamespace: type: "string"
								readOnly: type:     "boolean"
							}
							required: [
								"clusterName",
								"mountDir",
								"node",
								"podName",
								"podNamespace",
								"readOnly",
							]
							type: "object"
						}
						type: "array"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
				}
				required: [
					"attachments",
					"metadata",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}]
