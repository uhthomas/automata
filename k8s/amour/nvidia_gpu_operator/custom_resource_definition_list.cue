package nvidia_gpu_operator

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
	metadata: name: "clusterpolicies.nvidia.com"
	spec: {
		group: "nvidia.com"
		names: {
			kind:     "ClusterPolicy"
			listKind: "ClusterPolicyList"
			plural:   "clusterpolicies"
			singular: "clusterpolicy"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.state"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "ClusterPolicy is the Schema for the clusterpolicies API"
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
						description: "ClusterPolicySpec defines the desired state of ClusterPolicy"
						properties: {
							ccManager: {
								description: "CCManager component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									defaultMode: {
										description: "Default CC mode setting for compatible GPUs on the node"
										enum: [
											"on",
											"off",
											"devtools",
										]
										type: "string"
									}
									enabled: {
										description: "Enabled indicates if deployment of CC Manager is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "CC Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "CC Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "CC Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							cdi: {
								description: "CDI configures how the Container Device Interface is used in the cluster"
								properties: {
									default: {
										default:     false
										description: "Default indicates whether to use CDI as the default mechanism for providing GPU access to containers."
										type:        "boolean"
									}
									enabled: {
										default:     false
										description: "Enabled indicates whether CDI can be used to make GPUs accessible to containers."
										type:        "boolean"
									}
								}
								type: "object"
							}
							daemonsets: {
								description: "Daemonset defines common configuration for all Daemonsets"
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Optional: Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects."
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Optional: Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services."
										type:        "object"
									}
									priorityClassName: type: "string"
									rollingUpdate: {
										description: "Optional: Configuration for rolling update of all DaemonSet pods"
										properties: maxUnavailable: type: "string"
										type: "object"
									}
									tolerations: {
										description: "Optional: Set tolerations"
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
									updateStrategy: {
										default: "RollingUpdate"
										enum: [
											"RollingUpdate",
											"OnDelete",
										]
										type: "string"
									}
								}
								type: "object"
							}
							dcgm: {
								description: "DCGM component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA DCGM Hostengine as a separate pod is enabled."
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									hostPort: {
										description: "HostPort represents host port that needs to be bound for DCGM engine (Default: 5555)"
										format:      "int32"
										type:        "integer"
									}
									image: {
										description: "NVIDIA DCGM image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA DCGM image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA DCGM image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							dcgmExporter: {
								description: "DCGMExporter spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									config: {
										description: "Optional: Custom metrics configuration for NVIDIA DCGM Exporter"
										properties: name: {
											description: "ConfigMap name with file dcgm-metrics.csv for metrics to be collected by NVIDIA DCGM Exporter"
											type:        "string"
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA DCGM Exporter through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA DCGM Exporter image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA DCGM Exporter image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									serviceMonitor: {
										description: "Optional: ServiceMonitor configuration for NVIDIA DCGM Exporter"
										properties: {
											additionalLabels: {
												additionalProperties: type: "string"
												description: "AdditionalLabels to add to ServiceMonitor instance for NVIDIA DCGM Exporter"
												type:        "object"
											}
											enabled: {
												description: "Enabled indicates if ServiceMonitor is deployed for NVIDIA DCGM Exporter"
												type:        "boolean"
											}
											honorLabels: {
												description: "HonorLabels chooses the metric’s labels on collisions with target labels."
												type:        "boolean"
											}
											interval: {
												description: "Interval which metrics should be scraped from NVIDIA DCGM Exporter. If not specified Prometheus’ global scrape interval is used. Supported units: y, w, d, h, m, s, ms"
												pattern:     "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
												type:        "string"
											}
											relabelings: {
												description: "Relabelings allows to rewrite labels on metric sets for NVIDIA DCGM Exporter"
												items: {
													description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
													properties: {
														action: {
															default:     "replace"
															description: "Action to perform based on regex matching. Default is 'replace'. uppercase and lowercase actions require Prometheus >= 2.36."
															enum: [
																"replace",
																"Replace",
																"keep",
																"Keep",
																"drop",
																"Drop",
																"hashmod",
																"HashMod",
																"labelmap",
																"LabelMap",
																"labeldrop",
																"LabelDrop",
																"labelkeep",
																"LabelKeep",
																"lowercase",
																"Lowercase",
																"uppercase",
																"Uppercase",
																"keepequal",
																"KeepEqual",
																"dropequal",
																"DropEqual",
															]
															type: "string"
														}
														modulus: {
															description: "Modulus to take of the hash of the source label values."
															format:      "int64"
															type:        "integer"
														}
														regex: {
															description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
															type:        "string"
														}
														replacement: {
															description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
															type:        "string"
														}
														separator: {
															description: "Separator placed between concatenated source label values. default is ';'."
															type:        "string"
														}
														sourceLabels: {
															description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
															items: {
																description: "LabelName is a valid Prometheus label name which may only contain ASCII letters, numbers, as well as underscores."
																pattern:     "^[a-zA-Z_][a-zA-Z0-9_]*$"
																type:        "string"
															}
															type: "array"
														}
														targetLabel: {
															description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
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
									version: {
										description: "NVIDIA DCGM Exporter image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							devicePlugin: {
								description: "DevicePlugin component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									config: {
										description: "Optional: Configuration for the NVIDIA Device Plugin via the ConfigMap"
										properties: {
											default: {
												description: "Default config name within the ConfigMap for the NVIDIA Device Plugin  config"
												type:        "string"
											}
											name: {
												description: "ConfigMap name for NVIDIA Device Plugin config including shared config between plugin and GFD"
												type:        "string"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA Device Plugin through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA Device Plugin image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA Device Plugin image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA Device Plugin image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							driver: {
								description: "Driver component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									certConfig: {
										description: "Optional: Custom certificates configuration for NVIDIA Driver container"
										properties: name: type: "string"
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA Driver through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA Driver image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									kernelModuleConfig: {
										description: "Optional: Kernel module configuration parameters for the NVIDIA Driver"
										properties: name: type: "string"
										type: "object"
									}
									licensingConfig: {
										description: "Optional: Licensing configuration for NVIDIA vGPU licensing"
										properties: {
											configMapName: type: "string"
											nlsEnabled: {
												description: "NLSEnabled indicates if NVIDIA Licensing System is used for licensing."
												type:        "boolean"
											}
										}
										type: "object"
									}
									livenessProbe: {
										description: "NVIDIA Driver container liveness probe settings"
										properties: {
											failureThreshold: {
												description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											initialDelaySeconds: {
												description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												type:        "integer"
											}
											periodSeconds: {
												description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											successThreshold: {
												description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											timeoutSeconds: {
												description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
										}
										type: "object"
									}
									manager: {
										description: "Manager represents configuration for NVIDIA Driver Manager initContainer"
										properties: {
											env: {
												description: "Optional: List of environment variables"
												items: {
													description: "EnvVar represents an environment variable present in a Container."
													properties: {
														name: {
															description: "Name of the environment variable."
															type:        "string"
														}
														value: {
															description: "Value of the environment variable."
															type:        "string"
														}
													}
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											image: {
												description: "Image represents NVIDIA Driver Manager image name"
												pattern:     "[a-zA-Z0-9\\-]+"
												type:        "string"
											}
											imagePullPolicy: {
												description: "Image pull policy"
												type:        "string"
											}
											imagePullSecrets: {
												description: "Image pull secrets"
												items: type: "string"
												type: "array"
											}
											repository: {
												description: "Repository represents Driver Managerrepository path"
												type:        "string"
											}
											version: {
												description: "Version represents NVIDIA Driver Manager image tag(version)"
												type:        "string"
											}
										}
										type: "object"
									}
									rdma: {
										description: "GPUDirectRDMASpec defines the properties for nvidia-peermem deployment"
										properties: {
											enabled: {
												description: "Enabled indicates if GPUDirect RDMA is enabled through GPU operator"
												type:        "boolean"
											}
											useHostMofed: {
												description: "UseHostMOFED indicates to use MOFED drivers directly installed on the host to enable GPUDirect RDMA"
												type:        "boolean"
											}
										}
										type: "object"
									}
									readinessProbe: {
										description: "NVIDIA Driver container readiness probe settings"
										properties: {
											failureThreshold: {
												description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											initialDelaySeconds: {
												description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												type:        "integer"
											}
											periodSeconds: {
												description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											successThreshold: {
												description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											timeoutSeconds: {
												description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
										}
										type: "object"
									}
									repoConfig: {
										description: "Optional: Custom repo configuration for NVIDIA Driver container"
										properties: configMapName: type: "string"
										type: "object"
									}
									repository: {
										description: "NVIDIA Driver image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									startupProbe: {
										description: "NVIDIA Driver container startup probe settings"
										properties: {
											failureThreshold: {
												description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											initialDelaySeconds: {
												description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												type:        "integer"
											}
											periodSeconds: {
												description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											successThreshold: {
												description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
											timeoutSeconds: {
												description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
												format:      "int32"
												minimum:     1
												type:        "integer"
											}
										}
										type: "object"
									}
									upgradePolicy: {
										description: "Driver auto-upgrade settings"
										properties: {
											autoUpgrade: {
												default:     false
												description: "AutoUpgrade is a global switch for automatic upgrade feature if set to false all other options are ignored"
												type:        "boolean"
											}
											drain: {
												description: "DrainSpec describes configuration for node drain during automatic upgrade"
												properties: {
													deleteEmptyDir: {
														default:     false
														description: "DeleteEmptyDir indicates if should continue even if there are pods using emptyDir (local data that will be deleted when the node is drained)"
														type:        "boolean"
													}
													enable: {
														default:     false
														description: "Enable indicates if node draining is allowed during upgrade"
														type:        "boolean"
													}
													force: {
														default:     false
														description: "Force indicates if force draining is allowed"
														type:        "boolean"
													}
													podSelector: {
														description: "PodSelector specifies a label selector to filter pods on the node that need to be drained For more details on label selectors, see: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors"
														type:        "string"
													}
													timeoutSeconds: {
														default:     300
														description: "TimeoutSecond specifies the length of time in seconds to wait before giving up drain, zero means infinite"
														minimum:     0
														type:        "integer"
													}
												}
												type: "object"
											}
											maxParallelUpgrades: {
												default:     1
												description: "MaxParallelUpgrades indicates how many nodes can be upgraded in parallel 0 means no limit, all nodes will be upgraded in parallel"
												minimum:     0
												type:        "integer"
											}
											maxUnavailable: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												default:                      "25%"
												description:                  "MaxUnavailable is the maximum number of nodes with the driver installed, that can be unavailable during the upgrade. Value can be an absolute number (ex: 5) or a percentage of total nodes at the start of upgrade (ex: 10%). Absolute number is calculated from percentage by rounding up. By default, a fixed value of 25% is used."
												"x-kubernetes-int-or-string": true
											}
											podDeletion: {
												description: "PodDeletionSpec describes configuration for deletion of pods using special resources during automatic upgrade"
												properties: {
													deleteEmptyDir: {
														default:     false
														description: "DeleteEmptyDir indicates if should continue even if there are pods using emptyDir (local data that will be deleted when the pod is deleted)"
														type:        "boolean"
													}
													force: {
														default:     false
														description: "Force indicates if force deletion is allowed"
														type:        "boolean"
													}
													timeoutSeconds: {
														default:     300
														description: "TimeoutSecond specifies the length of time in seconds to wait before giving up on pod termination, zero means infinite"
														minimum:     0
														type:        "integer"
													}
												}
												type: "object"
											}
											waitForCompletion: {
												description: "WaitForCompletionSpec describes the configuration for waiting on job completions"
												properties: {
													podSelector: {
														description: "PodSelector specifies a label selector for the pods to wait for completion For more details on label selectors, see: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors"
														type:        "string"
													}
													timeoutSeconds: {
														default:     0
														description: "TimeoutSecond specifies the length of time in seconds to wait before giving up on pod termination, zero means infinite"
														minimum:     0
														type:        "integer"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									useNvidiaDriverCRD: {
										description: "UseNvidiaDriverCRD indicates if the deployment of NVIDIA Driver is managed by the NVIDIADriver CRD type"
										type:        "boolean"
									}
									useOpenKernelModules: {
										description: "UseOpenKernelModules indicates if the open GPU kernel modules should be used"
										type:        "boolean"
									}
									usePrecompiled: {
										description: "UsePrecompiled indicates if deployment of NVIDIA Driver using pre-compiled modules is enabled"
										type:        "boolean"
									}
									version: {
										description: "NVIDIA Driver image tag"
										type:        "string"
									}
									virtualTopology: {
										description: "Optional: Virtual Topology Daemon configuration for NVIDIA vGPU drivers"
										properties: config: {
											description: "Optional: Config name representing virtual topology daemon configuration file nvidia-topologyd.conf"
											type:        "string"
										}
										type: "object"
									}
								}
								type: "object"
							}
							gds: {
								description: "GPUDirectStorage defines the spec for GDS components(Experimental)"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if GPUDirect Storage is enabled through GPU operator"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA GPUDirect Storage Driver image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA GPUDirect Storage Driver image repository"
										type:        "string"
									}
									version: {
										description: "NVIDIA GPUDirect Storage Driver image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							gfd: {
								description: "GPUFeatureDiscovery spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if deployment of GPU Feature Discovery Plugin is enabled."
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "GFD image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "GFD image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "GFD image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							kataManager: {
								description: "KataManager component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									config: {
										description: "Kata Manager config"
										properties: {
											artifactsDir: {
												default:     "/opt/nvidia-gpu-operator/artifacts/runtimeclasses"
												description: "ArtifactsDir is the directory where kata artifacts (e.g. kernel / guest images, configuration, etc.) are placed on the local filesystem."
												type:        "string"
											}
											runtimeClasses: {
												description: "RuntimeClasses is a list of kata runtime classes to configure."
												items: {
													description: "RuntimeClass defines the configuration for a kata RuntimeClass"
													properties: {
														artifacts: {
															description: "Artifacts are the kata artifacts associated with the runtime class."
															properties: {
																pullSecret: {
																	description: "PullSecret is the secret used to pull the OCI artifact."
																	type:        "string"
																}
																url: {
																	description: "URL is the path to the OCI artifact (payload) containing all artifacts associated with a kata runtime class."
																	type:        "string"
																}
															}
															required: ["url"]
															type: "object"
														}
														name: {
															description: "Name is the name of the kata runtime class."
															type:        "string"
														}
														nodeSelector: {
															additionalProperties: type: "string"
															description: "NodeSelector specifies the nodeSelector for the RuntimeClass object. This ensures pods running with the RuntimeClass only get scheduled onto nodes which support it."
															type:        "object"
														}
													}
													required: [
														"artifacts",
														"name",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of Kata Manager is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "Kata Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "Kata Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "Kata Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							mig: {
								description: "MIG spec"
								properties: strategy: {
									description: "Optional: MIGStrategy to apply for GFD and NVIDIA Device Plugin"
									enum: [
										"none",
										"single",
										"mixed",
									]
									type: "string"
								}
								type: "object"
							}
							migManager: {
								description: "MIGManager for configuration to deploy MIG Manager"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									config: {
										description: "Optional: Custom mig-parted configuration for NVIDIA MIG Manager container"
										properties: {
											default: {
												default:     "all-disabled"
												description: "Default MIG config to be applied on the node, when there is no config specified with the node label nvidia.com/mig.config"
												enum: [
													"all-disabled",
													"",
												]
												type: "string"
											}
											name: {
												default:     "default-mig-parted-config"
												description: "ConfigMap name"
												type:        "string"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA MIG Manager is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									gpuClientsConfig: {
										description: "Optional: Custom gpu-clients configuration for NVIDIA MIG Manager container"
										properties: name: {
											description: "ConfigMap name"
											type:        "string"
										}
										type: "object"
									}
									image: {
										description: "NVIDIA MIG Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA MIG Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA MIG Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							nodeStatusExporter: {
								description: "NodeStatusExporter spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if deployment of Node Status Exporter is enabled."
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "Node Status Exporter image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "Node Status Exporterimage repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "Node Status Exporterimage tag"
										type:        "string"
									}
								}
								type: "object"
							}
							operator: {
								description: "Operator component spec"
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Optional: Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects."
										type:        "object"
									}
									defaultRuntime: {
										default:     "docker"
										description: "Runtime defines container runtime type"
										enum: [
											"docker",
											"crio",
											"containerd",
										]
										type: "string"
									}
									initContainer: {
										description: "InitContainerSpec describes configuration for initContainer image used with all components"
										properties: {
											image: {
												description: "Image represents image name"
												pattern:     "[a-zA-Z0-9\\-]+"
												type:        "string"
											}
											imagePullPolicy: {
												description: "Image pull policy"
												type:        "string"
											}
											imagePullSecrets: {
												description: "Image pull secrets"
												items: type: "string"
												type: "array"
											}
											repository: {
												description: "Repository represents image repository path"
												type:        "string"
											}
											version: {
												description: "Version represents image tag(version)"
												type:        "string"
											}
										}
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Optional: Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services."
										type:        "object"
									}
									runtimeClass: {
										default: "nvidia"
										type:    "string"
									}
									use_ocp_driver_toolkit: {
										description: "UseOpenShiftDriverToolkit indicates if DriverToolkit image should be used on OpenShift to build and install driver modules"
										type:        "boolean"
									}
								}
								required: ["defaultRuntime"]
								type: "object"
							}
							psa: {
								description: "PSA defines spec for PodSecurityAdmission configuration"
								properties: enabled: {
									description: "Enabled indicates if PodSecurityAdmission configuration needs to be enabled for all Pods"
									type:        "boolean"
								}
								type: "object"
							}
							psp: {
								description: "PSP defines spec for handling PodSecurityPolicies"
								properties: enabled: {
									description: "Enabled indicates if PodSecurityPolicies needs to be enabled for all Pods"
									type:        "boolean"
								}
								type: "object"
							}
							sandboxDevicePlugin: {
								description: "SandboxDevicePlugin component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA Sandbox Device Plugin through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA Sandbox Device Plugin image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA Sandbox Device Plugin image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA Sandbox Device Plugin image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							sandboxWorkloads: {
								description: "SandboxWorkloads defines the spec for handling sandbox workloads (i.e. Virtual Machines)"
								properties: {
									defaultWorkload: {
										default:     "container"
										description: "DefaultWorkload indicates the default GPU workload type to configure worker nodes in the cluster for"
										enum: [
											"container",
											"vm-passthrough",
											"vm-vgpu",
										]
										type: "string"
									}
									enabled: {
										description: "Enabled indicates if the GPU Operator should manage additional operands required for sandbox workloads (i.e. VFIO Manager, vGPU Manager, and additional device plugins)"
										type:        "boolean"
									}
								}
								type: "object"
							}
							toolkit: {
								description: "Toolkit component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA Container Toolkit through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA Container Toolkit image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									installDir: {
										default:     "/usr/local/nvidia"
										description: "Toolkit install directory on the host"
										type:        "string"
									}
									repository: {
										description: "NVIDIA Container Toolkit image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA Container Toolkit image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							validator: {
								description: "Validator defines the spec for operator-validator daemonset"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									cuda: {
										description: "CUDA validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									driver: {
										description: "Toolkit validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "Validator image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									plugin: {
										description: "Plugin validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									repository: {
										description: "Validator image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									toolkit: {
										description: "Toolkit validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									version: {
										description: "Validator image tag"
										type:        "string"
									}
									vfioPCI: {
										description: "VfioPCI validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									vgpuDevices: {
										description: "VGPUDevices validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									vgpuManager: {
										description: "VGPUManager validator spec"
										properties: env: {
											description: "Optional: List of environment variables"
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable."
														type:        "string"
													}
													value: {
														description: "Value of the environment variable."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
								}
								type: "object"
							}
							vfioManager: {
								description: "VFIOManager for configuration to deploy VFIO-PCI Manager"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									driverManager: {
										description: "DriverManager represents configuration for NVIDIA Driver Manager"
										properties: {
											env: {
												description: "Optional: List of environment variables"
												items: {
													description: "EnvVar represents an environment variable present in a Container."
													properties: {
														name: {
															description: "Name of the environment variable."
															type:        "string"
														}
														value: {
															description: "Value of the environment variable."
															type:        "string"
														}
													}
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											image: {
												description: "Image represents NVIDIA Driver Manager image name"
												pattern:     "[a-zA-Z0-9\\-]+"
												type:        "string"
											}
											imagePullPolicy: {
												description: "Image pull policy"
												type:        "string"
											}
											imagePullSecrets: {
												description: "Image pull secrets"
												items: type: "string"
												type: "array"
											}
											repository: {
												description: "Repository represents Driver Managerrepository path"
												type:        "string"
											}
											version: {
												description: "Version represents NVIDIA Driver Manager image tag(version)"
												type:        "string"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of VFIO Manager is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "VFIO Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "VFIO Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "VFIO Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							vgpuDeviceManager: {
								description: "VGPUDeviceManager spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									config: {
										description: "NVIDIA vGPU devices configuration for NVIDIA vGPU Device Manager container"
										properties: {
											default: {
												default:     "default"
												description: "Default config name within the ConfigMap"
												type:        "string"
											}
											name: {
												description: "ConfigMap name"
												type:        "string"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA vGPU Device Manager is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA vGPU Device Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA vGPU Device Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA vGPU Device Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							vgpuManager: {
								description: "VGPUManager component spec"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									driverManager: {
										description: "DriverManager represents configuration for NVIDIA Driver Manager initContainer"
										properties: {
											env: {
												description: "Optional: List of environment variables"
												items: {
													description: "EnvVar represents an environment variable present in a Container."
													properties: {
														name: {
															description: "Name of the environment variable."
															type:        "string"
														}
														value: {
															description: "Value of the environment variable."
															type:        "string"
														}
													}
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											image: {
												description: "Image represents NVIDIA Driver Manager image name"
												pattern:     "[a-zA-Z0-9\\-]+"
												type:        "string"
											}
											imagePullPolicy: {
												description: "Image pull policy"
												type:        "string"
											}
											imagePullSecrets: {
												description: "Image pull secrets"
												items: type: "string"
												type: "array"
											}
											repository: {
												description: "Repository represents Driver Managerrepository path"
												type:        "string"
											}
											version: {
												description: "Version represents NVIDIA Driver Manager image tag(version)"
												type:        "string"
											}
										}
										type: "object"
									}
									enabled: {
										description: "Enabled indicates if deployment of NVIDIA vGPU Manager through operator is enabled"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA vGPU Manager  image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA vGPU Manager image repository"
										type:        "string"
									}
									resources: {
										description: "Optional: Define resources requests and limits for each pod"
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
									version: {
										description: "NVIDIA vGPU Manager image tag"
										type:        "string"
									}
								}
								type: "object"
							}
						}
						required: [
							"daemonsets",
							"dcgm",
							"dcgmExporter",
							"devicePlugin",
							"driver",
							"gfd",
							"nodeStatusExporter",
							"operator",
							"toolkit",
						]
						type: "object"
					}
					status: {
						description: "ClusterPolicyStatus defines the observed state of ClusterPolicy"
						properties: {
							conditions: {
								description: "Conditions is a list of conditions representing the ClusterPolicy's current state."
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
							namespace: {
								description: "Namespace indicates a namespace in which the operator is installed"
								type:        "string"
							}
							state: {
								description: "State indicates status of ClusterPolicy"
								enum: [
									"ignored",
									"ready",
									"notReady",
								]
								type: "string"
							}
						}
						required: ["state"]
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
	metadata: name: "nvidiadrivers.nvidia.com"
	spec: {
		group: "nvidia.com"
		names: {
			kind:     "NVIDIADriver"
			listKind: "NVIDIADriverList"
			plural:   "nvidiadrivers"
			shortNames: [
				"nvd",
				"nvdriver",
				"nvdrivers",
			]
			singular: "nvidiadriver"
		}
		scope: apiextensionsv1.#ClusterScoped
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.state"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "NVIDIADriver is the Schema for the nvidiadrivers API"
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
						description: "NVIDIADriverSpec defines the desired state of NVIDIADriver"
						properties: {
							annotations: {
								additionalProperties: type: "string"
								description: "Optional: Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects."
								type:        "object"
							}
							args: {
								description: "Optional: List of arguments"
								items: type: "string"
								type: "array"
							}
							certConfig: {
								description: "Optional: Custom certificates configuration for NVIDIA Driver container"
								properties: name: type: "string"
								type: "object"
							}
							driverType: {
								default:     "gpu"
								description: "DriverType defines NVIDIA driver type"
								enum: [
									"gpu",
									"vgpu",
									"vgpu-host-manager",
								]
								type: "string"
								"x-kubernetes-validations": [{
									message: "driverType is an immutable field. Please create a new NvidiaDriver resource instead when you want to change this setting."
									rule:    "self == oldSelf"
								}]
							}
							env: {
								description: "Optional: List of environment variables"
								items: {
									description: "EnvVar represents an environment variable present in a Container."
									properties: {
										name: {
											description: "Name of the environment variable."
											type:        "string"
										}
										value: {
											description: "Value of the environment variable."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							gds: {
								description: "GPUDirectStorage defines the spec for GDS driver"
								properties: {
									args: {
										description: "Optional: List of arguments"
										items: type: "string"
										type: "array"
									}
									enabled: {
										description: "Enabled indicates if GPUDirect Storage is enabled through GPU operator"
										type:        "boolean"
									}
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "NVIDIA GPUDirect Storage Driver image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "NVIDIA GPUDirect Storage Driver image repository"
										type:        "string"
									}
									version: {
										description: "NVIDIA GPUDirect Storage Driver image tag"
										type:        "string"
									}
								}
								type: "object"
							}
							image: {
								default:     "nvcr.io/nvidia/driver"
								description: "NVIDIA Driver container image name"
								type:        "string"
							}
							imagePullPolicy: {
								description: "Image pull policy"
								type:        "string"
							}
							imagePullSecrets: {
								description: "Image pull secrets"
								items: type: "string"
								type: "array"
							}
							kernelModuleConfig: {
								description: "Optional: Kernel module configuration parameters for the NVIDIA Driver"
								properties: name: type: "string"
								type: "object"
							}
							labels: {
								additionalProperties: type: "string"
								description: "Optional: Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services."
								type:        "object"
							}
							licensingConfig: {
								description: "Optional: Licensing configuration for NVIDIA vGPU licensing"
								properties: {
									name: type: "string"
									nlsEnabled: {
										description: "NLSEnabled indicates if NVIDIA Licensing System is used for licensing."
										type:        "boolean"
									}
								}
								type: "object"
							}
							livenessProbe: {
								description: "NVIDIA Driver container liveness probe settings"
								properties: {
									failureThreshold: {
										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									initialDelaySeconds: {
										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										type:        "integer"
									}
									periodSeconds: {
										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									successThreshold: {
										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									timeoutSeconds: {
										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
								}
								type: "object"
							}
							manager: {
								description: "Manager represents configuration for NVIDIA Driver Manager initContainer"
								properties: {
									env: {
										description: "Optional: List of environment variables"
										items: {
											description: "EnvVar represents an environment variable present in a Container."
											properties: {
												name: {
													description: "Name of the environment variable."
													type:        "string"
												}
												value: {
													description: "Value of the environment variable."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									image: {
										description: "Image represents NVIDIA Driver Manager image name"
										pattern:     "[a-zA-Z0-9\\-]+"
										type:        "string"
									}
									imagePullPolicy: {
										description: "Image pull policy"
										type:        "string"
									}
									imagePullSecrets: {
										description: "Image pull secrets"
										items: type: "string"
										type: "array"
									}
									repository: {
										description: "Repository represents Driver Managerrepository path"
										type:        "string"
									}
									version: {
										description: "Version represents NVIDIA Driver Manager image tag(version)"
										type:        "string"
									}
								}
								type: "object"
							}
							nodeAffinity: {
								description: "Affinity specifies node affinity rules for driver pods"
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
							nodeSelector: {
								additionalProperties: type: "string"
								description: "NodeSelector specifies a selector for installation of NVIDIA driver"
								type:        "object"
							}
							priorityClassName: {
								description: "Optional: Set priorityClassName"
								type:        "string"
							}
							rdma: {
								description: "GPUDirectRDMA defines the spec for NVIDIA Peer Memory driver"
								properties: {
									enabled: {
										description: "Enabled indicates if GPUDirect RDMA is enabled through GPU operator"
										type:        "boolean"
									}
									useHostMofed: {
										description: "UseHostMOFED indicates to use MOFED drivers directly installed on the host to enable GPUDirect RDMA"
										type:        "boolean"
									}
								}
								type: "object"
							}
							readinessProbe: {
								description: "NVIDIA Driver container readiness probe settings"
								properties: {
									failureThreshold: {
										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									initialDelaySeconds: {
										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										type:        "integer"
									}
									periodSeconds: {
										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									successThreshold: {
										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									timeoutSeconds: {
										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
								}
								type: "object"
							}
							repoConfig: {
								description: "Optional: Custom repo configuration for NVIDIA Driver container"
								properties: name: type: "string"
								type: "object"
							}
							repository: {
								description: "NVIDIA Driver repository"
								type:        "string"
							}
							resources: {
								description: "Optional: Define resources requests and limits for each pod"
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
							startupProbe: {
								description: "NVIDIA Driver container startup probe settings"
								properties: {
									failureThreshold: {
										description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									initialDelaySeconds: {
										description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										type:        "integer"
									}
									periodSeconds: {
										description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									successThreshold: {
										description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
									timeoutSeconds: {
										description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
										format:      "int32"
										minimum:     1
										type:        "integer"
									}
								}
								type: "object"
							}
							tolerations: {
								description: "Optional: Set tolerations"
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
							useOpenKernelModules: {
								description: "UseOpenKernelModules indicates if the open GPU kernel modules should be used"
								type:        "boolean"
							}
							usePrecompiled: {
								description: "UsePrecompiled indicates if deployment of NVIDIA Driver using pre-compiled modules is enabled"
								type:        "boolean"
								"x-kubernetes-validations": [{
									message: "usePrecompiled is an immutable field. Please create a new NvidiaDriver resource instead when you want to change this setting."
									rule:    "self == oldSelf"
								}]
							}
							version: {
								description: "NVIDIA Driver version (or just branch for precompiled drivers)"
								type:        "string"
							}
							virtualTopologyConfig: {
								description: "Optional: Virtual Topology Daemon configuration for NVIDIA vGPU drivers"
								properties: name: {
									description: "Optional: Config name representing virtual topology daemon configuration file nvidia-topologyd.conf"
									type:        "string"
								}
								type: "object"
							}
						}
						required: [
							"driverType",
							"image",
						]
						type: "object"
					}
					status: {
						description: "NVIDIADriverStatus defines the observed state of NVIDIADriver"
						properties: {
							conditions: {
								description: "Conditions is a list of conditions representing the NVIDIADriver's current state."
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
							namespace: {
								description: "Namespace indicates a namespace in which the operator and driver are installed"
								type:        "string"
							}
							state: {
								description: "INSERT ADDITIONAL STATUS FIELD - define observed state of cluster Important: Run \"make\" to regenerate code after modifying this file State indicates status of NVIDIADriver instance"
								enum: [
									"ignored",
									"ready",
									"notReady",
								]
								type: "string"
							}
						}
						required: ["state"]
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
