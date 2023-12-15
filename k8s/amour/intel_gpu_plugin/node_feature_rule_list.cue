package intel_gpu_plugin

import "k8s.io/api/core/v1"

#NodeFeatureRuleList: v1.#List & {
	apiVersion: "nfd.k8s-sigs.io/v1alpha1"
	kind:       "NodeFeatureRuleList"
	items: [...{
		apiVersion: "nfd.k8s-sigs.io/v1alpha1"
		kind:       "NodeFeatureRule"
	}]
}

#NodeFeatureRuleList: items: [{
	metadata: name: "intel-dp-devices"
	spec: rules: [{
		name: "intel.dlb"
		labels: "intel.feature.node.kubernetes.io/dlb": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0b40"]
				}
				device: {
					op: "In"
					value: ["2710"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}, {
			feature: "kernel.loadedmodule"
			matchExpressions: dlb2: op: "Exists"
		}]
	}, {
		name: "intel.dsa"
		labels: "intel.feature.node.kubernetes.io/dsa": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0880"]
				}
				device: {
					op: "In"
					value: ["0b25"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}, {
			feature: "kernel.loadedmodule"
			matchExpressions: idxd: op: "Exists"
		}]
	}, {
		name: "intel.fpga-arria10"
		labels: "intel.feature.node.kubernetes.io/fpga-arria10": "true"
		matchAny: [{
			matchFeatures: [{
				feature: "kernel.loadedmodule"
				matchExpressions: dfl_pci: op: "Exists"
			}]
		}, {
			matchFeatures: [{
				feature: "kernel.loadedmodule"
				matchExpressions: intel_fpga_pci: op: "Exists"
			}]
		}]
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["1200"]
				}
				device: {
					op: "In"
					value: ["09c4"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu"
		labels: "intel.feature.node.kubernetes.io/gpu": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0300", "0380"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}, {
			feature: "kernel.loadedmodule"
			matchExpressions: i915: op: "Exists"
		}]
	}, {
		name: "intel.iaa"
		labels: "intel.feature.node.kubernetes.io/iaa": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0880"]
				}
				device: {
					op: "In"
					value: ["0cfe"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}, {
			feature: "kernel.loadedmodule"
			matchExpressions: idxd: op: "Exists"
		}]
	}, {
		name: "intel.qat"
		labels: "intel.feature.node.kubernetes.io/qat": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0b40"]
				}
				device: {
					op: "In"
					value: ["37c8", "4940"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}, {
			feature: "kernel.loadedmodule"
			matchExpressions: intel_qat: op: "Exists"
		}]
	}, {
		name: "intel.sgx"
		labels: "intel.feature.node.kubernetes.io/sgx": "true"
		matchFeatures: [{
			feature: "cpu.cpuid"
			matchExpressions: {
				SGX: op:   "Exists"
				SGXLC: op: "Exists"
			}
		}, {
			feature: "cpu.sgx"
			matchExpressions: enabled: op: "IsTrue"
		}, {
			feature: "kernel.config"
			matchExpressions: X86_SGX: op: "Exists"
		}]
	}]
}, {
	metadata: name: "intel-gpu-platform-labeling"
	spec: rules: [{
		name: "intel.gpu.fractionalresources"
		extendedResources: {
			"gpu.intel.com/memory.max": "@local.label.gpu.intel.com/memory.max"
			"gpu.intel.com/millicores": "@local.label.gpu.intel.com/millicores"
			"gpu.intel.com/tiles":      "@local.label.gpu.intel.com/tiles"
		}
		matchFeatures: [{
			feature: "local.label"
			matchExpressions: {
				"gpu.intel.com/memory.max": op: "Exists"
				"gpu.intel.com/millicores": op: "Exists"
				"gpu.intel.com/tiles": op:      "Exists"
			}
		}]
	}, {
		name: "intel.gpu.generic.deviceid"
		labelsTemplate: """
			{{ range .pci.device }}gpu.intel.com/device-id.{{ .class }}-{{ .device }}.present=true
			{{ end }}

			"""
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: [
						"0300",
						"0380",
					]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name:           "intel.gpu.generic.count.300"
		labelsTemplate: "gpu.intel.com/device-id.0300-{{ (index .pci.device 0).device }}.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0300"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name:           "intel.gpu.generic.count.380"
		labelsTemplate: "gpu.intel.com/device-id.0380-{{ (index .pci.device 0).device }}.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.max.1100"
		labels: "gpu.intel.com/product": "Max_1100"
		labelsTemplate: "gpu.intel.com/device.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				device: {
					op: "In"
					value: ["0bda"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.max.1550"
		labels: "gpu.intel.com/product": "Max_1550"
		labelsTemplate: "gpu.intel.com/device.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				device: {
					op: "In"
					value: ["0bd5"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.max.series"
		labels: "gpu.intel.com/family": "Max_Series"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				device: {
					op: "In"
					value: [
						"0bda",
						"0bd5",
						"0bd9",
						"0bdb",
						"0bd7",
						"0bd6",
						"0bd0",
					]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.flex.170"
		labels: {
			"gpu.intel.com/family":  "Flex_Series"
			"gpu.intel.com/product": "Flex_170"
		}
		labelsTemplate: "gpu.intel.com/device.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				device: {
					op: "In"
					value: ["56c0"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.flex.140"
		labels: {
			"gpu.intel.com/family":  "Flex_Series"
			"gpu.intel.com/product": "Flex_140"
		}
		labelsTemplate: "gpu.intel.com/device.count={{ len .pci.device }}"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0380"]
				}
				device: {
					op: "In"
					value: ["56c1"]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}, {
		name: "intel.gpu.a.series"
		labels: "gpu.intel.com/family": "A_Series"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: ["0300"]
				}
				device: {
					op: "In"
					value: [
						"56a6",
						"56a5",
						"56a1",
						"56a0",
						"5694",
						"5693",
						"5692",
						"5691",
						"5690",
						"56b3",
						"56b2",
						"56a4",
						"56a3",
						"5697",
						"5696",
						"5695",
						"56b1",
						"56b0",
					]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}]
}]
