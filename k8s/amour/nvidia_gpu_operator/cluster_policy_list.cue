package nvidia_gpu_operator

import (
	nvidiagpuoperatorv1 "github.com/NVIDIA/gpu-operator/api/v1"
	"k8s.io/api/core/v1"
)

#ClusterPolicyList: nvidiagpuoperatorv1.#ClusterPolicyList & {
	apiVersion: "nvidia.com/v1"
	kind:       "ClusterPolicyList"
	items: [...{
		apiVersion: "nvidia.com/v1"
		kind:       "ClusterPolicy"
	}]
}

#ClusterPolicyList: items: [{
	metadata: name: "cluster-policy"
	spec: {
		operator: {
			defaultRuntime: "docker"
			runtimeClass:   "nvidia"
			initContainer: {
				repository:      "nvcr.io/nvidia"
				image:           "cuda"
				version:         "12.3.1-base-ubi8"
				imagePullPolicy: "IfNotPresent"
			}
		}
		daemonsets: {
			tolerations: [{
				effect:   v1.#TaintEffectNoSchedule
				key:      "nvidia.com/gpu"
				operator: v1.#TolerationOpExists
			}]
			priorityClassName: "system-node-critical"
			updateStrategy:    "RollingUpdate"
			rollingUpdate: maxUnavailable: "1"
		}
		validator: {
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "gpu-operator-validator"
			version:         "v23.9.1"
			imagePullPolicy: "IfNotPresent"
			plugin: env: [{
				name:  "WITH_WORKLOAD"
				value: "false"
			}]
		}
		mig: strategy: "single"
		psp: enabled:  false
		psa: enabled:  false
		cdi: {
			enabled: false
			default: false
		}
		driver: {
			enabled:              true
			useNvidiaDriverCRD:   false
			useOpenKernelModules: false
			usePrecompiled:       false
			repository:           "nvcr.io/nvidia"
			image:                "driver"
			version:              "535.129.03"
			imagePullPolicy:      "IfNotPresent"
			startupProbe: {
				failureThreshold:    120
				initialDelaySeconds: 60
				periodSeconds:       10
				timeoutSeconds:      60
			}
			rdma: {
				enabled:      false
				useHostMofed: false
			}
			manager: {
				repository:      "nvcr.io/nvidia/cloud-native"
				image:           "k8s-driver-manager"
				version:         "v0.6.5"
				imagePullPolicy: "IfNotPresent"
				env: [{
					name:  "ENABLE_GPU_POD_EVICTION"
					value: "true"
				}, {
					name:  "ENABLE_AUTO_DRAIN"
					value: "false"
				}, {
					name:  "DRAIN_USE_FORCE"
					value: "false"
				}, {
					name:  "DRAIN_POD_SELECTOR_LABEL"
					value: ""
				}, {
					name:  "DRAIN_TIMEOUT_SECONDS"
					value: "0s"
				}, {
					name:  "DRAIN_DELETE_EMPTYDIR_DATA"
					value: "false"
				}]
			}
			repoConfig: configMapName: ""
			certConfig: name:          ""
			licensingConfig: {
				configMapName: ""
				nlsEnabled:    true
			}
			virtualTopology: config:  ""
			kernelModuleConfig: name: ""
			upgradePolicy: {
				autoUpgrade:         true
				maxParallelUpgrades: 1
				maxUnavailable:      "25%"
				waitForCompletion: timeoutSeconds: 0
				podDeletion: {
					force:          false
					timeoutSeconds: 300
					deleteEmptyDir: false
				}
				drain: {
					enable:         false
					force:          false
					timeoutSeconds: 300
					deleteEmptyDir: false
				}
			}
		}
		vgpuManager: {
			enabled:         false
			image:           "vgpu-manager"
			imagePullPolicy: "IfNotPresent"
			driverManager: {
				repository:      "nvcr.io/nvidia/cloud-native"
				image:           "k8s-driver-manager"
				version:         "v0.6.4"
				imagePullPolicy: "IfNotPresent"
				env: [{
					name:  "ENABLE_GPU_POD_EVICTION"
					value: "false"
				}, {
					name:  "ENABLE_AUTO_DRAIN"
					value: "false"
				}]
			}
		}
		kataManager: {
			enabled: false
			config: {
				artifactsDir: "/opt/nvidia-gpu-operator/artifacts/runtimeclasses"
				runtimeClasses: [{
					artifacts: {
						pullSecret: ""
						url:        "nvcr.io/nvidia/cloud-native/kata-gpu-artifacts:ubuntu22.04-535.54.03"
					}
					name: "kata-qemu-nvidia-gpu"
					nodeSelector: {}
				}, {
					artifacts: {
						pullSecret: ""
						url:        "nvcr.io/nvidia/cloud-native/kata-gpu-artifacts:ubuntu22.04-535.86.10-snp"
					}
					name: "kata-qemu-nvidia-gpu-snp"
					nodeSelector: "nvidia.com/cc.capable": "true"
				}]
			}
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "k8s-kata-manager"
			version:         "v0.1.2"
			imagePullPolicy: "IfNotPresent"
		}
		vfioManager: {
			enabled:         true
			repository:      "nvcr.io/nvidia"
			image:           "cuda"
			version:         "12.3.1-base-ubi8"
			imagePullPolicy: "IfNotPresent"
			driverManager: {
				repository:      "nvcr.io/nvidia/cloud-native"
				image:           "k8s-driver-manager"
				version:         "v0.6.2"
				imagePullPolicy: "IfNotPresent"
				env: [{
					name:  "ENABLE_GPU_POD_EVICTION"
					value: "false"
				}, {
					name:  "ENABLE_AUTO_DRAIN"
					value: "false"
				}]
			}
		}
		vgpuDeviceManager: {
			enabled:         true
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "vgpu-device-manager"
			version:         "v0.2.4"
			imagePullPolicy: "IfNotPresent"
			config: {
				default: "default"
				name:    ""
			}
		}
		ccManager: {
			enabled:         false
			defaultMode:     "off"
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "k8s-cc-manager"
			version:         "v0.1.1"
			imagePullPolicy: "IfNotPresent"
			env: []
		}
		toolkit: {
			enabled:         true
			repository:      "nvcr.io/nvidia/k8s"
			image:           "container-toolkit"
			version:         "v1.14.3-ubuntu20.04"
			imagePullPolicy: "IfNotPresent"
			installDir:      "/usr/local/nvidia"
		}
		devicePlugin: {
			enabled:         true
			repository:      "nvcr.io/nvidia"
			image:           "k8s-device-plugin"
			version:         "v0.14.3-ubi8"
			imagePullPolicy: "IfNotPresent"
			env: [{
				name:  "PASS_DEVICE_SPECS"
				value: "true"
			}, {
				name:  "FAIL_ON_INIT_ERROR"
				value: "true"
			}, {
				name:  "DEVICE_LIST_STRATEGY"
				value: "envvar"
			}, {
				name:  "DEVICE_ID_STRATEGY"
				value: "uuid"
			}, {
				name:  "NVIDIA_VISIBLE_DEVICES"
				value: "all"
			}, {
				name:  "NVIDIA_DRIVER_CAPABILITIES"
				value: "all"
			}]
		}
		dcgm: {
			enabled:         false
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "dcgm"
			version:         "3.3.0-1-ubuntu22.04"
			imagePullPolicy: "IfNotPresent"
			hostPort:        5555
		}
		dcgmExporter: {
			enabled:         true
			repository:      "nvcr.io/nvidia/k8s"
			image:           "dcgm-exporter"
			version:         "3.3.0-3.2.0-ubuntu22.04"
			imagePullPolicy: "IfNotPresent"
			env: [{
				name:  "DCGM_EXPORTER_LISTEN"
				value: ":9400"
			}, {
				name:  "DCGM_EXPORTER_KUBERNETES"
				value: "true"
			}, {
				name:  "DCGM_EXPORTER_COLLECTORS"
				value: "/etc/dcgm-exporter/dcp-metrics-included.csv"
			}]
			serviceMonitor: {
				additionalLabels: {}
				enabled:     false
				honorLabels: false
				interval:    "15s"
				relabelings: []
			}
		}
		gfd: {
			enabled:         true
			repository:      "nvcr.io/nvidia"
			image:           "gpu-feature-discovery"
			version:         "v0.8.2-ubi8"
			imagePullPolicy: "IfNotPresent"
			env: [{
				name:  "GFD_SLEEP_INTERVAL"
				value: "60s"
			}, {
				name:  "GFD_FAIL_ON_INIT_ERROR"
				value: "true"
			}]
		}
		migManager: {
			enabled:         true
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "k8s-mig-manager"
			version:         "v0.5.5-ubuntu20.04"
			imagePullPolicy: "IfNotPresent"
			env: [{
				name:  "WITH_REBOOT"
				value: "false"
			}]
			config: {
				default: "all-disabled"
				name:    "default-mig-parted-config"
			}
			gpuClientsConfig: name: ""
		}
		nodeStatusExporter: {
			enabled:         false
			repository:      "nvcr.io/nvidia/cloud-native"
			image:           "gpu-operator-validator"
			version:         "v23.9.1"
			imagePullPolicy: "IfNotPresent"
		}
		sandboxWorkloads: {
			enabled:         false
			defaultWorkload: "container"
		}
		sandboxDevicePlugin: {
			enabled:         true
			repository:      "nvcr.io/nvidia"
			image:           "kubevirt-gpu-device-plugin"
			version:         "v1.2.4"
			imagePullPolicy: "IfNotPresent"
		}
	}
}]
