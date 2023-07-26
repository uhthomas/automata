package vm4697

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMClusterList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMClusterList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMCluster"
	}]
}

#VMClusterList: items: [{
	spec: {
		retentionPeriod:   "1w"
		replicationFactor: 2

		let defaultPodSecurityContext = {
			runAsUser:    1000
			runAsGroup:   3000
			runAsNonRoot: true
			fsGroup:      2000
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}

		let defaultsecurityContext = {
			capabilities: drop: ["ALL"]
			readOnlyRootFilesystem:   true
			allowPrivilegeEscalation: false
		}

		vmselect: {
			replicaCount: 2
			resources: limits: {
				cpu:    "1"
				memory: "512Mi"
			}
			securityContext: defaultPodSecurityContext
			containers: [{
				name:            "vmselect"
				securityContext: defaultsecurityContext
			}]
			cacheMountPath: "/select-cache"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
		}
		vminsert: {
			replicaCount: 2
			resources: limits: {
				cpu:    "1"
				memory: "512Mi"
			}
			securityContext: defaultPodSecurityContext
			containers: [{
				name:            "vminsert"
				securityContext: defaultsecurityContext
			}]
			extraArgs: "maxLabelsPerTimeseries": "100"
		}
		vmstorage: {
			replicaCount: 2
			resources: limits: {
				cpu:    "1"
				memory: "1.5Gi"
			}
			securityContext: defaultPodSecurityContext
			containers: [{
				name:            "vmstorage"
				securityContext: defaultsecurityContext
			}]
			storageDataPath: "/vm-data"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "16Gi"
			}
		}
	}
}]
