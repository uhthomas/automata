package rook_ceph

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
	metadata: name: "cephblockpoolradosnamespaces.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephBlockPoolRadosNamespace"
			listKind: "CephBlockPoolRadosNamespaceList"
			plural:   "cephblockpoolradosnamespaces"
			singular: "cephblockpoolradosnamespace"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephBlockPoolRadosNamespace represents a Ceph BlockPool Rados Namespace"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec represents the specification of a Ceph BlockPool Rados Namespace"
						properties: {
							blockPoolName: {
								description: "BlockPoolName is the name of Ceph BlockPool. Typically it's the name of the CephBlockPool CR."
								type:        "string"
								"x-kubernetes-validations": [{
									message: "blockPoolName is immutable"
									rule:    "self == oldSelf"
								}]
							}
							name: {
								description: "The name of the CephBlockPoolRadosNamespaceSpec namespace."
								type:        "string"
								"x-kubernetes-validations": [{
									message: "name is immutable"
									rule:    "self == oldSelf"
								}]
							}
						}
						required: ["blockPoolName"]
						type: "object"
					}
					status: {
						description: "Status represents the status of a CephBlockPool Rados Namespace"
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
}, {
	metadata: name: "cephblockpools.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephBlockPool"
			listKind: "CephBlockPoolList"
			plural:   "cephblockpools"
			singular: "cephblockpool"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephBlockPool represents a Ceph Storage Pool"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "NamedBlockPoolSpec allows a block pool to be created with a non-default name."
						properties: {
							compressionMode: {
								description: "DEPRECATED: use Parameters instead, e.g."
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
										description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
										minimum:     0
										type:        "integer"
									}
									dataChunks: {
										description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
								description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
									peers: {
										description: "Peers represents the peers spec"
										nullable:    true
										properties: secretNames: {
											description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
											items: type: "string"
											type: "array"
										}
										type: "object"
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
												path: {
													description: "Path is the path to snapshot, only valid for CephFS"
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
							name: {
								description: "The desired name of the pool if different from the CephBlockPool CR name."
								enum: [
									"device_health_metrics",
									".nfs",
									".mgr",
								]
								type: "string"
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
									hybridStorage: {
										description: "HybridStorage represents hybrid storage tier settings"
										nullable:    true
										properties: {
											primaryDeviceClass: {
												description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
												minLength:   1
												type:        "string"
											}
											secondaryDeviceClass: {
												description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
												minLength:   1
												type:        "string"
											}
										}
										required: [
											"primaryDeviceClass",
											"secondaryDeviceClass",
										]
										type: "object"
									}
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
										description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
										minimum:     0
										type:        "integer"
									}
									subFailureDomain: {
										description: "SubFailureDomain the name of the sub-failure domain"
										type:        "string"
									}
									targetSizeRatio: {
										description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
										type:        "number"
									}
								}
								required: ["size"]
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
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephbucketnotifications.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephBucketNotification"
			listKind: "CephBucketNotificationList"
			plural:   "cephbucketnotifications"
			singular: "cephbucketnotification"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephBucketNotification represents a Bucket Notifications"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "BucketNotificationSpec represent the spec of a Bucket Notification"
						properties: {
							events: {
								description: "List of events that should trigger the notification"
								items: {
									description: "BucketNotificationSpec represent the event type of the bucket notification"
									enum: [
										"s3:ObjectCreated:*",
										"s3:ObjectCreated:Put",
										"s3:ObjectCreated:Post",
										"s3:ObjectCreated:Copy",
										"s3:ObjectCreated:CompleteMultipartUpload",
										"s3:ObjectRemoved:*",
										"s3:ObjectRemoved:Delete",
										"s3:ObjectRemoved:DeleteMarkerCreated",
									]
									type: "string"
								}
								type: "array"
							}
							filter: {
								description: "Spec of notification filter"
								properties: {
									keyFilters: {
										description: "Filters based on the object's key"
										items: {
											description: "NotificationKeyFilterRule represent a single key rule in the Notification Filter spec"
											properties: {
												name: {
													description: "Name of the filter - prefix/suffix/regex"
													enum: [
														"prefix",
														"suffix",
														"regex",
													]
													type: "string"
												}
												value: {
													description: "Value to filter on"
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
									metadataFilters: {
										description: "Filters based on the object's metadata"
										items: {
											description: "NotificationFilterRule represent a single rule in the Notification Filter spec"
											properties: {
												name: {
													description: "Name of the metadata or tag"
													minLength:   1
													type:        "string"
												}
												value: {
													description: "Value to filter on"
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
									tagFilters: {
										description: "Filters based on the object's tags"
										items: {
											description: "NotificationFilterRule represent a single rule in the Notification Filter spec"
											properties: {
												name: {
													description: "Name of the metadata or tag"
													minLength:   1
													type:        "string"
												}
												value: {
													description: "Value to filter on"
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
								}
								type: "object"
							}
							topic: {
								description: "The name of the topic associated with this notification"
								minLength:   1
								type:        "string"
							}
						}
						required: ["topic"]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephbuckettopics.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephBucketTopic"
			listKind: "CephBucketTopicList"
			plural:   "cephbuckettopics"
			singular: "cephbuckettopic"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephBucketTopic represents a Ceph Object Topic for Bucket Notifications"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "BucketTopicSpec represent the spec of a Bucket Topic"
						properties: {
							endpoint: {
								description: "Contains the endpoint spec of the topic"
								properties: {
									amqp: {
										description: "Spec of AMQP endpoint"
										properties: {
											ackLevel: {
												default:     "broker"
												description: "The ack level required for this topic (none/broker/routeable)"
												enum: [
													"none",
													"broker",
													"routeable",
												]
												type: "string"
											}
											disableVerifySSL: {
												description: "Indicate whether the server certificate is validated by the client or not"
												type:        "boolean"
											}
											exchange: {
												description: "Name of the exchange that is used to route messages based on topics"
												minLength:   1
												type:        "string"
											}
											uri: {
												description: "The URI of the AMQP endpoint to push notification to"
												minLength:   1
												type:        "string"
											}
										}
										required: [
											"exchange",
											"uri",
										]
										type: "object"
									}
									http: {
										description: "Spec of HTTP endpoint"
										properties: {
											disableVerifySSL: {
												description: "Indicate whether the server certificate is validated by the client or not"
												type:        "boolean"
											}
											sendCloudEvents: {
												description: "Send the notifications with the CloudEvents header: https://github."
												type:        "boolean"
											}
											uri: {
												description: "The URI of the HTTP endpoint to push notification to"
												minLength:   1
												type:        "string"
											}
										}
										required: ["uri"]
										type: "object"
									}
									kafka: {
										description: "Spec of Kafka endpoint"
										properties: {
											ackLevel: {
												default:     "broker"
												description: "The ack level required for this topic (none/broker)"
												enum: [
													"none",
													"broker",
												]
												type: "string"
											}
											disableVerifySSL: {
												description: "Indicate whether the server certificate is validated by the client or not"
												type:        "boolean"
											}
											uri: {
												description: "The URI of the Kafka endpoint to push notification to"
												minLength:   1
												type:        "string"
											}
											useSSL: {
												description: "Indicate whether to use SSL when communicating with the broker"
												type:        "boolean"
											}
										}
										required: ["uri"]
										type: "object"
									}
								}
								type: "object"
							}
							objectStoreName: {
								description: "The name of the object store on which to define the topic"
								minLength:   1
								type:        "string"
							}
							objectStoreNamespace: {
								description: "The namespace of the object store on which to define the topic"
								minLength:   1
								type:        "string"
							}
							opaqueData: {
								description: "Data which is sent in each event"
								type:        "string"
							}
							persistent: {
								description: "Indication whether notifications to this endpoint are persistent or not"
								type:        "boolean"
							}
						}
						required: [
							"endpoint",
							"objectStoreName",
							"objectStoreNamespace",
						]
						type: "object"
					}
					status: {
						description: "BucketTopicStatus represents the Status of a CephBucketTopic"
						properties: {
							ARN: {
								description: "The ARN of the topic generated by the RGW"
								nullable:    true
								type:        "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephclients.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephClient"
			listKind: "CephClientList"
			plural:   "cephclients"
			singular: "cephclient"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephClient represents a Ceph Client"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
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
						required: ["caps"]
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephclusters.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephCluster"
			listKind: "CephClusterList"
			plural:   "cephclusters"
			singular: "cephcluster"
		}
		scope: apiextensionsv1.#NamespaceScoped
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
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
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
			}, {
				description: "Ceph FSID"
				jsonPath:    ".status.ceph.fsid"
				name:        "FSID"
				type:        "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephCluster is a Ceph storage cluster"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
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
							cephConfig: {
								additionalProperties: {
									additionalProperties: type: "string"
									type: "object"
								}
								description: "Ceph Config options"
								nullable:    true
								type:        "object"
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
										description: "Image is the container image used to launch the ceph daemons, such as quay."
										type:        "string"
									}
									imagePullPolicy: {
										description: "ImagePullPolicy describes a policy for if/when to pull a container image One of Always, Never, IfNot"
										enum: [
											"IfNotPresent",
											"Always",
											"Never",
											"",
										]
										type: "string"
									}
								}
								type: "object"
							}
							cleanupPolicy: {
								description: "Indicates user intent when deleting a cluster; blocks orchestration and should not be set if cluster"
								nullable:    true
								properties: {
									allowUninstallWithVolumes: {
										description: "AllowUninstallWithVolumes defines whether we can proceed with the uninstall if they are RBD images s"
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
								description: "ContinueUpgradeAfterChecksEvenIfNotHealthy defines if an upgrade should continue even if PGs are not"
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
							csi: {
								description: "CSI Driver Options applied per cluster."
								properties: {
									cephfs: {
										description: "CephFS defines CSI Driver settings for CephFS driver."
										properties: {
											fuseMountOptions: {
												description: "FuseMountOptions defines the mount options for ceph fuse mounter."
												type:        "string"
											}
											kernelMountOptions: {
												description: "KernelMountOptions defines the mount options for kernel mounter."
												type:        "string"
											}
										}
										type: "object"
									}
									readAffinity: {
										description: "ReadAffinity defines the read affinity settings for CSI driver."
										properties: {
											crushLocationLabels: {
												description: "CrushLocationLabels defines which node labels to use as CRUSH location."
												items: type: "string"
												type: "array"
											}
											enabled: {
												description: "Enables read affinity for CSI driver."
												type:        "boolean"
											}
										}
										type: "object"
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
									prometheusEndpoint: {
										description: "Endpoint for the Prometheus host"
										type:        "string"
									}
									prometheusEndpointSSLVerify: {
										description: "Whether to verify the ssl endpoint for prometheus. Set to false for a self-signed cert."
										type:        "boolean"
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
								"x-kubernetes-validations": [{
									message: "DataDirHostPath is immutable"
									rule:    "self == oldSelf"
								}]
							}
							disruptionManagement: {
								description: "A spec for configuring disruption management."
								nullable:    true
								properties: {
									machineDisruptionBudgetNamespace: {
										description: "Deprecated. Namespace to look for MDBs by the machineDisruptionBudgetController"
										type:        "string"
									}
									manageMachineDisruptionBudgets: {
										description: "Deprecated. This enables management of machinedisruptionbudgets."
										type:        "boolean"
									}
									managePodBudgets: {
										description: "This enables management of poddisruptionbudgets"
										type:        "boolean"
									}
									osdMaintenanceTimeout: {
										description: "OSDMaintenanceTimeout sets how many additional minutes the DOWN/OUT interval is for drained failure "
										format:      "int64"
										type:        "integer"
									}
									pgHealthCheckTimeout: {
										description: "PGHealthCheckTimeout is the time (in minutes) that the operator will wait for the placement groups t"
										format:      "int64"
										type:        "integer"
									}
									pgHealthyRegex: {
										description: "PgHealthyRegex is the regular expression that is used to determine which PG states should be conside"
										type:        "string"
									}
								}
								type: "object"
							}
							external: {
								description: "Whether the Ceph Cluster is running external to this Kubernetes cluster mon, mgr, osd, mds, and disc"
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
													description: "Probe describes a health check to be performed against a container to determine whether it is alive "
													properties: {
														exec: {
															description: "Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  "
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														failureThreshold: {
															description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																	description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name."
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
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
															description: "Number of seconds after the container has started before liveness probes are initiated."
															format:      "int32"
															type:        "integer"
														}
														periodSeconds: {
															description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
															format:      "int32"
															type:        "integer"
														}
														successThreshold: {
															description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
														terminationGracePeriodSeconds: {
															description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
															format:      "int64"
															type:        "integer"
														}
														timeoutSeconds: {
															description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
															format:      "int32"
															type:        "integer"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										description: "LivenessProbe allows changing the livenessProbe configuration for a given daemon"
										type:        "object"
									}
									startupProbe: {
										additionalProperties: {
											description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
											properties: {
												disabled: {
													description: "Disabled determines whether probe is disable or not"
													type:        "boolean"
												}
												probe: {
													description: "Probe describes a health check to be performed against a container to determine whether it is alive "
													properties: {
														exec: {
															description: "Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  "
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														failureThreshold: {
															description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																	description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name."
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
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
															description: "Number of seconds after the container has started before liveness probes are initiated."
															format:      "int32"
															type:        "integer"
														}
														periodSeconds: {
															description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
															format:      "int32"
															type:        "integer"
														}
														successThreshold: {
															description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
														terminationGracePeriodSeconds: {
															description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
															format:      "int64"
															type:        "integer"
														}
														timeoutSeconds: {
															description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
															format:      "int32"
															type:        "integer"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										description: "StartupProbe allows changing the startupProbe configuration for a given daemon"
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
									maxLogSize: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "MaxLogSize is the maximum size of the log per ceph daemons. Must be at least 1M."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									periodicity: {
										description: "Periodicity is the periodicity of the log rotation."
										pattern:     "^$|^(hourly|daily|weekly|monthly|1h|24h|1d)$"
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
										description: "Count is the number of manager daemons to run"
										maximum:     5
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
										maximum:     9
										minimum:     0
										type:        "integer"
									}
									failureDomainLabel: type: "string"
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
													description: "MonZoneSpec represents the specification of a zone in a Ceph Cluster"
													properties: {
														arbiter: {
															description: "Arbiter determines if the zone contains the arbiter used for stretch cluster mode"
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
																	description: "APIVersion defines the versioned schema of this representation of an object."
																	type:        "string"
																}
																kind: {
																	description: "Kind is a string value representing the REST resource this object represents."
																	type:        "string"
																}
																metadata: {
																	description: "Standard object's metadata. More info: https://git.k8s."
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
																	description: "spec defines the desired characteristics of a volume requested by a pod author."
																	properties: {
																		accessModes: {
																			description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
																			items: type: "string"
																			type: "array"
																		}
																		dataSource: {
																			description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
																			properties: {
																				apiGroup: {
																					description: "APIGroup is the group for the resource being referenced."
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
																			description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
																			properties: {
																				apiGroup: {
																					description: "APIGroup is the group for the resource being referenced."
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
																					description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
																			description: "resources represents the minimum resources the volume should have."
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
																					description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																					description: "Requests describes the minimum amount of compute resources required."
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		storageClassName: {
																			description: "storageClassName is the name of the StorageClass required by the claim."
																			type:        "string"
																		}
																		volumeAttributesClassName: {
																			description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
																			type:        "string"
																		}
																		volumeMode: {
																			description: "volumeMode defines what type of volume is required by the claim."
																			type:        "string"
																		}
																		volumeName: {
																			description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																			type:        "string"
																		}
																	}
																	type: "object"
																}
																status: {
																	description: "status represents the current information/status of a persistent volume claim. Read-only."
																	properties: {
																		accessModes: {
																			description: "accessModes contains the actual access modes the volume backing the PVC has."
																			items: type: "string"
																			type: "array"
																		}
																		allocatedResourceStatuses: {
																			additionalProperties: {
																				description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
																				type:        "string"
																			}
																			description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
																			type:                    "object"
																			"x-kubernetes-map-type": "granular"
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
																			description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
																			type:        "object"
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
																			type:        "object"
																		}
																		conditions: {
																			description: "conditions is the current Condition of persistent volume claim."
																			items: {
																				description: "PersistentVolumeClaimCondition contains details about state of pvc"
																				properties: {
																					lastProbeTime: {
																						description: "lastProbeTime is the time we probed the condition."
																						format:      "date-time"
																						type:        "string"
																					}
																					lastTransitionTime: {
																						description: "lastTransitionTime is the time the condition transitioned from one status to another."
																						format:      "date-time"
																						type:        "string"
																					}
																					message: {
																						description: "message is the human-readable message indicating details about last transition."
																						type:        "string"
																					}
																					reason: {
																						description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
																		currentVolumeAttributesClassName: {
																			description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
																			type:        "string"
																		}
																		modifyVolumeStatus: {
																			description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
																			properties: {
																				status: {
																					description: "status is the status of the ControllerModifyVolume operation."
																					type:        "string"
																				}
																				targetVolumeAttributesClassName: {
																					description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																					type:        "string"
																				}
																			}
																			required: ["status"]
																			type: "object"
																		}
																		phase: {
																			description: "phase represents the current phase of PersistentVolumeClaim."
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
												description: "APIVersion defines the versioned schema of this representation of an object."
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents."
												type:        "string"
											}
											metadata: {
												description: "Standard object's metadata. More info: https://git.k8s."
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
												description: "spec defines the desired characteristics of a volume requested by a pod author."
												properties: {
													accessModes: {
														description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
														items: type: "string"
														type: "array"
													}
													dataSource: {
														description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced."
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
														description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced."
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
																description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
														description: "resources represents the minimum resources the volume should have."
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
																description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																description: "Requests describes the minimum amount of compute resources required."
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
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																	properties: {
																		key: {
																			description: "key is the label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "values is an array of string values."
																			items: type: "string"
																			type: "array"
																		}
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
																description: "matchLabels is a map of {key,value} pairs."
																type:        "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: {
														description: "storageClassName is the name of the StorageClass required by the claim."
														type:        "string"
													}
													volumeAttributesClassName: {
														description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
														type:        "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim."
														type:        "string"
													}
													volumeName: {
														description: "volumeName is the binding reference to the PersistentVolume backing this claim."
														type:        "string"
													}
												}
												type: "object"
											}
											status: {
												description: "status represents the current information/status of a persistent volume claim. Read-only."
												properties: {
													accessModes: {
														description: "accessModes contains the actual access modes the volume backing the PVC has."
														items: type: "string"
														type: "array"
													}
													allocatedResourceStatuses: {
														additionalProperties: {
															description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
															type:        "string"
														}
														description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
														type:                    "object"
														"x-kubernetes-map-type": "granular"
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
														description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
														type:        "object"
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
														type:        "object"
													}
													conditions: {
														description: "conditions is the current Condition of persistent volume claim."
														items: {
															description: "PersistentVolumeClaimCondition contains details about state of pvc"
															properties: {
																lastProbeTime: {
																	description: "lastProbeTime is the time we probed the condition."
																	format:      "date-time"
																	type:        "string"
																}
																lastTransitionTime: {
																	description: "lastTransitionTime is the time the condition transitioned from one status to another."
																	format:      "date-time"
																	type:        "string"
																}
																message: {
																	description: "message is the human-readable message indicating details about last transition."
																	type:        "string"
																}
																reason: {
																	description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
													currentVolumeAttributesClassName: {
														description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
														type:        "string"
													}
													modifyVolumeStatus: {
														description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
														properties: {
															status: {
																description: "status is the status of the ControllerModifyVolume operation."
																type:        "string"
															}
															targetVolumeAttributesClassName: {
																description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																type:        "string"
															}
														}
														required: ["status"]
														type: "object"
													}
													phase: {
														description: "phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									zones: {
										description: "Zones are specified when we want to provide zonal awareness to mons"
										items: {
											description: "MonZoneSpec represents the specification of a zone in a Ceph Cluster"
											properties: {
												arbiter: {
													description: "Arbiter determines if the zone contains the arbiter used for stretch cluster mode"
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
															description: "APIVersion defines the versioned schema of this representation of an object."
															type:        "string"
														}
														kind: {
															description: "Kind is a string value representing the REST resource this object represents."
															type:        "string"
														}
														metadata: {
															description: "Standard object's metadata. More info: https://git.k8s."
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
															description: "spec defines the desired characteristics of a volume requested by a pod author."
															properties: {
																accessModes: {
																	description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
																	items: type: "string"
																	type: "array"
																}
																dataSource: {
																	description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
																	properties: {
																		apiGroup: {
																			description: "APIGroup is the group for the resource being referenced."
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
																	description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
																	properties: {
																		apiGroup: {
																			description: "APIGroup is the group for the resource being referenced."
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
																			description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
																	description: "resources represents the minimum resources the volume should have."
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
																			description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																			description: "Requests describes the minimum amount of compute resources required."
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																storageClassName: {
																	description: "storageClassName is the name of the StorageClass required by the claim."
																	type:        "string"
																}
																volumeAttributesClassName: {
																	description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
																	type:        "string"
																}
																volumeMode: {
																	description: "volumeMode defines what type of volume is required by the claim."
																	type:        "string"
																}
																volumeName: {
																	description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																	type:        "string"
																}
															}
															type: "object"
														}
														status: {
															description: "status represents the current information/status of a persistent volume claim. Read-only."
															properties: {
																accessModes: {
																	description: "accessModes contains the actual access modes the volume backing the PVC has."
																	items: type: "string"
																	type: "array"
																}
																allocatedResourceStatuses: {
																	additionalProperties: {
																		description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
																		type:        "string"
																	}
																	description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
																	type:                    "object"
																	"x-kubernetes-map-type": "granular"
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
																	description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
																	type:        "object"
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
																	type:        "object"
																}
																conditions: {
																	description: "conditions is the current Condition of persistent volume claim."
																	items: {
																		description: "PersistentVolumeClaimCondition contains details about state of pvc"
																		properties: {
																			lastProbeTime: {
																				description: "lastProbeTime is the time we probed the condition."
																				format:      "date-time"
																				type:        "string"
																			}
																			lastTransitionTime: {
																				description: "lastTransitionTime is the time the condition transitioned from one status to another."
																				format:      "date-time"
																				type:        "string"
																			}
																			message: {
																				description: "message is the human-readable message indicating details about last transition."
																				type:        "string"
																			}
																			reason: {
																				description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
																currentVolumeAttributesClassName: {
																	description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
																	type:        "string"
																}
																modifyVolumeStatus: {
																	description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
																	properties: {
																		status: {
																			description: "status is the status of the ControllerModifyVolume operation."
																			type:        "string"
																		}
																		targetVolumeAttributesClassName: {
																			description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																			type:        "string"
																		}
																	}
																	required: ["status"]
																	type: "object"
																}
																phase: {
																	description: "phase represents the current phase of PersistentVolumeClaim."
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
										type: "array"
									}
								}
								type: "object"
								"x-kubernetes-validations": [{
									message: "zones must be less than or equal to count"
									rule:    "!has(self.zones) || (has(self.zones) && (size(self.zones) <= self.count))"
								}, {
									message: "stretchCluster zones must be equal to 3"
									rule:    "!has(self.stretchCluster) || (has(self.stretchCluster) && (size(self.stretchCluster.zones) > 0) && (size(self.stretchCluster.zones) == 3))"
								}]
							}
							monitoring: {
								description: "Prometheus based Monitoring settings"
								nullable:    true
								properties: {
									enabled: {
										description: "Enabled determines whether to create the prometheus rules for the ceph cluster."
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
													description: "The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0."
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
															description: "If referring to a piece of an object instead of an entire object, this string should contain a valid"
															type:        "string"
														}
														kind: {
															description: "Kind of the referent. More info: https://git.k8s."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes."
															type:        "string"
														}
														namespace: {
															description: "Namespace of the referent. More info: https://kubernetes."
															type:        "string"
														}
														resourceVersion: {
															description: "Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s."
															type:        "string"
														}
														uid: {
															description: "UID of the referent. More info: https://kubernetes."
															type:        "string"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											required: ["ip"]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
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
									interval: {
										description: "Interval determines prometheus scrape interval"
										type:        "string"
									}
									metricsDisabled: {
										description: "Whether to disable the metrics reported by Ceph."
										type:        "boolean"
									}
									port: {
										description: "Port is the prometheus server port"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
								}
								type: "object"
							}
							network: {
								description: "Network related configuration"
								nullable:    true
								properties: {
									addressRanges: {
										description: "AddressRanges specify a list of CIDRs that Rook will apply to Ceph's 'public_network' and/or 'cluste"
										nullable:    true
										properties: {
											cluster: {
												description: "Cluster defines a list of CIDRs to use for Ceph cluster network communication."
												items: {
													description: "An IPv4 or IPv6 network CIDR."
													pattern:     "^[0-9a-fA-F:.]{2,}\\/[0-9]{1,3}$"
													type:        "string"
												}
												type: "array"
											}
											public: {
												description: "Public defines a list of CIDRs to use for Ceph public network communication."
												items: {
													description: "An IPv4 or IPv6 network CIDR."
													pattern:     "^[0-9a-fA-F:.]{2,}\\/[0-9]{1,3}$"
													type:        "string"
												}
												type: "array"
											}
										}
										type: "object"
									}
									connections: {
										description: "Settings for network connections such as compression and encryption across the wire."
										nullable:    true
										properties: {
											compression: {
												description: "Compression settings for the network connections."
												nullable:    true
												properties: enabled: {
													description: "Whether to compress the data in transit across the wire. The default is not set."
													type:        "boolean"
												}
												type: "object"
											}
											encryption: {
												description: "Encryption settings for the network connections."
												nullable:    true
												properties: enabled: {
													description: "Whether to encrypt the data in transit across the wire to prevent eavesdropping the data on the netw"
													type:        "boolean"
												}
												type: "object"
											}
											requireMsgr2: {
												description: "Whether to require msgr2 (port 3300) even if compression or encryption are not enabled."
												type:        "boolean"
											}
										}
										type: "object"
									}
									dualStack: {
										description: "DualStack determines whether Ceph daemons should listen on both IPv4 and IPv6"
										type:        "boolean"
									}
									hostNetwork: {
										description: "HostNetwork to enable host network."
										type:        "boolean"
									}
									ipFamily: {
										description: "IPFamily is the single stack IPv6 or IPv4 protocol"
										enum: [
											"IPv4",
											"IPv6",
										]
										nullable: true
										type:     "string"
									}
									multiClusterService: {
										description: "Enable multiClusterService to export the Services between peer clusters"
										properties: {
											clusterID: {
												description: "ClusterID uniquely identifies a cluster. It is used as a prefix to nslookup exported services."
												type:        "string"
											}
											enabled: {
												description: "Enable multiClusterService to export the mon and OSD services to peer cluster."
												type:        "boolean"
											}
										}
										type: "object"
									}
									provider: {
										description: "Provider is what provides network connectivity to the cluster e.g. \"host\" or \"multus\"."
										enum: [
											"",
											"host",
											"multus",
										]
										nullable: true
										type:     "string"
										"x-kubernetes-validations": [{
											message: "network provider must be disabled (reverted to empty string) before a new provider is enabled"
											rule:    "self == '' || self == oldSelf"
										}]
									}
									selectors: {
										additionalProperties: type: "string"
										description: "Selectors define NetworkAttachmentDefinitions to be used for Ceph public and/or cluster networks whe"
										nullable:    true
										type:        "object"
									}
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
								"x-kubernetes-validations": [{
									message: "at least one network selector must be specified when using multus"
									rule:    "!has(self.provider) || (self.provider != 'multus' || (self.provider == 'multus' && size(self.selectors) > 0))"
								}]
							}
							placement: {
								additionalProperties: {
									description: "Placement is the placement for an object"
									properties: {
										nodeAffinity: {
											description: "NodeAffinity is a group of node affinity scheduling rules"
											properties: {
												preferredDuringSchedulingIgnoredDuringExecution: {
													description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
													items: {
														description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
														properties: {
															preference: {
																description: "A node selector term, associated with the corresponding weight."
																properties: {
																	matchExpressions: {
																		description: "A list of node selector requirements by node's labels."
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
													description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
													properties: nodeSelectorTerms: {
														description: "Required. A list of node selector terms. The terms are ORed."
														items: {
															description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
											description: "PodAffinity is a group of inter pod affinity scheduling rules"
											properties: {
												preferredDuringSchedulingIgnoredDuringExecution: {
													description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
													items: {
														description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	matchLabelKeys: {
																		description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	mismatchLabelKeys: {
																		description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
													description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
													items: {
														description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
														properties: {
															labelSelector: {
																description: "A label query over a set of resources, in this case pods."
																properties: {
																	matchExpressions: {
																		description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																		items: {
																			description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																			properties: {
																				key: {
																					description: "key is the label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "operator represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "values is an array of string values."
																					items: type: "string"
																					type: "array"
																				}
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
																		description: "matchLabels is a map of {key,value} pairs."
																		type:        "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															matchLabelKeys: {
																description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																items: type: "string"
																type:                     "array"
																"x-kubernetes-list-type": "atomic"
															}
															mismatchLabelKeys: {
																description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																items: type: "string"
																type:                     "array"
																"x-kubernetes-list-type": "atomic"
															}
															namespaceSelector: {
																description: "A label query over the set of namespaces that the term applies to."
																properties: {
																	matchExpressions: {
																		description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																		items: {
																			description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																			properties: {
																				key: {
																					description: "key is the label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "operator represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "values is an array of string values."
																					items: type: "string"
																					type: "array"
																				}
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
																		description: "matchLabels is a map of {key,value} pairs."
																		type:        "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															namespaces: {
																description: "namespaces specifies a static list of namespace names that the term applies to."
																items: type: "string"
																type: "array"
															}
															topologyKey: {
																description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
											description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
											properties: {
												preferredDuringSchedulingIgnoredDuringExecution: {
													description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
													items: {
														description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	matchLabelKeys: {
																		description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	mismatchLabelKeys: {
																		description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	namespaceSelector: {
																		description: "A label query over the set of namespaces that the term applies to."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	namespaces: {
																		description: "namespaces specifies a static list of namespace names that the term applies to."
																		items: type: "string"
																		type: "array"
																	}
																	topologyKey: {
																		description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
													description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
													items: {
														description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
														properties: {
															labelSelector: {
																description: "A label query over a set of resources, in this case pods."
																properties: {
																	matchExpressions: {
																		description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																		items: {
																			description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																			properties: {
																				key: {
																					description: "key is the label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "operator represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "values is an array of string values."
																					items: type: "string"
																					type: "array"
																				}
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
																		description: "matchLabels is a map of {key,value} pairs."
																		type:        "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															matchLabelKeys: {
																description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																items: type: "string"
																type:                     "array"
																"x-kubernetes-list-type": "atomic"
															}
															mismatchLabelKeys: {
																description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																items: type: "string"
																type:                     "array"
																"x-kubernetes-list-type": "atomic"
															}
															namespaceSelector: {
																description: "A label query over the set of namespaces that the term applies to."
																properties: {
																	matchExpressions: {
																		description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																		items: {
																			description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																			properties: {
																				key: {
																					description: "key is the label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "operator represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "values is an array of string values."
																					items: type: "string"
																					type: "array"
																				}
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
																		description: "matchLabels is a map of {key,value} pairs."
																		type:        "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															namespaces: {
																description: "namespaces specifies a static list of namespace names that the term applies to."
																items: type: "string"
																type: "array"
															}
															topologyKey: {
																description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
										tolerations: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
											items: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
												properties: {
													effect: {
														description: "Effect indicates the taint effect to match. Empty means match all taint effects."
														type:        "string"
													}
													key: {
														description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
														type:        "string"
													}
													operator: {
														description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
														type:        "string"
													}
													tolerationSeconds: {
														description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
														format:      "int64"
														type:        "integer"
													}
													value: {
														description: "Value is the taint value the toleration matches to."
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
														description: "LabelSelector is used to find matching pods."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																	properties: {
																		key: {
																			description: "key is the label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "values is an array of string values."
																			items: type: "string"
																			type: "array"
																		}
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
																description: "matchLabels is a map of {key,value} pairs."
																type:        "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													matchLabelKeys: {
														description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
														items: type: "string"
														type:                     "array"
														"x-kubernetes-list-type": "atomic"
													}
													maxSkew: {
														description: "MaxSkew describes the degree to which pods may be unevenly distributed."
														format:      "int32"
														type:        "integer"
													}
													minDomains: {
														description: "MinDomains indicates a minimum number of eligible domains."
														format:      "int32"
														type:        "integer"
													}
													nodeAffinityPolicy: {
														description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
														type:        "string"
													}
													nodeTaintsPolicy: {
														description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
														type:        "string"
													}
													topologyKey: {
														description: "TopologyKey is the key of node labels."
														type:        "string"
													}
													whenUnsatisfiable: {
														description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
										claims: {
											description: "Claims lists the names of resources, defined in spec."
											items: {
												description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
												properties: name: {
													description: "Name must match the name of one entry in pod.spec."
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
											description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
											description: "Requests describes the minimum amount of compute resources required."
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
								properties: {
									keyRotation: {
										description: "KeyRotation defines options for Key Rotation."
										nullable:    true
										properties: {
											enabled: {
												default:     false
												description: "Enabled represents whether the key rotation is enabled."
												type:        "boolean"
											}
											schedule: {
												description: "Schedule represents the cron schedule for key rotation."
												type:        "string"
											}
										}
										type: "object"
									}
									kms: {
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
													nullable:                               true
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
									flappingRestartIntervalHours: {
										description: "FlappingRestartIntervalHours defines the time for which the OSD pods, that failed with zero exit cod"
										type:        "integer"
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
																nullable:                               true
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
														claims: {
															description: "Claims lists the names of resources, defined in spec."
															items: {
																description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																properties: name: {
																	description: "Name must match the name of one entry in pod.spec."
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
															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
															description: "Requests describes the minimum amount of compute resources required."
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
																description: "APIVersion defines the versioned schema of this representation of an object."
																type:        "string"
															}
															kind: {
																description: "Kind is a string value representing the REST resource this object represents."
																type:        "string"
															}
															metadata: {
																description: "Standard object's metadata. More info: https://git.k8s."
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
																description: "spec defines the desired characteristics of a volume requested by a pod author."
																properties: {
																	accessModes: {
																		description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
																		items: type: "string"
																		type: "array"
																	}
																	dataSource: {
																		description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced."
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
																		description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced."
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
																				description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
																		description: "resources represents the minimum resources the volume should have."
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
																				description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																				description: "Requests describes the minimum amount of compute resources required."
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
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	storageClassName: {
																		description: "storageClassName is the name of the StorageClass required by the claim."
																		type:        "string"
																	}
																	volumeAttributesClassName: {
																		description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
																		type:        "string"
																	}
																	volumeMode: {
																		description: "volumeMode defines what type of volume is required by the claim."
																		type:        "string"
																	}
																	volumeName: {
																		description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																		type:        "string"
																	}
																}
																type: "object"
															}
															status: {
																description: "status represents the current information/status of a persistent volume claim. Read-only."
																properties: {
																	accessModes: {
																		description: "accessModes contains the actual access modes the volume backing the PVC has."
																		items: type: "string"
																		type: "array"
																	}
																	allocatedResourceStatuses: {
																		additionalProperties: {
																			description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
																			type:        "string"
																		}
																		description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
																		type:                    "object"
																		"x-kubernetes-map-type": "granular"
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
																		description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
																		type:        "object"
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
																		type:        "object"
																	}
																	conditions: {
																		description: "conditions is the current Condition of persistent volume claim."
																		items: {
																			description: "PersistentVolumeClaimCondition contains details about state of pvc"
																			properties: {
																				lastProbeTime: {
																					description: "lastProbeTime is the time we probed the condition."
																					format:      "date-time"
																					type:        "string"
																				}
																				lastTransitionTime: {
																					description: "lastTransitionTime is the time the condition transitioned from one status to another."
																					format:      "date-time"
																					type:        "string"
																				}
																				message: {
																					description: "message is the human-readable message indicating details about last transition."
																					type:        "string"
																				}
																				reason: {
																					description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
																	currentVolumeAttributesClassName: {
																		description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
																		type:        "string"
																	}
																	modifyVolumeStatus: {
																		description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
																		properties: {
																			status: {
																				description: "status is the status of the ControllerModifyVolume operation."
																				type:        "string"
																			}
																			targetVolumeAttributesClassName: {
																				description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																				type:        "string"
																			}
																		}
																		required: ["status"]
																		type: "object"
																	}
																	phase: {
																		description: "phase represents the current phase of PersistentVolumeClaim."
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
									onlyApplyOSDPlacement: type: "boolean"
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
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
																	items: {
																		description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
																		properties: {
																			preference: {
																				description: "A node selector term, associated with the corresponding weight."
																				properties: {
																					matchExpressions: {
																						description: "A list of node selector requirements by node's labels."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																							properties: {
																								key: {
																									description: "The label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "Represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																									items: type: "string"
																									type: "array"
																								}
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
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																							properties: {
																								key: {
																									description: "The label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "Represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																									items: type: "string"
																									type: "array"
																								}
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
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
																	properties: nodeSelectorTerms: {
																		description: "Required. A list of node selector terms. The terms are ORed."
																		items: {
																			description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																						properties: {
																							key: {
																								description: "The label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																								items: type: "string"
																								type: "array"
																							}
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
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																						properties: {
																							key: {
																								description: "The label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																								items: type: "string"
																								type: "array"
																							}
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
															description: "PodAffinity is a group of inter pod affinity scheduling rules"
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					matchLabelKeys: {
																						description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					mismatchLabelKeys: {
																						description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			matchLabelKeys: {
																				description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			mismatchLabelKeys: {
																				description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
															description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					matchLabelKeys: {
																						description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					mismatchLabelKeys: {
																						description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
																	description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			matchLabelKeys: {
																				description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			mismatchLabelKeys: {
																				description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														tolerations: {
															description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
															items: {
																description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
																properties: {
																	effect: {
																		description: "Effect indicates the taint effect to match. Empty means match all taint effects."
																		type:        "string"
																	}
																	key: {
																		description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
																		type:        "string"
																	}
																	operator: {
																		description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
																		type:        "string"
																	}
																	tolerationSeconds: {
																		description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
																		format:      "int64"
																		type:        "integer"
																	}
																	value: {
																		description: "Value is the taint value the toleration matches to."
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
																		description: "LabelSelector is used to find matching pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	matchLabelKeys: {
																		description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	maxSkew: {
																		description: "MaxSkew describes the degree to which pods may be unevenly distributed."
																		format:      "int32"
																		type:        "integer"
																	}
																	minDomains: {
																		description: "MinDomains indicates a minimum number of eligible domains."
																		format:      "int32"
																		type:        "integer"
																	}
																	nodeAffinityPolicy: {
																		description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
																		type:        "string"
																	}
																	nodeTaintsPolicy: {
																		description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
																		type:        "string"
																	}
																	topologyKey: {
																		description: "TopologyKey is the key of node labels."
																		type:        "string"
																	}
																	whenUnsatisfiable: {
																		description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
																	items: {
																		description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
																		properties: {
																			preference: {
																				description: "A node selector term, associated with the corresponding weight."
																				properties: {
																					matchExpressions: {
																						description: "A list of node selector requirements by node's labels."
																						items: {
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																							properties: {
																								key: {
																									description: "The label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "Represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																									items: type: "string"
																									type: "array"
																								}
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
																							description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																							properties: {
																								key: {
																									description: "The label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "Represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																									items: type: "string"
																									type: "array"
																								}
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
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
																	properties: nodeSelectorTerms: {
																		description: "Required. A list of node selector terms. The terms are ORed."
																		items: {
																			description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
																			properties: {
																				matchExpressions: {
																					description: "A list of node selector requirements by node's labels."
																					items: {
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																						properties: {
																							key: {
																								description: "The label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																								items: type: "string"
																								type: "array"
																							}
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
																						description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																						properties: {
																							key: {
																								description: "The label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "Represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																								items: type: "string"
																								type: "array"
																							}
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
															description: "PodAffinity is a group of inter pod affinity scheduling rules"
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					matchLabelKeys: {
																						description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					mismatchLabelKeys: {
																						description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
																	description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			matchLabelKeys: {
																				description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			mismatchLabelKeys: {
																				description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
															description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
															properties: {
																preferredDuringSchedulingIgnoredDuringExecution: {
																	description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
																	items: {
																		description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					matchLabelKeys: {
																						description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					mismatchLabelKeys: {
																						description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																						items: type: "string"
																						type:                     "array"
																						"x-kubernetes-list-type": "atomic"
																					}
																					namespaceSelector: {
																						description: "A label query over the set of namespaces that the term applies to."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					namespaces: {
																						description: "namespaces specifies a static list of namespace names that the term applies to."
																						items: type: "string"
																						type: "array"
																					}
																					topologyKey: {
																						description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
																	description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
																	items: {
																		description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
																		properties: {
																			labelSelector: {
																				description: "A label query over a set of resources, in this case pods."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			matchLabelKeys: {
																				description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			mismatchLabelKeys: {
																				description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																				items: type: "string"
																				type:                     "array"
																				"x-kubernetes-list-type": "atomic"
																			}
																			namespaceSelector: {
																				description: "A label query over the set of namespaces that the term applies to."
																				properties: {
																					matchExpressions: {
																						description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																						items: {
																							description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																							properties: {
																								key: {
																									description: "key is the label key that the selector applies to."
																									type:        "string"
																								}
																								operator: {
																									description: "operator represents a key's relationship to a set of values."
																									type:        "string"
																								}
																								values: {
																									description: "values is an array of string values."
																									items: type: "string"
																									type: "array"
																								}
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
																						description: "matchLabels is a map of {key,value} pairs."
																						type:        "object"
																					}
																				}
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			namespaces: {
																				description: "namespaces specifies a static list of namespace names that the term applies to."
																				items: type: "string"
																				type: "array"
																			}
																			topologyKey: {
																				description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														tolerations: {
															description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
															items: {
																description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
																properties: {
																	effect: {
																		description: "Effect indicates the taint effect to match. Empty means match all taint effects."
																		type:        "string"
																	}
																	key: {
																		description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
																		type:        "string"
																	}
																	operator: {
																		description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
																		type:        "string"
																	}
																	tolerationSeconds: {
																		description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
																		format:      "int64"
																		type:        "integer"
																	}
																	value: {
																		description: "Value is the taint value the toleration matches to."
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
																		description: "LabelSelector is used to find matching pods."
																		properties: {
																			matchExpressions: {
																				description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																				items: {
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	matchLabelKeys: {
																		description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
																		items: type: "string"
																		type:                     "array"
																		"x-kubernetes-list-type": "atomic"
																	}
																	maxSkew: {
																		description: "MaxSkew describes the degree to which pods may be unevenly distributed."
																		format:      "int32"
																		type:        "integer"
																	}
																	minDomains: {
																		description: "MinDomains indicates a minimum number of eligible domains."
																		format:      "int32"
																		type:        "integer"
																	}
																	nodeAffinityPolicy: {
																		description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
																		type:        "string"
																	}
																	nodeTaintsPolicy: {
																		description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
																		type:        "string"
																	}
																	topologyKey: {
																		description: "TopologyKey is the key of node labels."
																		type:        "string"
																	}
																	whenUnsatisfiable: {
																		description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
														claims: {
															description: "Claims lists the names of resources, defined in spec."
															items: {
																description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																properties: name: {
																	description: "Name must match the name of one entry in pod.spec."
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
															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
															description: "Requests describes the minimum amount of compute resources required."
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
																description: "APIVersion defines the versioned schema of this representation of an object."
																type:        "string"
															}
															kind: {
																description: "Kind is a string value representing the REST resource this object represents."
																type:        "string"
															}
															metadata: {
																description: "Standard object's metadata. More info: https://git.k8s."
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
																description: "spec defines the desired characteristics of a volume requested by a pod author."
																properties: {
																	accessModes: {
																		description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
																		items: type: "string"
																		type: "array"
																	}
																	dataSource: {
																		description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced."
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
																		description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
																		properties: {
																			apiGroup: {
																				description: "APIGroup is the group for the resource being referenced."
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
																				description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
																		description: "resources represents the minimum resources the volume should have."
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
																				description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																				description: "Requests describes the minimum amount of compute resources required."
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
																					description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																					properties: {
																						key: {
																							description: "key is the label key that the selector applies to."
																							type:        "string"
																						}
																						operator: {
																							description: "operator represents a key's relationship to a set of values."
																							type:        "string"
																						}
																						values: {
																							description: "values is an array of string values."
																							items: type: "string"
																							type: "array"
																						}
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
																				description: "matchLabels is a map of {key,value} pairs."
																				type:        "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	storageClassName: {
																		description: "storageClassName is the name of the StorageClass required by the claim."
																		type:        "string"
																	}
																	volumeAttributesClassName: {
																		description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
																		type:        "string"
																	}
																	volumeMode: {
																		description: "volumeMode defines what type of volume is required by the claim."
																		type:        "string"
																	}
																	volumeName: {
																		description: "volumeName is the binding reference to the PersistentVolume backing this claim."
																		type:        "string"
																	}
																}
																type: "object"
															}
															status: {
																description: "status represents the current information/status of a persistent volume claim. Read-only."
																properties: {
																	accessModes: {
																		description: "accessModes contains the actual access modes the volume backing the PVC has."
																		items: type: "string"
																		type: "array"
																	}
																	allocatedResourceStatuses: {
																		additionalProperties: {
																			description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
																			type:        "string"
																		}
																		description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
																		type:                    "object"
																		"x-kubernetes-map-type": "granular"
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
																		description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
																		type:        "object"
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
																		type:        "object"
																	}
																	conditions: {
																		description: "conditions is the current Condition of persistent volume claim."
																		items: {
																			description: "PersistentVolumeClaimCondition contains details about state of pvc"
																			properties: {
																				lastProbeTime: {
																					description: "lastProbeTime is the time we probed the condition."
																					format:      "date-time"
																					type:        "string"
																				}
																				lastTransitionTime: {
																					description: "lastTransitionTime is the time the condition transitioned from one status to another."
																					format:      "date-time"
																					type:        "string"
																				}
																				message: {
																					description: "message is the human-readable message indicating details about last transition."
																					type:        "string"
																				}
																				reason: {
																					description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
																	currentVolumeAttributesClassName: {
																		description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
																		type:        "string"
																	}
																	modifyVolumeStatus: {
																		description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
																		properties: {
																			status: {
																				description: "status is the status of the ControllerModifyVolume operation."
																				type:        "string"
																			}
																			targetVolumeAttributesClassName: {
																				description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																				type:        "string"
																			}
																		}
																		required: ["status"]
																		type: "object"
																	}
																	phase: {
																		description: "phase represents the current phase of PersistentVolumeClaim."
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
									store: {
										description: "OSDStore is the backend storage type used for creating the OSDs"
										properties: {
											type: {
												description: "Type of backend storage to be used while creating OSDs. If empty, then bluestore will be used"
												enum: [
													"bluestore",
													"bluestore-rdr",
												]
												type: "string"
											}
											updateStore: {
												description: "UpdateStore updates the backend store for existing OSDs."
												pattern:     "^$|^yes-really-update-store$"
												type:        "string"
											}
										}
										type: "object"
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
													description: "APIVersion defines the versioned schema of this representation of an object."
													type:        "string"
												}
												kind: {
													description: "Kind is a string value representing the REST resource this object represents."
													type:        "string"
												}
												metadata: {
													description: "Standard object's metadata. More info: https://git.k8s."
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
													description: "spec defines the desired characteristics of a volume requested by a pod author."
													properties: {
														accessModes: {
															description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes."
															items: type: "string"
															type: "array"
														}
														dataSource: {
															description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot."
															properties: {
																apiGroup: {
																	description: "APIGroup is the group for the resource being referenced."
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
															description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volum"
															properties: {
																apiGroup: {
																	description: "APIGroup is the group for the resource being referenced."
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
																	description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a g"
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
															description: "resources represents the minimum resources the volume should have."
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
																	description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
																	description: "Requests describes the minimum amount of compute resources required."
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
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: {
															description: "storageClassName is the name of the StorageClass required by the claim."
															type:        "string"
														}
														volumeAttributesClassName: {
															description: "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim."
															type:        "string"
														}
														volumeMode: {
															description: "volumeMode defines what type of volume is required by the claim."
															type:        "string"
														}
														volumeName: {
															description: "volumeName is the binding reference to the PersistentVolume backing this claim."
															type:        "string"
														}
													}
													type: "object"
												}
												status: {
													description: "status represents the current information/status of a persistent volume claim. Read-only."
													properties: {
														accessModes: {
															description: "accessModes contains the actual access modes the volume backing the PVC has."
															items: type: "string"
															type: "array"
														}
														allocatedResourceStatuses: {
															additionalProperties: {
																description: "When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource tha"
																type:        "string"
															}
															description:             "allocatedResourceStatuses stores status of resource being resized for the given PVC."
															type:                    "object"
															"x-kubernetes-map-type": "granular"
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
															description: "allocatedResources tracks the resources allocated to a PVC including its capacity."
															type:        "object"
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
															type:        "object"
														}
														conditions: {
															description: "conditions is the current Condition of persistent volume claim."
															items: {
																description: "PersistentVolumeClaimCondition contains details about state of pvc"
																properties: {
																	lastProbeTime: {
																		description: "lastProbeTime is the time we probed the condition."
																		format:      "date-time"
																		type:        "string"
																	}
																	lastTransitionTime: {
																		description: "lastTransitionTime is the time the condition transitioned from one status to another."
																		format:      "date-time"
																		type:        "string"
																	}
																	message: {
																		description: "message is the human-readable message indicating details about last transition."
																		type:        "string"
																	}
																	reason: {
																		description: "reason is a unique, this should be a short, machine understandable string that gives the reason for "
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
														currentVolumeAttributesClassName: {
															description: "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using."
															type:        "string"
														}
														modifyVolumeStatus: {
															description: "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation."
															properties: {
																status: {
																	description: "status is the status of the ControllerModifyVolume operation."
																	type:        "string"
																}
																targetVolumeAttributesClassName: {
																	description: "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being rec"
																	type:        "string"
																}
															}
															required: ["status"]
															type: "object"
														}
														phase: {
															description: "phase represents the current phase of PersistentVolumeClaim."
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
								description: "WaitTimeoutForHealthyOSDInMinutes defines the time the operator would wait before an OSD can be stop"
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
									fsid: type:           "string"
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
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
							}
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
								properties: {
									deviceClasses: {
										items: {
											description: "DeviceClasses represents device classes of a Ceph Cluster"
											properties: name: type: "string"
											type: "object"
										}
										type: "array"
									}
									osd: {
										description: "OSDStatus represents OSD status of the ceph Cluster"
										properties: storeType: {
											additionalProperties: type: "integer"
											description: "StoreType is a mapping between the OSD backend stores and number of OSDs using these stores"
											type:        "object"
										}
										type: "object"
									}
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
}, {
	metadata: name: "cephcosidrivers.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephCOSIDriver"
			listKind: "CephCOSIDriverList"
			plural:   "cephcosidrivers"
			shortNames: ["cephcosi"]
			singular: "cephcosidriver"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephCOSIDriver represents the CRD for the Ceph COSI Driver Deployment"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec represents the specification of a Ceph COSI Driver"
						properties: {
							deploymentStrategy: {
								description: "DeploymentStrategy is the strategy to use to deploy the COSI driver."
								enum: [
									"Never",
									"Auto",
									"Always",
								]
								type: "string"
							}
							image: {
								description: "Image is the container image to run the Ceph COSI driver"
								type:        "string"
							}
							objectProvisionerImage: {
								description: "ObjectProvisionerImage is the container image to run the COSI driver sidecar"
								type:        "string"
							}
							placement: {
								description: "Placement is the placement strategy to use for the COSI driver"
								properties: {
									nodeAffinity: {
										description: "NodeAffinity is a group of node affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
										description: "PodAffinity is a group of inter pod affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
										description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
									tolerations: {
										description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects."
													type:        "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
													type:        "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
													type:        "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
													format:      "int64"
													type:        "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to."
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
													description: "LabelSelector is used to find matching pods."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																properties: {
																	key: {
																		description: "key is the label key that the selector applies to."
																		type:        "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values."
																		type:        "string"
																	}
																	values: {
																		description: "values is an array of string values."
																		items: type: "string"
																		type: "array"
																	}
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
															description: "matchLabels is a map of {key,value} pairs."
															type:        "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												matchLabelKeys: {
													description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
													items: type: "string"
													type:                     "array"
													"x-kubernetes-list-type": "atomic"
												}
												maxSkew: {
													description: "MaxSkew describes the degree to which pods may be unevenly distributed."
													format:      "int32"
													type:        "integer"
												}
												minDomains: {
													description: "MinDomains indicates a minimum number of eligible domains."
													format:      "int32"
													type:        "integer"
												}
												nodeAffinityPolicy: {
													description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
													type:        "string"
												}
												nodeTaintsPolicy: {
													description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
													type:        "string"
												}
												topologyKey: {
													description: "TopologyKey is the key of node labels."
													type:        "string"
												}
												whenUnsatisfiable: {
													description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
							resources: {
								description: "Resources is the resource requirements for the COSI driver"
								properties: {
									claims: {
										description: "Claims lists the names of resources, defined in spec."
										items: {
											description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
											properties: name: {
												description: "Name must match the name of one entry in pod.spec."
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
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
										description: "Requests describes the minimum amount of compute resources required."
										type:        "object"
									}
								}
								type: "object"
							}
						}
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
		}]
	}
}, {
	metadata: name: "cephfilesystemmirrors.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephFilesystemMirror"
			listKind: "CephFilesystemMirrorList"
			plural:   "cephfilesystemmirrors"
			singular: "cephfilesystemmirror"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephFilesystemMirror is the Ceph Filesystem Mirror object definition"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "FilesystemMirroringSpec is the filesystem mirroring specification"
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
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
										description: "PodAffinity is a group of inter pod affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
										description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
									tolerations: {
										description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects."
													type:        "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
													type:        "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
													type:        "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
													format:      "int64"
													type:        "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to."
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
													description: "LabelSelector is used to find matching pods."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																properties: {
																	key: {
																		description: "key is the label key that the selector applies to."
																		type:        "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values."
																		type:        "string"
																	}
																	values: {
																		description: "values is an array of string values."
																		items: type: "string"
																		type: "array"
																	}
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
															description: "matchLabels is a map of {key,value} pairs."
															type:        "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												matchLabelKeys: {
													description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
													items: type: "string"
													type:                     "array"
													"x-kubernetes-list-type": "atomic"
												}
												maxSkew: {
													description: "MaxSkew describes the degree to which pods may be unevenly distributed."
													format:      "int32"
													type:        "integer"
												}
												minDomains: {
													description: "MinDomains indicates a minimum number of eligible domains."
													format:      "int32"
													type:        "integer"
												}
												nodeAffinityPolicy: {
													description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
													type:        "string"
												}
												nodeTaintsPolicy: {
													description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
													type:        "string"
												}
												topologyKey: {
													description: "TopologyKey is the key of node labels."
													type:        "string"
												}
												whenUnsatisfiable: {
													description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
									claims: {
										description: "Claims lists the names of resources, defined in spec."
										items: {
											description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
											properties: name: {
												description: "Name must match the name of one entry in pod.spec."
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
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
										description: "Requests describes the minimum amount of compute resources required."
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
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
							}
							phase: type: "string"
						}
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
}, {
	metadata: name: "cephfilesystems.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephFilesystem"
			listKind: "CephFilesystemList"
			plural:   "cephfilesystems"
			singular: "cephfilesystem"
		}
		scope: apiextensionsv1.#NamespaceScoped
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
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "FilesystemSpec represents the spec of a file system"
						properties: {
							dataPools: {
								description: "The data pool settings, with optional predefined pool name."
								items: {
									description: "NamedPoolSpec represents the named ceph pool spec"
									properties: {
										compressionMode: {
											description: "DEPRECATED: use Parameters instead, e.g."
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
													description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
													minimum:     0
													type:        "integer"
												}
												dataChunks: {
													description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
											description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
												peers: {
													description: "Peers represents the peers spec"
													nullable:    true
													properties: secretNames: {
														description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
														items: type: "string"
														type: "array"
													}
													type: "object"
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
															path: {
																description: "Path is the path to snapshot, only valid for CephFS"
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
										name: {
											description: "Name of the pool"
											type:        "string"
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
												hybridStorage: {
													description: "HybridStorage represents hybrid storage tier settings"
													nullable:    true
													properties: {
														primaryDeviceClass: {
															description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
															minLength:   1
															type:        "string"
														}
														secondaryDeviceClass: {
															description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
															minLength:   1
															type:        "string"
														}
													}
													required: [
														"primaryDeviceClass",
														"secondaryDeviceClass",
													]
													type: "object"
												}
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
													description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
													minimum:     0
													type:        "integer"
												}
												subFailureDomain: {
													description: "SubFailureDomain the name of the sub-failure domain"
													type:        "string"
												}
												targetSizeRatio: {
													description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
													type:        "number"
												}
											}
											required: ["size"]
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
										description: "DEPRECATED: use Parameters instead, e.g."
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
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
											peers: {
												description: "Peers represents the peers spec"
												nullable:    true
												properties: secretNames: {
													description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
													items: type: "string"
													type: "array"
												}
												type: "object"
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
														path: {
															description: "Path is the path to snapshot, only valid for CephFS"
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
											hybridStorage: {
												description: "HybridStorage represents hybrid storage tier settings"
												nullable:    true
												properties: {
													primaryDeviceClass: {
														description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
														minLength:   1
														type:        "string"
													}
													secondaryDeviceClass: {
														description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
														minLength:   1
														type:        "string"
													}
												}
												required: [
													"primaryDeviceClass",
													"secondaryDeviceClass",
												]
												type: "object"
											}
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
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
												type:        "number"
											}
										}
										required: ["size"]
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
										description: "The number of metadata servers that are active."
										format:      "int32"
										maximum:     50
										minimum:     1
										type:        "integer"
									}
									activeStandby: {
										description: "Whether each active MDS instance will have an active standby with a warm metadata cache for faster f"
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
									livenessProbe: {
										description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive "
												properties: {
													exec: {
														description: "Exec specifies the action to take."
														properties: command: {
															description: "Command is the command line to execute inside the container, the working directory for the command  "
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													failureThreshold: {
														description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																type:        "string"
															}
														}
														required: ["port"]
														type: "object"
													}
													httpGet: {
														description: "HTTPGet specifies the http request to perform."
														properties: {
															host: {
																description: "Host name to connect to, defaults to the pod IP."
																type:        "string"
															}
															httpHeaders: {
																description: "Custom headers to set in the request. HTTP allows repeated headers."
																items: {
																	description: "HTTPHeader describes a custom header to be used in HTTP probes"
																	properties: {
																		name: {
																			description: "The header field name."
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
																description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
														description: "Number of seconds after the container has started before liveness probes are initiated."
														format:      "int32"
														type:        "integer"
													}
													periodSeconds: {
														description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
													successThreshold: {
														description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																"x-kubernetes-int-or-string": true
															}
														}
														required: ["port"]
														type: "object"
													}
													terminationGracePeriodSeconds: {
														description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
														format:      "int64"
														type:        "integer"
													}
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									placement: {
										description: "The affinity to place the mds pods (default is to place on all available node) with a daemonset"
										nullable:    true
										properties: {
											nodeAffinity: {
												description: "NodeAffinity is a group of node affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
															properties: {
																preference: {
																	description: "A node selector term, associated with the corresponding weight."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														properties: nodeSelectorTerms: {
															description: "Required. A list of node selector terms. The terms are ORed."
															items: {
																description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
																properties: {
																	matchExpressions: {
																		description: "A list of node selector requirements by node's labels."
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
												items: {
													description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
													properties: {
														effect: {
															description: "Effect indicates the taint effect to match. Empty means match all taint effects."
															type:        "string"
														}
														key: {
															description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
															type:        "string"
														}
														operator: {
															description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
															type:        "string"
														}
														tolerationSeconds: {
															description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
															format:      "int64"
															type:        "integer"
														}
														value: {
															description: "Value is the taint value the toleration matches to."
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
															description: "LabelSelector is used to find matching pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														maxSkew: {
															description: "MaxSkew describes the degree to which pods may be unevenly distributed."
															format:      "int32"
															type:        "integer"
														}
														minDomains: {
															description: "MinDomains indicates a minimum number of eligible domains."
															format:      "int32"
															type:        "integer"
														}
														nodeAffinityPolicy: {
															description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
															type:        "string"
														}
														nodeTaintsPolicy: {
															description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
															type:        "string"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
											claims: {
												description: "Claims lists the names of resources, defined in spec."
												items: {
													description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
													properties: name: {
														description: "Name must match the name of one entry in pod.spec."
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
												description: "Requests describes the minimum amount of compute resources required."
												type:        "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									startupProbe: {
										description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive "
												properties: {
													exec: {
														description: "Exec specifies the action to take."
														properties: command: {
															description: "Command is the command line to execute inside the container, the working directory for the command  "
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													failureThreshold: {
														description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																type:        "string"
															}
														}
														required: ["port"]
														type: "object"
													}
													httpGet: {
														description: "HTTPGet specifies the http request to perform."
														properties: {
															host: {
																description: "Host name to connect to, defaults to the pod IP."
																type:        "string"
															}
															httpHeaders: {
																description: "Custom headers to set in the request. HTTP allows repeated headers."
																items: {
																	description: "HTTPHeader describes a custom header to be used in HTTP probes"
																	properties: {
																		name: {
																			description: "The header field name."
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
																description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
														description: "Number of seconds after the container has started before liveness probes are initiated."
														format:      "int32"
														type:        "integer"
													}
													periodSeconds: {
														description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
													successThreshold: {
														description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																"x-kubernetes-int-or-string": true
															}
														}
														required: ["port"]
														type: "object"
													}
													terminationGracePeriodSeconds: {
														description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
														format:      "int64"
														type:        "integer"
													}
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
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
								required: ["activeCount"]
								type: "object"
							}
							mirroring: {
								description: "The mirroring settings"
								nullable:    true
								properties: {
									enabled: {
										description: "Enabled whether this filesystem is mirrored or not"
										type:        "boolean"
									}
									peers: {
										description: "Peers represents the peers spec"
										nullable:    true
										properties: secretNames: {
											description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
											items: type: "string"
											type: "array"
										}
										type: "object"
									}
									snapshotRetention: {
										description: "Retention is the retention policy for a snapshot schedule One path has exactly one retention policy."
										items: {
											description: "SnapshotScheduleRetentionSpec is a retention policy"
											properties: {
												duration: {
													description: "Duration represents the retention duration for a snapshot"
													type:        "string"
												}
												path: {
													description: "Path is the path to snapshot"
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									snapshotSchedules: {
										description: "SnapshotSchedules is the scheduling of snapshot for mirrored filesystems"
										items: {
											description: "SnapshotScheduleSpec represents the snapshot scheduling settings of a mirrored pool"
											properties: {
												interval: {
													description: "Interval represent the periodicity of the snapshot."
													type:        "string"
												}
												path: {
													description: "Path is the path to snapshot, only valid for CephFS"
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
							preserveFilesystemOnDelete: {
								description: "Preserve the fs in the cluster on CephFilesystem CR deletion."
								type:        "boolean"
							}
							preservePoolsOnDelete: {
								description: "Preserve pools on filesystem deletion"
								type:        "boolean"
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
						required: [
							"dataPools",
							"metadataPool",
							"metadataServer",
						]
						type: "object"
					}
					status: {
						description: "CephFilesystemStatus represents the status of a Ceph Filesystem"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							info: {
								additionalProperties: type: "string"
								description: "Use only info and put mirroringStatus in it?"
								nullable:    true
								type:        "object"
							}
							mirroringStatus: {
								description: "MirroringStatus is the filesystem mirroring status"
								properties: {
									daemonsStatus: {
										description: "PoolMirroringStatus is the mirroring status of a filesystem"
										items: {
											description: "FilesystemMirrorInfoSpec is the filesystem mirror status of a given filesystem"
											properties: {
												daemon_id: {
													description: "DaemonID is the cephfs-mirror name"
													type:        "integer"
												}
												filesystems: {
													description: "Filesystems is the list of filesystems managed by a given cephfs-mirror daemon"
													items: {
														description: "FilesystemsSpec is spec for the mirrored filesystem"
														properties: {
															directory_count: {
																description: "DirectoryCount is the number of directories in the filesystem"
																type:        "integer"
															}
															filesystem_id: {
																description: "FilesystemID is the filesystem identifier"
																type:        "integer"
															}
															name: {
																description: "Name is name of the filesystem"
																type:        "string"
															}
															peers: {
																description: "Peers represents the mirroring peers"
																items: {
																	description: "FilesystemMirrorInfoPeerSpec is the specification of a filesystem peer mirror"
																	properties: {
																		remote: {
																			description: "Remote are the remote cluster information"
																			properties: {
																				client_name: {
																					description: "ClientName is cephx name"
																					type:        "string"
																				}
																				cluster_name: {
																					description: "ClusterName is the name of the cluster"
																					type:        "string"
																				}
																				fs_name: {
																					description: "FsName is the filesystem name"
																					type:        "string"
																				}
																			}
																			type: "object"
																		}
																		stats: {
																			description: "Stats are the stat a peer mirror"
																			properties: {
																				failure_count: {
																					description: "FailureCount is the number of mirroring failure"
																					type:        "integer"
																				}
																				recovery_count: {
																					description: "RecoveryCount is the number of recovery attempted after failures"
																					type:        "integer"
																				}
																			}
																			type: "object"
																		}
																		uuid: {
																			description: "UUID is the peer unique identifier"
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
													type: "array"
												}
											}
											type: "object"
										}
										nullable: true
										type:     "array"
									}
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
								}
								type: "object"
							}
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
							}
							phase: {
								description: "ConditionType represent a resource's status"
								type:        "string"
							}
							snapshotScheduleStatus: {
								description: "FilesystemSnapshotScheduleStatusSpec is the status of the snapshot schedule"
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
											description: "FilesystemSnapshotSchedulesSpec is the list of snapshot scheduled for images in a pool"
											properties: {
												fs: {
													description: "Fs is the name of the Ceph Filesystem"
													type:        "string"
												}
												path: {
													description: "Path is the path on the filesystem"
													type:        "string"
												}
												rel_path: type: "string"
												retention: {
													description: "FilesystemSnapshotScheduleStatusRetention is the retention specification for a filesystem snapshot s"
													properties: {
														active: {
															description: "Active is whether the scheduled is active or not"
															type:        "boolean"
														}
														created: {
															description: "Created is when the snapshot schedule was created"
															type:        "string"
														}
														created_count: {
															description: "CreatedCount is total amount of snapshots"
															type:        "integer"
														}
														first: {
															description: "First is when the first snapshot schedule was taken"
															type:        "string"
														}
														last: {
															description: "Last is when the last snapshot schedule was taken"
															type:        "string"
														}
														last_pruned: {
															description: "LastPruned is when the last snapshot schedule was pruned"
															type:        "string"
														}
														pruned_count: {
															description: "PrunedCount is total amount of pruned snapshots"
															type:        "integer"
														}
														start: {
															description: "Start is when the snapshot schedule starts"
															type:        "string"
														}
													}
													type: "object"
												}
												schedule: type: "string"
												subvol: {
													description: "Subvol is the name of the sub volume"
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
}, {
	metadata: name: "cephfilesystemsubvolumegroups.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephFilesystemSubVolumeGroup"
			listKind: "CephFilesystemSubVolumeGroupList"
			plural:   "cephfilesystemsubvolumegroups"
			singular: "cephfilesystemsubvolumegroup"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephFilesystemSubVolumeGroup represents a Ceph Filesystem SubVolumeGroup"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec represents the specification of a Ceph Filesystem SubVolumeGroup"
						properties: {
							filesystemName: {
								description: "FilesystemName is the name of Ceph Filesystem SubVolumeGroup volume name."
								type:        "string"
								"x-kubernetes-validations": [{
									message: "filesystemName is immutable"
									rule:    "self == oldSelf"
								}]
							}
							name: {
								description: "The name of the subvolume group. If not set, the default is the name of the subvolumeGroup CR."
								type:        "string"
								"x-kubernetes-validations": [{
									message: "name is immutable"
									rule:    "self == oldSelf"
								}]
							}
							pinning: {
								description: "Pinning configuration of CephFilesystemSubVolumeGroup, reference https://docs.ceph."
								properties: {
									distributed: {
										maximum:  1
										minimum:  0
										nullable: true
										type:     "integer"
									}
									export: {
										maximum:  256
										minimum:  -1
										nullable: true
										type:     "integer"
									}
									random: {
										maximum:  1
										minimum:  0
										nullable: true
										type:     "number"
									}
								}
								type: "object"
								"x-kubernetes-validations": [{
									message: "only one pinning type should be set"
									rule:    "(has(self.export) && !has(self.distributed) && !has(self.random)) || (!has(self.export) && has(self.distributed) && !has(self.random)) || (!has(self.export) && !has(self.distributed) && has(self.random)) || (!has(self.export) && !has(self.distributed) && !has(self.random))"
								}]
							}
						}
						required: ["filesystemName"]
						type: "object"
					}
					status: {
						description: "Status represents the status of a CephFilesystem SubvolumeGroup"
						properties: {
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
							}
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephnfses.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephNFS"
			listKind: "CephNFSList"
			plural:   "cephnfses"
			shortNames: ["nfs"]
			singular: "cephnfs"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephNFS represents a Ceph NFS"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "NFSGaneshaSpec represents the spec of an nfs ganesha server"
						properties: {
							rados: {
								description: "RADOS is the Ganesha RADOS specification"
								nullable:    true
								properties: {
									namespace: {
										description: "The namespace inside the Ceph pool (set by 'pool') where shared NFS-Ganesha config is stored."
										type:        "string"
									}
									pool: {
										description: "The Ceph pool used store the shared configuration for NFS-Ganesha daemons."
										type:        "string"
									}
								}
								type: "object"
							}
							security: {
								description: "Security allows specifying security configurations for the NFS cluster"
								nullable:    true
								properties: {
									kerberos: {
										description: "Kerberos configures NFS-Ganesha to secure NFS client connections with Kerberos."
										nullable:    true
										properties: {
											configFiles: {
												description: "ConfigFiles defines where the Kerberos configuration should be sourced from."
												properties: volumeSource: {
													description: "VolumeSource accepts a pared down version of the standard Kubernetes VolumeSource for Kerberos confi"
													properties: {
														configMap: {
															description: "configMap represents a configMap that should populate this volume"
															properties: {
																defaultMode: {
																	description: "defaultMode is optional: mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																	description: "Name of the referent. More info: https://kubernetes."
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
														emptyDir: {
															description: "emptyDir represents a temporary directory that shares a pod's lifetime."
															properties: {
																medium: {
																	description: "medium represents what type of storage medium should back this directory."
																	type:        "string"
																}
																sizeLimit: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "sizeLimit is the total amount of local storage required for this EmptyDir volume."
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
															}
															type: "object"
														}
														hostPath: {
															description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to"
															properties: {
																path: {
																	description: "path of the directory on the host."
																	type:        "string"
																}
																type: {
																	description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes."
																	type:        "string"
																}
															}
															required: ["path"]
															type: "object"
														}
														persistentVolumeClaim: {
															description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same name"
															properties: {
																claimName: {
																	description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume."
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
														projected: {
															description: "projected items for all in one resources secrets, configmaps, and downward API"
															properties: {
																defaultMode: {
																	description: "defaultMode are the mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																sources: {
																	description: "sources is the list of volume projections"
																	items: {
																		description: "Projection that may be projected along with other supported volume types"
																		properties: {
																			clusterTrustBundle: {
																				description: "ClusterTrustBundle allows a pod to access the `.spec."
																				properties: {
																					labelSelector: {
																						description: "Select all ClusterTrustBundles that match this label selector."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					name: {
																						description: "Select a single ClusterTrustBundle by object name."
																						type:        "string"
																					}
																					optional: {
																						description: "If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available."
																						type:        "boolean"
																					}
																					path: {
																						description: "Relative path from the volume root to write the bundle."
																						type:        "string"
																					}
																					signerName: {
																						description: "Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name."
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
																						description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																						items: {
																							description: "Maps a string key to a path within a volume."
																							properties: {
																								key: {
																									description: "key is the key to project."
																									type:        "string"
																								}
																								mode: {
																									description: "mode is Optional: mode bits used to set permissions on this file."
																									format:      "int32"
																									type:        "integer"
																								}
																								path: {
																									description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																						description: "Name of the referent. More info: https://kubernetes."
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
																								description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 07"
																								format:      "int32"
																								type:        "integer"
																							}
																							path: {
																								description: "Required: Path is  the relative path name of the file to be created."
																								type:        "string"
																							}
																							resourceFieldRef: {
																								description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits."
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
																						description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																						items: {
																							description: "Maps a string key to a path within a volume."
																							properties: {
																								key: {
																									description: "key is the key to project."
																									type:        "string"
																								}
																								mode: {
																									description: "mode is Optional: mode bits used to set permissions on this file."
																									format:      "int32"
																									type:        "integer"
																								}
																								path: {
																									description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																						description: "Name of the referent. More info: https://kubernetes."
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
																						description: "audience is the intended audience of the token."
																						type:        "string"
																					}
																					expirationSeconds: {
																						description: "expirationSeconds is the requested duration of validity of the service account token."
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
														secret: {
															description: "secret represents a secret that should populate this volume. More info: https://kubernetes."
															properties: {
																defaultMode: {
																	description: "defaultMode is Optional: mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																items: {
																	description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																	description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes."
																	type:        "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												type: "object"
											}
											domainName: {
												description: "DomainName should be set to the Kerberos Realm."
												type:        "string"
											}
											keytabFile: {
												description: "KeytabFile defines where the Kerberos keytab should be sourced from."
												properties: volumeSource: {
													description: "VolumeSource accepts a pared down version of the standard Kubernetes VolumeSource for the Kerberos k"
													properties: {
														configMap: {
															description: "configMap represents a configMap that should populate this volume"
															properties: {
																defaultMode: {
																	description: "defaultMode is optional: mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																items: {
																	description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																	description: "Name of the referent. More info: https://kubernetes."
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
														emptyDir: {
															description: "emptyDir represents a temporary directory that shares a pod's lifetime."
															properties: {
																medium: {
																	description: "medium represents what type of storage medium should back this directory."
																	type:        "string"
																}
																sizeLimit: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "sizeLimit is the total amount of local storage required for this EmptyDir volume."
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
															}
															type: "object"
														}
														hostPath: {
															description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to"
															properties: {
																path: {
																	description: "path of the directory on the host."
																	type:        "string"
																}
																type: {
																	description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes."
																	type:        "string"
																}
															}
															required: ["path"]
															type: "object"
														}
														persistentVolumeClaim: {
															description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same name"
															properties: {
																claimName: {
																	description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume."
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
														projected: {
															description: "projected items for all in one resources secrets, configmaps, and downward API"
															properties: {
																defaultMode: {
																	description: "defaultMode are the mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																sources: {
																	description: "sources is the list of volume projections"
																	items: {
																		description: "Projection that may be projected along with other supported volume types"
																		properties: {
																			clusterTrustBundle: {
																				description: "ClusterTrustBundle allows a pod to access the `.spec."
																				properties: {
																					labelSelector: {
																						description: "Select all ClusterTrustBundles that match this label selector."
																						properties: {
																							matchExpressions: {
																								description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																								items: {
																									description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																									properties: {
																										key: {
																											description: "key is the label key that the selector applies to."
																											type:        "string"
																										}
																										operator: {
																											description: "operator represents a key's relationship to a set of values."
																											type:        "string"
																										}
																										values: {
																											description: "values is an array of string values."
																											items: type: "string"
																											type: "array"
																										}
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
																								description: "matchLabels is a map of {key,value} pairs."
																								type:        "object"
																							}
																						}
																						type:                    "object"
																						"x-kubernetes-map-type": "atomic"
																					}
																					name: {
																						description: "Select a single ClusterTrustBundle by object name."
																						type:        "string"
																					}
																					optional: {
																						description: "If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available."
																						type:        "boolean"
																					}
																					path: {
																						description: "Relative path from the volume root to write the bundle."
																						type:        "string"
																					}
																					signerName: {
																						description: "Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name."
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
																						description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																						items: {
																							description: "Maps a string key to a path within a volume."
																							properties: {
																								key: {
																									description: "key is the key to project."
																									type:        "string"
																								}
																								mode: {
																									description: "mode is Optional: mode bits used to set permissions on this file."
																									format:      "int32"
																									type:        "integer"
																								}
																								path: {
																									description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																						description: "Name of the referent. More info: https://kubernetes."
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
																								description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 07"
																								format:      "int32"
																								type:        "integer"
																							}
																							path: {
																								description: "Required: Path is  the relative path name of the file to be created."
																								type:        "string"
																							}
																							resourceFieldRef: {
																								description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits."
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
																						description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																						items: {
																							description: "Maps a string key to a path within a volume."
																							properties: {
																								key: {
																									description: "key is the key to project."
																									type:        "string"
																								}
																								mode: {
																									description: "mode is Optional: mode bits used to set permissions on this file."
																									format:      "int32"
																									type:        "integer"
																								}
																								path: {
																									description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																						description: "Name of the referent. More info: https://kubernetes."
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
																						description: "audience is the intended audience of the token."
																						type:        "string"
																					}
																					expirationSeconds: {
																						description: "expirationSeconds is the requested duration of validity of the service account token."
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
														secret: {
															description: "secret represents a secret that should populate this volume. More info: https://kubernetes."
															properties: {
																defaultMode: {
																	description: "defaultMode is Optional: mode bits used to set permissions on created files by default."
																	format:      "int32"
																	type:        "integer"
																}
																items: {
																	description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																	items: {
																		description: "Maps a string key to a path within a volume."
																		properties: {
																			key: {
																				description: "key is the key to project."
																				type:        "string"
																			}
																			mode: {
																				description: "mode is Optional: mode bits used to set permissions on this file."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																	description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes."
																	type:        "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												type: "object"
											}
											principalName: {
												default:     "nfs"
												description: "PrincipalName corresponds directly to NFS-Ganesha's NFS_KRB5:PrincipalName config."
												type:        "string"
											}
										}
										type: "object"
									}
									sssd: {
										description: "SSSD enables integration with System Security Services Daemon (SSSD)."
										nullable:    true
										properties: sidecar: {
											description: "Sidecar tells Rook to run SSSD in a sidecar alongside the NFS-Ganesha server in each NFS pod."
											properties: {
												additionalFiles: {
													description: "AdditionalFiles defines any number of additional files that should be mounted into the SSSD sidecar."
													items: {
														description: "SSSDSidecarAdditionalFile represents the source from where additional files for the the SSSD configu"
														properties: {
															subPath: {
																description: "SubPath defines the sub-path in `/etc/sssd/rook-additional/` where the additional file(s) will be pl"
																minLength:   1
																pattern:     "^[^:]+$"
																type:        "string"
															}
															volumeSource: {
																description: "VolumeSource accepts a pared down version of the standard Kubernetes VolumeSource for the additional"
																properties: {
																	configMap: {
																		description: "configMap represents a configMap that should populate this volume"
																		properties: {
																			defaultMode: {
																				description: "defaultMode is optional: mode bits used to set permissions on created files by default."
																				format:      "int32"
																				type:        "integer"
																			}
																			items: {
																				description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																				items: {
																					description: "Maps a string key to a path within a volume."
																					properties: {
																						key: {
																							description: "key is the key to project."
																							type:        "string"
																						}
																						mode: {
																							description: "mode is Optional: mode bits used to set permissions on this file."
																							format:      "int32"
																							type:        "integer"
																						}
																						path: {
																							description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																				description: "Name of the referent. More info: https://kubernetes."
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
																	emptyDir: {
																		description: "emptyDir represents a temporary directory that shares a pod's lifetime."
																		properties: {
																			medium: {
																				description: "medium represents what type of storage medium should back this directory."
																				type:        "string"
																			}
																			sizeLimit: {
																				anyOf: [{
																					type: "integer"
																				}, {
																					type: "string"
																				}]
																				description:                  "sizeLimit is the total amount of local storage required for this EmptyDir volume."
																				pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																				"x-kubernetes-int-or-string": true
																			}
																		}
																		type: "object"
																	}
																	hostPath: {
																		description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to"
																		properties: {
																			path: {
																				description: "path of the directory on the host."
																				type:        "string"
																			}
																			type: {
																				description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes."
																				type:        "string"
																			}
																		}
																		required: ["path"]
																		type: "object"
																	}
																	persistentVolumeClaim: {
																		description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same name"
																		properties: {
																			claimName: {
																				description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume."
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
																	projected: {
																		description: "projected items for all in one resources secrets, configmaps, and downward API"
																		properties: {
																			defaultMode: {
																				description: "defaultMode are the mode bits used to set permissions on created files by default."
																				format:      "int32"
																				type:        "integer"
																			}
																			sources: {
																				description: "sources is the list of volume projections"
																				items: {
																					description: "Projection that may be projected along with other supported volume types"
																					properties: {
																						clusterTrustBundle: {
																							description: "ClusterTrustBundle allows a pod to access the `.spec."
																							properties: {
																								labelSelector: {
																									description: "Select all ClusterTrustBundles that match this label selector."
																									properties: {
																										matchExpressions: {
																											description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																											items: {
																												description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																												properties: {
																													key: {
																														description: "key is the label key that the selector applies to."
																														type:        "string"
																													}
																													operator: {
																														description: "operator represents a key's relationship to a set of values."
																														type:        "string"
																													}
																													values: {
																														description: "values is an array of string values."
																														items: type: "string"
																														type: "array"
																													}
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
																											description: "matchLabels is a map of {key,value} pairs."
																											type:        "object"
																										}
																									}
																									type:                    "object"
																									"x-kubernetes-map-type": "atomic"
																								}
																								name: {
																									description: "Select a single ClusterTrustBundle by object name."
																									type:        "string"
																								}
																								optional: {
																									description: "If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available."
																									type:        "boolean"
																								}
																								path: {
																									description: "Relative path from the volume root to write the bundle."
																									type:        "string"
																								}
																								signerName: {
																									description: "Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name."
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
																									description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																									items: {
																										description: "Maps a string key to a path within a volume."
																										properties: {
																											key: {
																												description: "key is the key to project."
																												type:        "string"
																											}
																											mode: {
																												description: "mode is Optional: mode bits used to set permissions on this file."
																												format:      "int32"
																												type:        "integer"
																											}
																											path: {
																												description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																									description: "Name of the referent. More info: https://kubernetes."
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
																											description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 07"
																											format:      "int32"
																											type:        "integer"
																										}
																										path: {
																											description: "Required: Path is  the relative path name of the file to be created."
																											type:        "string"
																										}
																										resourceFieldRef: {
																											description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits."
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
																									description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																									items: {
																										description: "Maps a string key to a path within a volume."
																										properties: {
																											key: {
																												description: "key is the key to project."
																												type:        "string"
																											}
																											mode: {
																												description: "mode is Optional: mode bits used to set permissions on this file."
																												format:      "int32"
																												type:        "integer"
																											}
																											path: {
																												description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																									description: "Name of the referent. More info: https://kubernetes."
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
																									description: "audience is the intended audience of the token."
																									type:        "string"
																								}
																								expirationSeconds: {
																									description: "expirationSeconds is the requested duration of validity of the service account token."
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
																	secret: {
																		description: "secret represents a secret that should populate this volume. More info: https://kubernetes."
																		properties: {
																			defaultMode: {
																				description: "defaultMode is Optional: mode bits used to set permissions on created files by default."
																				format:      "int32"
																				type:        "integer"
																			}
																			items: {
																				description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																				items: {
																					description: "Maps a string key to a path within a volume."
																					properties: {
																						key: {
																							description: "key is the key to project."
																							type:        "string"
																						}
																						mode: {
																							description: "mode is Optional: mode bits used to set permissions on this file."
																							format:      "int32"
																							type:        "integer"
																						}
																						path: {
																							description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																				description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes."
																				type:        "string"
																			}
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
														}
														required: [
															"subPath",
															"volumeSource",
														]
														type: "object"
													}
													type: "array"
												}
												debugLevel: {
													description: "DebugLevel sets the debug level for SSSD. If unset or set to 0, Rook does nothing."
													maximum:     10
													minimum:     0
													type:        "integer"
												}
												image: {
													description: "Image defines the container image that should be used for the SSSD sidecar."
													minLength:   1
													type:        "string"
												}
												resources: {
													description: "Resources allow specifying resource requests/limits on the SSSD sidecar container."
													properties: {
														claims: {
															description: "Claims lists the names of resources, defined in spec."
															items: {
																description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
																properties: name: {
																	description: "Name must match the name of one entry in pod.spec."
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
															description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
															description: "Requests describes the minimum amount of compute resources required."
															type:        "object"
														}
													}
													type: "object"
												}
												sssdConfigFile: {
													description: "SSSDConfigFile defines where the SSSD configuration should be sourced from."
													properties: volumeSource: {
														description: "VolumeSource accepts a pared down version of the standard Kubernetes VolumeSource for the SSSD confi"
														properties: {
															configMap: {
																description: "configMap represents a configMap that should populate this volume"
																properties: {
																	defaultMode: {
																		description: "defaultMode is optional: mode bits used to set permissions on created files by default."
																		format:      "int32"
																		type:        "integer"
																	}
																	items: {
																		description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																		description: "Name of the referent. More info: https://kubernetes."
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
															emptyDir: {
																description: "emptyDir represents a temporary directory that shares a pod's lifetime."
																properties: {
																	medium: {
																		description: "medium represents what type of storage medium should back this directory."
																		type:        "string"
																	}
																	sizeLimit: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "sizeLimit is the total amount of local storage required for this EmptyDir volume."
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																}
																type: "object"
															}
															hostPath: {
																description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to"
																properties: {
																	path: {
																		description: "path of the directory on the host."
																		type:        "string"
																	}
																	type: {
																		description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes."
																		type:        "string"
																	}
																}
																required: ["path"]
																type: "object"
															}
															persistentVolumeClaim: {
																description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same name"
																properties: {
																	claimName: {
																		description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume."
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
															projected: {
																description: "projected items for all in one resources secrets, configmaps, and downward API"
																properties: {
																	defaultMode: {
																		description: "defaultMode are the mode bits used to set permissions on created files by default."
																		format:      "int32"
																		type:        "integer"
																	}
																	sources: {
																		description: "sources is the list of volume projections"
																		items: {
																			description: "Projection that may be projected along with other supported volume types"
																			properties: {
																				clusterTrustBundle: {
																					description: "ClusterTrustBundle allows a pod to access the `.spec."
																					properties: {
																						labelSelector: {
																							description: "Select all ClusterTrustBundles that match this label selector."
																							properties: {
																								matchExpressions: {
																									description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																									items: {
																										description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																										properties: {
																											key: {
																												description: "key is the label key that the selector applies to."
																												type:        "string"
																											}
																											operator: {
																												description: "operator represents a key's relationship to a set of values."
																												type:        "string"
																											}
																											values: {
																												description: "values is an array of string values."
																												items: type: "string"
																												type: "array"
																											}
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
																									description: "matchLabels is a map of {key,value} pairs."
																									type:        "object"
																								}
																							}
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
																						}
																						name: {
																							description: "Select a single ClusterTrustBundle by object name."
																							type:        "string"
																						}
																						optional: {
																							description: "If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available."
																							type:        "boolean"
																						}
																						path: {
																							description: "Relative path from the volume root to write the bundle."
																							type:        "string"
																						}
																						signerName: {
																							description: "Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name."
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
																							description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be proj"
																							items: {
																								description: "Maps a string key to a path within a volume."
																								properties: {
																									key: {
																										description: "key is the key to project."
																										type:        "string"
																									}
																									mode: {
																										description: "mode is Optional: mode bits used to set permissions on this file."
																										format:      "int32"
																										type:        "integer"
																									}
																									path: {
																										description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																							description: "Name of the referent. More info: https://kubernetes."
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
																									description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 07"
																									format:      "int32"
																									type:        "integer"
																								}
																								path: {
																									description: "Required: Path is  the relative path name of the file to be created."
																									type:        "string"
																								}
																								resourceFieldRef: {
																									description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits."
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
																							description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																							items: {
																								description: "Maps a string key to a path within a volume."
																								properties: {
																									key: {
																										description: "key is the key to project."
																										type:        "string"
																									}
																									mode: {
																										description: "mode is Optional: mode bits used to set permissions on this file."
																										format:      "int32"
																										type:        "integer"
																									}
																									path: {
																										description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																							description: "Name of the referent. More info: https://kubernetes."
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
																							description: "audience is the intended audience of the token."
																							type:        "string"
																						}
																						expirationSeconds: {
																							description: "expirationSeconds is the requested duration of validity of the service account token."
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
															secret: {
																description: "secret represents a secret that should populate this volume. More info: https://kubernetes."
																properties: {
																	defaultMode: {
																		description: "defaultMode is Optional: mode bits used to set permissions on created files by default."
																		format:      "int32"
																		type:        "integer"
																	}
																	items: {
																		description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be project"
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "key is the key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "mode is Optional: mode bits used to set permissions on this file."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "path is the relative path of the file to map the key to. May not be an absolute path."
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
																		description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "object"
												}
											}
											required: ["image"]
											type: "object"
										}
										type: "object"
									}
								}
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
									hostNetwork: {
										description: "Whether host networking is enabled for the Ganesha server."
										nullable:    true
										type:        "boolean"
									}
									labels: {
										additionalProperties: type: "string"
										description:                            "The labels-related configuration to add/set on each Pod related object."
										nullable:                               true
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									livenessProbe: {
										description: "A liveness-probe to verify that Ganesha server has valid run-time state. If LivenessProbe."
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive "
												properties: {
													exec: {
														description: "Exec specifies the action to take."
														properties: command: {
															description: "Command is the command line to execute inside the container, the working directory for the command  "
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													failureThreshold: {
														description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																type:        "string"
															}
														}
														required: ["port"]
														type: "object"
													}
													httpGet: {
														description: "HTTPGet specifies the http request to perform."
														properties: {
															host: {
																description: "Host name to connect to, defaults to the pod IP."
																type:        "string"
															}
															httpHeaders: {
																description: "Custom headers to set in the request. HTTP allows repeated headers."
																items: {
																	description: "HTTPHeader describes a custom header to be used in HTTP probes"
																	properties: {
																		name: {
																			description: "The header field name."
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
																description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
														description: "Number of seconds after the container has started before liveness probes are initiated."
														format:      "int32"
														type:        "integer"
													}
													periodSeconds: {
														description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
													successThreshold: {
														description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																"x-kubernetes-int-or-string": true
															}
														}
														required: ["port"]
														type: "object"
													}
													terminationGracePeriodSeconds: {
														description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
														format:      "int64"
														type:        "integer"
													}
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
												}
												type: "object"
											}
										}
										type: "object"
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
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
															properties: {
																preference: {
																	description: "A node selector term, associated with the corresponding weight."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														properties: nodeSelectorTerms: {
															description: "Required. A list of node selector terms. The terms are ORed."
															items: {
																description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
																properties: {
																	matchExpressions: {
																		description: "A list of node selector requirements by node's labels."
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
												items: {
													description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
													properties: {
														effect: {
															description: "Effect indicates the taint effect to match. Empty means match all taint effects."
															type:        "string"
														}
														key: {
															description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
															type:        "string"
														}
														operator: {
															description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
															type:        "string"
														}
														tolerationSeconds: {
															description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
															format:      "int64"
															type:        "integer"
														}
														value: {
															description: "Value is the taint value the toleration matches to."
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
															description: "LabelSelector is used to find matching pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														maxSkew: {
															description: "MaxSkew describes the degree to which pods may be unevenly distributed."
															format:      "int32"
															type:        "integer"
														}
														minDomains: {
															description: "MinDomains indicates a minimum number of eligible domains."
															format:      "int32"
															type:        "integer"
														}
														nodeAffinityPolicy: {
															description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
															type:        "string"
														}
														nodeTaintsPolicy: {
															description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
															type:        "string"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
											claims: {
												description: "Claims lists the names of resources, defined in spec."
												items: {
													description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
													properties: name: {
														description: "Name must match the name of one entry in pod.spec."
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
												description: "Requests describes the minimum amount of compute resources required."
												type:        "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
								}
								required: ["active"]
								type: "object"
							}
						}
						required: ["server"]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephobjectrealms.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectRealm"
			listKind: "CephObjectRealmList"
			plural:   "cephobjectrealms"
			singular: "cephobjectrealm"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectRealm represents a Ceph Object Store Gateway Realm"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "ObjectRealmSpec represent the spec of an ObjectRealm"
						nullable:    true
						properties: pull: {
							description: "PullSpec represents the pulling specification of a Ceph Object Storage Gateway Realm"
							properties: endpoint: {
								pattern: "^https*://"
								type:    "string"
							}
							type: "object"
						}
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
							}
							phase: type: "string"
						}
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: ["metadata"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: name: "cephobjectstores.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectStore"
			listKind: "CephObjectStoreList"
			plural:   "cephobjectstores"
			singular: "cephobjectstore"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectStore represents a Ceph Object Store Gateway"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "ObjectStoreSpec represent the spec of a pool"
						properties: {
							allowUsersInNamespaces: {
								description: "The list of allowed namespaces in addition to the object store namespace where ceph object store use"
								items: type: "string"
								type: "array"
							}
							dataPool: {
								description: "The data pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										description: "DEPRECATED: use Parameters instead, e.g."
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
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
											peers: {
												description: "Peers represents the peers spec"
												nullable:    true
												properties: secretNames: {
													description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
													items: type: "string"
													type: "array"
												}
												type: "object"
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
														path: {
															description: "Path is the path to snapshot, only valid for CephFS"
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
											hybridStorage: {
												description: "HybridStorage represents hybrid storage tier settings"
												nullable:    true
												properties: {
													primaryDeviceClass: {
														description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
														minLength:   1
														type:        "string"
													}
													secondaryDeviceClass: {
														description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
														minLength:   1
														type:        "string"
													}
												}
												required: [
													"primaryDeviceClass",
													"secondaryDeviceClass",
												]
												type: "object"
											}
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
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
												type:        "number"
											}
										}
										required: ["size"]
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
									caBundleRef: {
										description: "The name of the secret that stores custom ca-bundle with root and intermediate certificates."
										nullable:    true
										type:        "string"
									}
									dashboardEnabled: {
										description:                            "Whether rgw dashboard is enabled for the rgw daemon. If not set, the rgw dashboard will be enabled."
										nullable:                               true
										type:                                   "boolean"
										"x-kubernetes-preserve-unknown-fields": true
									}
									disableMultisiteSyncTraffic: {
										description: "DisableMultisiteSyncTraffic, when true, prevents this object store's gateways from transmitting mult"
										type:        "boolean"
									}
									externalRgwEndpoints: {
										description: "ExternalRgwEndpoints points to external RGW endpoint(s)."
										items: {
											description: "EndpointAddress is a tuple that describes a single IP address or host name."
											properties: {
												hostname: {
													description: "The DNS-addressable Hostname of this endpoint."
													type:        "string"
												}
												ip: {
													description: "The IP of this endpoint."
													type:        "string"
												}
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										nullable: true
										type:     "array"
									}
									hostNetwork: {
										description:                            "Whether host networking is enabled for the rgw daemon."
										nullable:                               true
										type:                                   "boolean"
										"x-kubernetes-preserve-unknown-fields": true
									}
									instances: {
										description: "The number of pods in the rgw replicaset."
										format:      "int32"
										nullable:    true
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
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
															properties: {
																preference: {
																	description: "A node selector term, associated with the corresponding weight."
																	properties: {
																		matchExpressions: {
																			description: "A list of node selector requirements by node's labels."
																			items: {
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
																				description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																				properties: {
																					key: {
																						description: "The label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "Represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																						items: type: "string"
																						type: "array"
																					}
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														properties: nodeSelectorTerms: {
															description: "Required. A list of node selector terms. The terms are ORed."
															items: {
																description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
																properties: {
																	matchExpressions: {
																		description: "A list of node selector requirements by node's labels."
																		items: {
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
																			description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																			properties: {
																				key: {
																					description: "The label key that the selector applies to."
																					type:        "string"
																				}
																				operator: {
																					description: "Represents a key's relationship to a set of values."
																					type:        "string"
																				}
																				values: {
																					description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																					items: type: "string"
																					type: "array"
																				}
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
												description: "PodAffinity is a group of inter pod affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
												properties: {
													preferredDuringSchedulingIgnoredDuringExecution: {
														description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
														items: {
															description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		matchLabelKeys: {
																			description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		mismatchLabelKeys: {
																			description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																			items: type: "string"
																			type:                     "array"
																			"x-kubernetes-list-type": "atomic"
																		}
																		namespaceSelector: {
																			description: "A label query over the set of namespaces that the term applies to."
																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."
																								type:        "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values."
																								type:        "string"
																							}
																							values: {
																								description: "values is an array of string values."
																								items: type: "string"
																								type: "array"
																							}
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
																					description: "matchLabels is a map of {key,value} pairs."
																					type:        "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		namespaces: {
																			description: "namespaces specifies a static list of namespace names that the term applies to."
																			items: type: "string"
																			type: "array"
																		}
																		topologyKey: {
																			description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
														description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
														items: {
															description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
											tolerations: {
												description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
												items: {
													description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
													properties: {
														effect: {
															description: "Effect indicates the taint effect to match. Empty means match all taint effects."
															type:        "string"
														}
														key: {
															description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
															type:        "string"
														}
														operator: {
															description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
															type:        "string"
														}
														tolerationSeconds: {
															description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
															format:      "int64"
															type:        "integer"
														}
														value: {
															description: "Value is the taint value the toleration matches to."
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
															description: "LabelSelector is used to find matching pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														maxSkew: {
															description: "MaxSkew describes the degree to which pods may be unevenly distributed."
															format:      "int32"
															type:        "integer"
														}
														minDomains: {
															description: "MinDomains indicates a minimum number of eligible domains."
															format:      "int32"
															type:        "integer"
														}
														nodeAffinityPolicy: {
															description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
															type:        "string"
														}
														nodeTaintsPolicy: {
															description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
															type:        "string"
														}
														topologyKey: {
															description: "TopologyKey is the key of node labels."
															type:        "string"
														}
														whenUnsatisfiable: {
															description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
											claims: {
												description: "Claims lists the names of resources, defined in spec."
												items: {
													description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
													properties: name: {
														description: "Name must match the name of one entry in pod.spec."
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
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
												description: "Requests describes the minimum amount of compute resources required."
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
								type: "object"
							}
							healthCheck: {
								description: "The RGW health probes"
								nullable:    true
								properties: {
									readinessProbe: {
										description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive "
												properties: {
													exec: {
														description: "Exec specifies the action to take."
														properties: command: {
															description: "Command is the command line to execute inside the container, the working directory for the command  "
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													failureThreshold: {
														description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																type:        "string"
															}
														}
														required: ["port"]
														type: "object"
													}
													httpGet: {
														description: "HTTPGet specifies the http request to perform."
														properties: {
															host: {
																description: "Host name to connect to, defaults to the pod IP."
																type:        "string"
															}
															httpHeaders: {
																description: "Custom headers to set in the request. HTTP allows repeated headers."
																items: {
																	description: "HTTPHeader describes a custom header to be used in HTTP probes"
																	properties: {
																		name: {
																			description: "The header field name."
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
																description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
														description: "Number of seconds after the container has started before liveness probes are initiated."
														format:      "int32"
														type:        "integer"
													}
													periodSeconds: {
														description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
													successThreshold: {
														description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																"x-kubernetes-int-or-string": true
															}
														}
														required: ["port"]
														type: "object"
													}
													terminationGracePeriodSeconds: {
														description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
														format:      "int64"
														type:        "integer"
													}
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
												}
												type: "object"
											}
										}
										type:                                   "object"
										"x-kubernetes-preserve-unknown-fields": true
									}
									startupProbe: {
										description: "ProbeSpec is a wrapper around Probe so it can be enabled or disabled for a Ceph daemon"
										properties: {
											disabled: {
												description: "Disabled determines whether probe is disable or not"
												type:        "boolean"
											}
											probe: {
												description: "Probe describes a health check to be performed against a container to determine whether it is alive "
												properties: {
													exec: {
														description: "Exec specifies the action to take."
														properties: command: {
															description: "Command is the command line to execute inside the container, the working directory for the command  "
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													failureThreshold: {
														description: "Minimum consecutive failures for the probe to be considered failed after having succeeded."
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
																description: "Service is the name of the service to place in the gRPC HealthCheckRequest (see https://github."
																type:        "string"
															}
														}
														required: ["port"]
														type: "object"
													}
													httpGet: {
														description: "HTTPGet specifies the http request to perform."
														properties: {
															host: {
																description: "Host name to connect to, defaults to the pod IP."
																type:        "string"
															}
															httpHeaders: {
																description: "Custom headers to set in the request. HTTP allows repeated headers."
																items: {
																	description: "HTTPHeader describes a custom header to be used in HTTP probes"
																	properties: {
																		name: {
																			description: "The header field name."
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
																description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535."
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
														description: "Number of seconds after the container has started before liveness probes are initiated."
														format:      "int32"
														type:        "integer"
													}
													periodSeconds: {
														description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
														format:      "int32"
														type:        "integer"
													}
													successThreshold: {
														description: "Minimum consecutive successes for the probe to be considered successful after having failed."
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
																description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535."
																"x-kubernetes-int-or-string": true
															}
														}
														required: ["port"]
														type: "object"
													}
													terminationGracePeriodSeconds: {
														description: "Optional duration in seconds the pod needs to terminate gracefully upon probe failure."
														format:      "int64"
														type:        "integer"
													}
													timeoutSeconds: {
														description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1."
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
										description: "DEPRECATED: use Parameters instead, e.g."
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
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
											peers: {
												description: "Peers represents the peers spec"
												nullable:    true
												properties: secretNames: {
													description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
													items: type: "string"
													type: "array"
												}
												type: "object"
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
														path: {
															description: "Path is the path to snapshot, only valid for CephFS"
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
											hybridStorage: {
												description: "HybridStorage represents hybrid storage tier settings"
												nullable:    true
												properties: {
													primaryDeviceClass: {
														description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
														minLength:   1
														type:        "string"
													}
													secondaryDeviceClass: {
														description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
														minLength:   1
														type:        "string"
													}
												}
												required: [
													"primaryDeviceClass",
													"secondaryDeviceClass",
												]
												type: "object"
											}
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
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
												type:        "number"
											}
										}
										required: ["size"]
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
								properties: {
									keyRotation: {
										description: "KeyRotation defines options for Key Rotation."
										nullable:    true
										properties: {
											enabled: {
												default:     false
												description: "Enabled represents whether the key rotation is enabled."
												type:        "boolean"
											}
											schedule: {
												description: "Schedule represents the cron schedule for key rotation."
												type:        "string"
											}
										}
										type: "object"
									}
									kms: {
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
									s3: {
										description: "The settings for supporting AWS-SSE:S3 with RGW"
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
								required: ["name"]
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "ObjectStoreStatus represents the status of a Ceph Object Store resource"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							endpoints: {
								properties: {
									insecure: {
										items: type: "string"
										nullable: true
										type:     "array"
									}
									secure: {
										items: type: "string"
										nullable: true
										type:     "array"
									}
								}
								type: "object"
							}
							info: {
								additionalProperties: type: "string"
								nullable: true
								type:     "object"
							}
							message: type: "string"
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephobjectstoreusers.ceph.rook.io"
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
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectStoreUser represents a Ceph Object Store Gateway User"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "ObjectStoreUserSpec represent the spec of an Objectstoreuser"
						properties: {
							capabilities: {
								description: "Additional admin-level capabilities for the Ceph object store user"
								nullable:    true
								properties: {
									"amz-cache": {
										description: "Add capabilities for user to send request to RGW Cache API header. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									bilog: {
										description: "Add capabilities for user to change bucket index logging. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									bucket: {
										description: "Admin capabilities to read/write Ceph object store buckets. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									buckets: {
										description: "Admin capabilities to read/write Ceph object store buckets. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									datalog: {
										description: "Add capabilities for user to change data logging. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									info: {
										description: "Admin capabilities to read/write information about the user. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									mdlog: {
										description: "Add capabilities for user to change metadata logging. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									metadata: {
										description: "Admin capabilities to read/write Ceph object store metadata. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									"oidc-provider": {
										description: "Add capabilities for user to change oidc provider. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									ratelimit: {
										description: "Add capabilities for user to set rate limiter for user and bucket. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									roles: {
										description: "Admin capabilities to read/write roles for user. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									usage: {
										description: "Admin capabilities to read/write Ceph object store usage. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									user: {
										description: "Admin capabilities to read/write Ceph object store users. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									"user-policy": {
										description: "Add capabilities for user to change user policies. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									users: {
										description: "Admin capabilities to read/write Ceph object store users. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
									zone: {
										description: "Admin capabilities to read/write Ceph object store zones. Documented in https://docs.ceph."
										enum: [
											"*",
											"read",
											"write",
											"read, write",
										]
										type: "string"
									}
								}
								type: "object"
							}
							clusterNamespace: {
								description: "The namespace where the parent CephCluster and CephObjectStore are found"
								type:        "string"
							}
							displayName: {
								description: "The display name for the ceph users"
								type:        "string"
							}
							quotas: {
								description: "ObjectUserQuotaSpec can be used to set quotas for the object store user to limit their usage."
								nullable:    true
								properties: {
									maxBuckets: {
										description: "Maximum bucket limit for the ceph user"
										nullable:    true
										type:        "integer"
									}
									maxObjects: {
										description: "Maximum number of objects across all the user's buckets"
										format:      "int64"
										nullable:    true
										type:        "integer"
									}
									maxSize: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "Maximum size limit of all objects across all the user's buckets See https://pkg.go.dev/k8s."
										nullable:                     true
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
								}
								type: "object"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephobjectzonegroups.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectZoneGroup"
			listKind: "CephObjectZoneGroupList"
			plural:   "cephobjectzonegroups"
			singular: "cephobjectzonegroup"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectZoneGroup represents a Ceph Object Store Gateway Zone Group"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "ObjectZoneGroupSpec represent the spec of an ObjectZoneGroup"
						properties: realm: {
							description: "The display name for the ceph users"
							type:        "string"
						}
						required: ["realm"]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephobjectzones.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephObjectZone"
			listKind: "CephObjectZoneList"
			plural:   "cephobjectzones"
			singular: "cephobjectzone"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephObjectZone represents a Ceph Object Store Gateway Zone"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "ObjectZoneSpec represent the spec of an ObjectZone"
						properties: {
							customEndpoints: {
								description: "If this zone cannot be accessed from other peer Ceph clusters via the ClusterIP Service endpoint cre"
								items: type: "string"
								nullable: true
								type:     "array"
							}
							dataPool: {
								description: "The data pool settings"
								nullable:    true
								properties: {
									compressionMode: {
										description: "DEPRECATED: use Parameters instead, e.g."
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
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
											peers: {
												description: "Peers represents the peers spec"
												nullable:    true
												properties: secretNames: {
													description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
													items: type: "string"
													type: "array"
												}
												type: "object"
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
														path: {
															description: "Path is the path to snapshot, only valid for CephFS"
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
											hybridStorage: {
												description: "HybridStorage represents hybrid storage tier settings"
												nullable:    true
												properties: {
													primaryDeviceClass: {
														description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
														minLength:   1
														type:        "string"
													}
													secondaryDeviceClass: {
														description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
														minLength:   1
														type:        "string"
													}
												}
												required: [
													"primaryDeviceClass",
													"secondaryDeviceClass",
												]
												type: "object"
											}
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
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
												type:        "number"
											}
										}
										required: ["size"]
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
										description: "DEPRECATED: use Parameters instead, e.g."
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
												description: "Number of coding chunks per object in an erasure coded storage pool (required for erasure-coded pool"
												minimum:     0
												type:        "integer"
											}
											dataChunks: {
												description: "Number of data chunks per object in an erasure coded storage pool (required for erasure-coded pool t"
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
										description: "The failure domain: osd/host/(region or zone if available) - technically also any type in the crush "
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
											peers: {
												description: "Peers represents the peers spec"
												nullable:    true
												properties: secretNames: {
													description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
													items: type: "string"
													type: "array"
												}
												type: "object"
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
														path: {
															description: "Path is the path to snapshot, only valid for CephFS"
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
											hybridStorage: {
												description: "HybridStorage represents hybrid storage tier settings"
												nullable:    true
												properties: {
													primaryDeviceClass: {
														description: "PrimaryDeviceClass represents high performance tier (for example SSD or NVME) for Primary OSD"
														minLength:   1
														type:        "string"
													}
													secondaryDeviceClass: {
														description: "SecondaryDeviceClass represents low performance tier (for example HDDs) for remaining OSDs"
														minLength:   1
														type:        "string"
													}
												}
												required: [
													"primaryDeviceClass",
													"secondaryDeviceClass",
												]
												type: "object"
											}
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
												description: "Size - Number of copies per object in a replicated storage pool, including the object itself (requir"
												minimum:     0
												type:        "integer"
											}
											subFailureDomain: {
												description: "SubFailureDomain the name of the sub-failure domain"
												type:        "string"
											}
											targetSizeRatio: {
												description: "TargetSizeRatio gives a hint (%) to Ceph in terms of expected consumption of the total cluster capac"
												type:        "number"
											}
										}
										required: ["size"]
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
								default:     true
								description: "Preserve pools on object zone deletion"
								type:        "boolean"
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
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
}, {
	metadata: name: "cephrbdmirrors.ceph.rook.io"
	spec: {
		group: "ceph.rook.io"
		names: {
			kind:     "CephRBDMirror"
			listKind: "CephRBDMirrorList"
			plural:   "cephrbdmirrors"
			singular: "cephrbdmirror"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.phase"
				name:     "Phase"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "CephRBDMirror represents a Ceph RBD Mirror"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object."
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents."
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
								description: "Peers represents the peers spec"
								nullable:    true
								properties: secretNames: {
									description: "SecretNames represents the Kubernetes Secret names to add rbd-mirror or cephfs-mirror peers"
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
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																				items: type: "string"
																				type: "array"
																			}
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates "
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty."
																			items: type: "string"
																			type: "array"
																		}
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
										description: "PodAffinity is a group of inter pod affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified "
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will no"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
										description: "PodAntiAffinity is a group of inter pod anti affinity scheduling rules"
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions speci"
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most"
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
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	description: "A label query over the set of namespaces that the term applies to."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values."
																						items: type: "string"
																						type: "array"
																					}
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
																			description: "matchLabels is a map of {key,value} pairs."
																			type:        "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	description: "namespaces specifies a static list of namespace names that the term applies to."
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod wi"
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) t"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															description: "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															description: "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration."
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															description: "A label query over the set of namespaces that the term applies to."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values."
																				items: type: "string"
																				type: "array"
																			}
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
																	description: "matchLabels is a map of {key,value} pairs."
																	type:        "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															description: "namespaces specifies a static list of namespace names that the term applies to."
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching th"
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
									tolerations: {
										description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
										items: {
											description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect"
											properties: {
												effect: {
													description: "Effect indicates the taint effect to match. Empty means match all taint effects."
													type:        "string"
												}
												key: {
													description: "Key is the taint key that the toleration applies to. Empty means match all taint keys."
													type:        "string"
												}
												operator: {
													description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal."
													type:        "string"
												}
												tolerationSeconds: {
													description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, o"
													format:      "int64"
													type:        "integer"
												}
												value: {
													description: "Value is the taint value the toleration matches to."
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
													description: "LabelSelector is used to find matching pods."
													properties: {
														matchExpressions: {
															description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
															items: {
																description: "A label selector requirement is a selector that contains values, a key, and an operator that relates"
																properties: {
																	key: {
																		description: "key is the label key that the selector applies to."
																		type:        "string"
																	}
																	operator: {
																		description: "operator represents a key's relationship to a set of values."
																		type:        "string"
																	}
																	values: {
																		description: "values is an array of string values."
																		items: type: "string"
																		type: "array"
																	}
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
															description: "matchLabels is a map of {key,value} pairs."
															type:        "object"
														}
													}
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												matchLabelKeys: {
													description: "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated"
													items: type: "string"
													type:                     "array"
													"x-kubernetes-list-type": "atomic"
												}
												maxSkew: {
													description: "MaxSkew describes the degree to which pods may be unevenly distributed."
													format:      "int32"
													type:        "integer"
												}
												minDomains: {
													description: "MinDomains indicates a minimum number of eligible domains."
													format:      "int32"
													type:        "integer"
												}
												nodeAffinityPolicy: {
													description: "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod "
													type:        "string"
												}
												nodeTaintsPolicy: {
													description: "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew."
													type:        "string"
												}
												topologyKey: {
													description: "TopologyKey is the key of node labels."
													type:        "string"
												}
												whenUnsatisfiable: {
													description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint."
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
									claims: {
										description: "Claims lists the names of resources, defined in spec."
										items: {
											description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
											properties: name: {
												description: "Name must match the name of one entry in pod.spec."
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
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes."
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
										description: "Requests describes the minimum amount of compute resources required."
										type:        "object"
									}
								}
								type:                                   "object"
								"x-kubernetes-preserve-unknown-fields": true
							}
						}
						required: ["count"]
						type: "object"
					}
					status: {
						description: "Status represents the status of an object"
						properties: {
							conditions: {
								items: {
									description: "Condition represents a status condition on any Rook-Ceph Custom Resource."
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
											description: "ConditionReason is a reason for a condition"
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
							observedGeneration: {
								description: "ObservedGeneration is the latest generation observed by the controller."
								format:      "int64"
								type:        "integer"
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
		scope: apiextensionsv1.#NamespaceScoped
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
		scope: apiextensionsv1.#ClusterScoped
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
}]
