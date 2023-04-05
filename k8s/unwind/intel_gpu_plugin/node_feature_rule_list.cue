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
}]
