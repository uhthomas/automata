package volsync_system

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
	metadata: name: "replicationdestinations.volsync.backube"
	spec: {
		group: "volsync.backube"
		names: {
			kind:     "ReplicationDestination"
			listKind: "ReplicationDestinationList"
			plural:   "replicationdestinations"
			singular: "replicationdestination"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				format:   "date-time"
				jsonPath: ".status.lastSyncTime"
				name:     "Last sync"
				type:     "string"
			}, {
				jsonPath: ".status.lastSyncDuration"
				name:     "Duration"
				type:     "string"
			}, {
				format:   "date-time"
				jsonPath: ".status.nextSyncTime"
				name:     "Next sync"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ReplicationDestination defines the destination for a replicated volume"
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
						description: "spec is the desired state of the ReplicationDestination, including the replication method to use and its configuration."
						properties: {
							external: {
								description: "external defines the configuration when using an external replication provider."
								properties: {
									parameters: {
										additionalProperties: type: "string"
										description: "parameters are provider-specific key/value configuration parameters. For more information, please see the documentation of the specific replication provider being used."
										type:        "object"
									}
									provider: {
										description: "provider is the name of the external replication provider. The name should be of the form: domain.com/provider."
										type:        "string"
									}
								}
								type: "object"
							}
							paused: {
								description: "paused can be used to temporarily stop replication. Defaults to \"false\"."
								type:        "boolean"
							}
							rclone: {
								description: "rclone defines the configuration when using Rclone-based replication."
								properties: {
									accessModes: {
										description: "accessModes specifies the access modes for the destination volume."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity is the size of the destination volume to create."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the destination volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									customCA: {
										description: "customCA is a custom CA that will be used to verify the remote"
										properties: {
											configMapName: {
												description: "The name of a ConfigMap that contains the custom CA certificate If ConfigMapName is used then SecretName should not be set"
												type:        "string"
											}
											key: {
												description: "The key within the Secret or ConfigMap containing the CA certificate"
												type:        "string"
											}
											secretName: {
												description: "The name of a Secret that contains the custom CA certificate If SecretName is used then ConfigMapName should not be set"
												type:        "string"
											}
										}
										type: "object"
									}
									destinationPVC: {
										description: "destinationPVC is a PVC to use as the transfer destination instead of automatically provisioning one. Either this field or both capacity and accessModes must be specified."
										type:        "string"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationDestination."
										type:        "string"
									}
									rcloneConfig: {
										description: "RcloneConfig is the rclone secret name"
										type:        "string"
									}
									rcloneConfigSection: {
										description: "RcloneConfigSection is the section in rclone_config file to use for the current job."
										type:        "string"
									}
									rcloneDestPath: {
										description: "RcloneDestPath is the remote path to sync to."
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to specify the StorageClass of the destination volume. If not set, the default StorageClass will be used."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							restic: {
								description: "restic defines the configuration when using Restic-based replication."
								properties: {
									accessModes: {
										description: "accessModes specifies the access modes for the destination volume."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									cacheAccessModes: {
										description: "accessModes can be used to set the accessModes of restic metadata cache volume"
										items: type: "string"
										type: "array"
									}
									cacheCapacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "cacheCapacity can be used to set the size of the restic metadata cache volume"
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									cacheStorageClassName: {
										description: "cacheStorageClassName can be used to set the StorageClass of the restic metadata cache volume"
										type:        "string"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity is the size of the destination volume to create."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the destination volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									customCA: {
										description: "customCA is a custom CA that will be used to verify the remote"
										properties: {
											configMapName: {
												description: "The name of a ConfigMap that contains the custom CA certificate If ConfigMapName is used then SecretName should not be set"
												type:        "string"
											}
											key: {
												description: "The key within the Secret or ConfigMap containing the CA certificate"
												type:        "string"
											}
											secretName: {
												description: "The name of a Secret that contains the custom CA certificate If SecretName is used then ConfigMapName should not be set"
												type:        "string"
											}
										}
										type: "object"
									}
									destinationPVC: {
										description: "destinationPVC is a PVC to use as the transfer destination instead of automatically provisioning one. Either this field or both capacity and accessModes must be specified."
										type:        "string"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationDestination."
										type:        "string"
									}
									previous: {
										description: "Previous specifies the number of image to skip before selecting one to restore from"
										format:      "int32"
										type:        "integer"
									}
									repository: {
										description: "Repository is the secret name containing repository info"
										type:        "string"
									}
									restoreAsOf: {
										description: "RestoreAsOf refers to the backup that is most recent as of that time."
										format:      "date-time"
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to specify the StorageClass of the destination volume. If not set, the default StorageClass will be used."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							rsync: {
								description: "rsync defines the configuration when using Rsync-based replication."
								properties: {
									accessModes: {
										description: "accessModes specifies the access modes for the destination volume."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									address: {
										description: "address is the remote address to connect to for replication."
										type:        "string"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity is the size of the destination volume to create."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the destination volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									destinationPVC: {
										description: "destinationPVC is a PVC to use as the transfer destination instead of automatically provisioning one. Either this field or both capacity and accessModes must be specified."
										type:        "string"
									}
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationDestination."
										type:        "string"
									}
									path: {
										description: "path is the remote path to rsync from. Defaults to \"/\""
										type:        "string"
									}
									port: {
										description: "port is the SSH port to connect to for replication. Defaults to 22."
										format:      "int32"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
									serviceAnnotations: {
										additionalProperties: type: "string"
										description: "serviceAnnotations defines annotations that will be added to the service created for incoming SSH connections.  If set, these annotations will be used instead of any VolSync default values."
										type:        "object"
									}
									serviceType: {
										description: "serviceType determines the Service type that will be created for incoming SSH connections."
										type:        "string"
									}
									sshKeys: {
										description: "sshKeys is the name of a Secret that contains the SSH keys to be used for authentication. If not provided, the keys will be generated."
										type:        "string"
									}
									sshUser: {
										description: "sshUser is the username for outgoing SSH connections. Defaults to \"root\"."
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to specify the StorageClass of the destination volume. If not set, the default StorageClass will be used."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							rsyncTLS: {
								description: "rsyncTLS defines the configuration when using Rsync-based replication over TLS."
								properties: {
									accessModes: {
										description: "accessModes specifies the access modes for the destination volume."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity is the size of the destination volume to create."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the destination volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									destinationPVC: {
										description: "destinationPVC is a PVC to use as the transfer destination instead of automatically provisioning one. Either this field or both capacity and accessModes must be specified."
										type:        "string"
									}
									keySecret: {
										description: "keySecret is the name of a Secret that contains the TLS pre-shared key to be used for authentication. If not provided, the key will be generated."
										type:        "string"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationDestination."
										type:        "string"
									}
									serviceAnnotations: {
										additionalProperties: type: "string"
										description: "serviceAnnotations defines annotations that will be added to the service created for incoming SSH connections.  If set, these annotations will be used instead of any VolSync default values."
										type:        "object"
									}
									serviceType: {
										description: "serviceType determines the Service type that will be created for incoming TLS connections."
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to specify the StorageClass of the destination volume. If not set, the default StorageClass will be used."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							trigger: {
								description: "trigger determines if/when the destination should attempt to synchronize data with the source."
								properties: {
									manual: {
										description: "manual is a string value that schedules a manual trigger. Once a sync completes then status.lastManualSync is set to the same string value. A consumer of a manual trigger should set spec.trigger.manual to a known value and then wait for lastManualSync to be updated by the operator to the same value, which means that the manual trigger will then pause and wait for further updates to the trigger."
										type:        "string"
									}
									schedule: {
										description: "schedule is a cronspec (https://en.wikipedia.org/wiki/Cron#Overview) that can be used to schedule replication to occur at regular, time-based intervals. nolint:lll"
										pattern:     "^(@(annually|yearly|monthly|weekly|daily|hourly))|((((\\d+,)*\\d+|(\\d+(\\/|-)\\d+)|\\*(\\/\\d+)?)\\s?){5})$"
										type:        "string"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "status is the observed state of the ReplicationDestination as determined by the controller."
						properties: {
							conditions: {
								description: "conditions represent the latest available observations of the destination's state."
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
							external: {
								additionalProperties: type: "string"
								description: "external contains provider-specific status information. For more details, please see the documentation of the specific replication provider being used."
								type:        "object"
							}
							lastManualSync: {
								description: "lastManualSync is set to the last spec.trigger.manual when the manual sync is done."
								type:        "string"
							}
							lastSyncDuration: {
								description: "lastSyncDuration is the amount of time required to send the most recent update."
								type:        "string"
							}
							lastSyncStartTime: {
								description: "lastSyncStartTime is the time the most recent synchronization started."
								format:      "date-time"
								type:        "string"
							}
							lastSyncTime: {
								description: "lastSyncTime is the time of the most recent successful synchronization."
								format:      "date-time"
								type:        "string"
							}
							latestImage: {
								description: "latestImage in the object holding the most recent consistent replicated image."
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
							latestMoverStatus: {
								description: "Logs/Summary from latest mover job"
								properties: {
									logs: type:   "string"
									result: type: "string"
								}
								type: "object"
							}
							nextSyncTime: {
								description: "nextSyncTime is the time when the next volume synchronization is scheduled to start (for schedule-based synchronization)."
								format:      "date-time"
								type:        "string"
							}
							rsync: {
								description: "rsync contains status information for Rsync-based replication."
								properties: {
									address: {
										description: "address is the address to connect to for incoming SSH replication connections."
										type:        "string"
									}
									port: {
										description: "port is the SSH port to connect to for incoming SSH replication connections."
										format:      "int32"
										type:        "integer"
									}
									sshKeys: {
										description: "sshKeys is the name of a Secret that contains the SSH keys to be used for authentication. If not provided in .spec.rsync.sshKeys, SSH keys will be generated and the appropriate keys for the remote side will be placed here."
										type:        "string"
									}
								}
								type: "object"
							}
							rsyncTLS: {
								description: "rsyncTLS contains status information for Rsync-based replication over TLS."
								properties: {
									address: {
										description: "address is the address to connect to for incoming TLS connections."
										type:        "string"
									}
									keySecret: {
										description: "keySecret is the name of a Secret that contains the TLS pre-shared key to be used for authentication. If not provided in .spec.rsyncTLS.keySecret, the key Secret will be generated and named here."
										type:        "string"
									}
									port: {
										description: "port is the port to connect to for incoming replication connections."
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
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	metadata: name: "replicationsources.volsync.backube"
	spec: {
		group: "volsync.backube"
		names: {
			kind:     "ReplicationSource"
			listKind: "ReplicationSourceList"
			plural:   "replicationsources"
			singular: "replicationsource"
		}
		scope: apiextensionsv1.#NamespaceScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.sourcePVC"
				name:     "Source"
				type:     "string"
			}, {
				format:   "date-time"
				jsonPath: ".status.lastSyncTime"
				name:     "Last sync"
				type:     "string"
			}, {
				jsonPath: ".status.lastSyncDuration"
				name:     "Duration"
				type:     "string"
			}, {
				format:   "date-time"
				jsonPath: ".status.nextSyncTime"
				name:     "Next sync"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "ReplicationSource defines the source for a replicated volume"
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
						description: "spec is the desired state of the ReplicationSource, including the replication method to use and its configuration."
						properties: {
							external: {
								description: "external defines the configuration when using an external replication provider."
								properties: {
									parameters: {
										additionalProperties: type: "string"
										description: "parameters are provider-specific key/value configuration parameters. For more information, please see the documentation of the specific replication provider being used."
										type:        "object"
									}
									provider: {
										description: "provider is the name of the external replication provider. The name should be of the form: domain.com/provider."
										type:        "string"
									}
								}
								type: "object"
							}
							paused: {
								description: "paused can be used to temporarily stop replication. Defaults to \"false\"."
								type:        "boolean"
							}
							rclone: {
								description: "rclone defines the configuration when using Rclone-based replication."
								properties: {
									accessModes: {
										description: "accessModes can be used to override the accessModes of the PiT image."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity can be used to override the capacity of the PiT image."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the source volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									customCA: {
										description: "customCA is a custom CA that will be used to verify the remote"
										properties: {
											configMapName: {
												description: "The name of a ConfigMap that contains the custom CA certificate If ConfigMapName is used then SecretName should not be set"
												type:        "string"
											}
											key: {
												description: "The key within the Secret or ConfigMap containing the CA certificate"
												type:        "string"
											}
											secretName: {
												description: "The name of a Secret that contains the custom CA certificate If SecretName is used then ConfigMapName should not be set"
												type:        "string"
											}
										}
										type: "object"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationSource."
										type:        "string"
									}
									rcloneConfig: {
										description: "RcloneConfig is the rclone secret name"
										type:        "string"
									}
									rcloneConfigSection: {
										description: "RcloneConfigSection is the section in rclone_config file to use for the current job."
										type:        "string"
									}
									rcloneDestPath: {
										description: "RcloneDestPath is the remote path to sync to."
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to override the StorageClass of the PiT image."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							restic: {
								description: "restic defines the configuration when using Restic-based replication."
								properties: {
									accessModes: {
										description: "accessModes can be used to override the accessModes of the PiT image."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									cacheAccessModes: {
										description: "CacheAccessModes can be used to set the accessModes of restic metadata cache volume"
										items: type: "string"
										type: "array"
									}
									cacheCapacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "cacheCapacity can be used to set the size of the restic metadata cache volume"
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									cacheStorageClassName: {
										description: "cacheStorageClassName can be used to set the StorageClass of the restic metadata cache volume"
										type:        "string"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity can be used to override the capacity of the PiT image."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the source volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									customCA: {
										description: "customCA is a custom CA that will be used to verify the remote"
										properties: {
											configMapName: {
												description: "The name of a ConfigMap that contains the custom CA certificate If ConfigMapName is used then SecretName should not be set"
												type:        "string"
											}
											key: {
												description: "The key within the Secret or ConfigMap containing the CA certificate"
												type:        "string"
											}
											secretName: {
												description: "The name of a Secret that contains the custom CA certificate If SecretName is used then ConfigMapName should not be set"
												type:        "string"
											}
										}
										type: "object"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationSource."
										type:        "string"
									}
									pruneIntervalDays: {
										description: "PruneIntervalDays define how often to prune the repository"
										format:      "int32"
										type:        "integer"
									}
									repository: {
										description: "Repository is the secret name containing repository info"
										type:        "string"
									}
									retain: {
										description: "ResticRetainPolicy define the retain policy"
										properties: {
											daily: {
												description: "Daily defines the number of snapshots to be kept daily"
												format:      "int32"
												type:        "integer"
											}
											hourly: {
												description: "Hourly defines the number of snapshots to be kept hourly"
												format:      "int32"
												type:        "integer"
											}
											last: {
												description: "Last defines the number of snapshots to be kept"
												type:        "string"
											}
											monthly: {
												description: "Monthly defines the number of snapshots to be kept monthly"
												format:      "int32"
												type:        "integer"
											}
											weekly: {
												description: "Weekly defines the number of snapshots to be kept weekly"
												format:      "int32"
												type:        "integer"
											}
											within: {
												description: "Within defines the number of snapshots to be kept Within the given time period"
												type:        "string"
											}
											yearly: {
												description: "Yearly defines the number of snapshots to be kept yearly"
												format:      "int32"
												type:        "integer"
											}
										}
										type: "object"
									}
									storageClassName: {
										description: "storageClassName can be used to override the StorageClass of the PiT image."
										type:        "string"
									}
									unlock: {
										description: "unlock is a string value that schedules an unlock on the restic repository during the next sync operation. Once a sync completes then status.restic.lastUnlocked is set to the same string value. To unlock a repository, set spec.restic.unlock to a known value and then wait for lastUnlocked to be updated by the operator to the same value, which means that the sync unlocked the repository by running a restic unlock command and then ran a backup. Unlock will not be run again unless spec.restic.unlock is set to a different value."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							rsync: {
								description: "rsync defines the configuration when using Rsync-based replication."
								properties: {
									accessModes: {
										description: "accessModes can be used to override the accessModes of the PiT image."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									address: {
										description: "address is the remote address to connect to for replication."
										type:        "string"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity can be used to override the capacity of the PiT image."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the source volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationSource."
										type:        "string"
									}
									path: {
										description: "path is the remote path to rsync to. Defaults to \"/\""
										type:        "string"
									}
									port: {
										description: "port is the SSH port to connect to for replication. Defaults to 22."
										format:      "int32"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
									serviceType: {
										description: "serviceType determines the Service type that will be created for incoming SSH connections."
										type:        "string"
									}
									sshKeys: {
										description: "sshKeys is the name of a Secret that contains the SSH keys to be used for authentication. If not provided, the keys will be generated."
										type:        "string"
									}
									sshUser: {
										description: "sshUser is the username for outgoing SSH connections. Defaults to \"root\"."
										type:        "string"
									}
									storageClassName: {
										description: "storageClassName can be used to override the StorageClass of the PiT image."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							rsyncTLS: {
								description: "rsyncTLS defines the configuration when using Rsync-based replication over TLS."
								properties: {
									accessModes: {
										description: "accessModes can be used to override the accessModes of the PiT image."
										items: type: "string"
										minItems: 1
										type:     "array"
									}
									address: {
										description: "address is the remote address to connect to for replication."
										type:        "string"
									}
									capacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "capacity can be used to override the capacity of the PiT image."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									copyMethod: {
										description: "copyMethod describes how a point-in-time (PiT) image of the source volume should be created."
										enum: [
											"Direct",
											"None",
											"Clone",
											"Snapshot",
										]
										type: "string"
									}
									keySecret: {
										description: "keySecret is the name of a Secret that contains the TLS pre-shared key to be used for authentication. If not provided, the key will be generated."
										type:        "string"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationSource."
										type:        "string"
									}
									port: {
										description: "port is the port to connect to for replication. Defaults to 8000."
										format:      "int32"
										maximum:     65535
										minimum:     0
										type:        "integer"
									}
									storageClassName: {
										description: "storageClassName can be used to override the StorageClass of the PiT image."
										type:        "string"
									}
									volumeSnapshotClassName: {
										description: "volumeSnapshotClassName can be used to specify the VSC to be used if copyMethod is Snapshot. If not set, the default VSC is used."
										type:        "string"
									}
								}
								type: "object"
							}
							sourcePVC: {
								description: "sourcePVC is the name of the PersistentVolumeClaim (PVC) to replicate."
								type:        "string"
							}
							syncthing: {
								description: "syncthing defines the configuration when using Syncthing-based replication."
								properties: {
									configAccessModes: {
										description: "Used to set the accessModes of Syncthing config volume."
										items: type: "string"
										type: "array"
									}
									configCapacity: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										description:                  "Used to set the size of the Syncthing config volume."
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									configStorageClassName: {
										description: "Used to set the StorageClass of the Syncthing config volume."
										type:        "string"
									}
									moverSecurityContext: {
										description: "MoverSecurityContext allows specifying the PodSecurityContext that will be used by the data mover"
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
									moverServiceAccount: {
										description: "MoverServiceAccount allows specifying the name of the service account that will be used by the data mover. This should only be used by advanced users who want to override the service account normally used by the mover. The service account needs to exist in the same namespace as the ReplicationSource."
										type:        "string"
									}
									peers: {
										description: "List of Syncthing peers to be connected for syncing"
										items: {
											description: "SyncthingPeer Defines the necessary information needed by VolSync to configure a given peer with the running Syncthing instance."
											properties: {
												ID: {
													description: "The peer's Syncthing ID."
													type:        "string"
												}
												address: {
													description: "The peer's address that our Syncthing node will connect to."
													type:        "string"
												}
												introducer: {
													description: "A flag that determines whether this peer should introduce us to other peers sharing this volume. It is HIGHLY recommended that two Syncthing peers do NOT set each other as introducers as you will have a difficult time disconnecting the two."
													type:        "boolean"
												}
											}
											required: [
												"ID",
												"address",
												"introducer",
											]
											type: "object"
										}
										type: "array"
									}
									serviceType: {
										description: "Type of service to be used when exposing the Syncthing peer"
										type:        "string"
									}
								}
								type: "object"
							}
							trigger: {
								description: "trigger determines when the latest state of the volume will be captured (and potentially replicated to the destination)."
								properties: {
									manual: {
										description: "manual is a string value that schedules a manual trigger. Once a sync completes then status.lastManualSync is set to the same string value. A consumer of a manual trigger should set spec.trigger.manual to a known value and then wait for lastManualSync to be updated by the operator to the same value, which means that the manual trigger will then pause and wait for further updates to the trigger."
										type:        "string"
									}
									schedule: {
										description: "schedule is a cronspec (https://en.wikipedia.org/wiki/Cron#Overview) that can be used to schedule replication to occur at regular, time-based intervals. nolint:lll"
										pattern:     "^(@(annually|yearly|monthly|weekly|daily|hourly))|((((\\d+,)*\\d+|(\\d+(\\/|-)\\d+)|\\*(\\/\\d+)?)\\s?){5})$"
										type:        "string"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "status is the observed state of the ReplicationSource as determined by the controller."
						properties: {
							conditions: {
								description: "conditions represent the latest available observations of the source's state."
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
							external: {
								additionalProperties: type: "string"
								description: "external contains provider-specific status information. For more details, please see the documentation of the specific replication provider being used."
								type:        "object"
							}
							lastManualSync: {
								description: "lastManualSync is set to the last spec.trigger.manual when the manual sync is done."
								type:        "string"
							}
							lastSyncDuration: {
								description: "lastSyncDuration is the amount of time required to send the most recent update."
								type:        "string"
							}
							lastSyncStartTime: {
								description: "lastSyncStartTime is the time the most recent synchronization started."
								format:      "date-time"
								type:        "string"
							}
							lastSyncTime: {
								description: "lastSyncTime is the time of the most recent successful synchronization."
								format:      "date-time"
								type:        "string"
							}
							latestMoverStatus: {
								description: "Logs/Summary from latest mover job"
								properties: {
									logs: type:   "string"
									result: type: "string"
								}
								type: "object"
							}
							nextSyncTime: {
								description: "nextSyncTime is the time when the next volume synchronization is scheduled to start (for schedule-based synchronization)."
								format:      "date-time"
								type:        "string"
							}
							restic: {
								description: "restic contains status information for Restic-based replication."
								properties: {
									lastPruned: {
										description: "lastPruned in the object holding the time of last pruned"
										format:      "date-time"
										type:        "string"
									}
									lastUnlocked: {
										description: "lastUnlocked is set to the last spec.restic.unlock when a sync is done that unlocks the restic repository."
										type:        "string"
									}
								}
								type: "object"
							}
							rsync: {
								description: "rsync contains status information for Rsync-based replication."
								properties: {
									address: {
										description: "address is the address to connect to for incoming SSH replication connections."
										type:        "string"
									}
									port: {
										description: "port is the SSH port to connect to for incoming SSH replication connections."
										format:      "int32"
										type:        "integer"
									}
									sshKeys: {
										description: "sshKeys is the name of a Secret that contains the SSH keys to be used for authentication. If not provided in .spec.rsync.sshKeys, SSH keys will be generated and the appropriate keys for the remote side will be placed here."
										type:        "string"
									}
								}
								type: "object"
							}
							rsyncTLS: {
								description: "rsyncTLS contains status information for Rsync-based replication over TLS."
								properties: keySecret: {
									description: "keySecret is the name of a Secret that contains the TLS pre-shared key to be used for authentication. If not provided in .spec.rsyncTLS.keySecret, the key Secret will be generated and named here."
									type:        "string"
								}
								type: "object"
							}
							syncthing: {
								description: "contains status information when Syncthing-based replication is used."
								properties: {
									ID: {
										description: "Device ID of the current syncthing device"
										type:        "string"
									}
									address: {
										description: "Service address where Syncthing is exposed to the rest of the world"
										type:        "string"
									}
									peers: {
										description: "List of the Syncthing nodes we are currently connected to."
										items: {
											description: "SyncthingPeerStatus Is a struct that contains information pertaining to the status of a given Syncthing peer."
											properties: {
												ID: {
													description: "ID Is the peer's Syncthing ID."
													type:        "string"
												}
												address: {
													description: "The address of the Syncthing peer."
													type:        "string"
												}
												connected: {
													description: "Flag indicating whether peer is currently connected."
													type:        "boolean"
												}
												introducedBy: {
													description: "The ID of the Syncthing peer that this one was introduced by."
													type:        "string"
												}
												name: {
													description: "A friendly name to associate the given device."
													type:        "string"
												}
											}
											required: [
												"ID",
												"address",
												"connected",
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
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
