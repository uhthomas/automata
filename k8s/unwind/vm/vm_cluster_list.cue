package vm

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
		retentionPeriod:   "2y"
		replicationFactor: 2

		let defaultSecurityContext = {
			runAsUser:    1000
			runAsGroup:   3000
			runAsNonRoot: true
			fsGroup:      2000
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}

		vmselect: {
			replicaCount:    2
			securityContext: defaultSecurityContext
			cacheMountPath:  "/select-cache"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
			resources: limits: {
				cpu:    "300m"
				memory: "300Mi"
			}
		}
		vminsert: {
			replicaCount:    2
			securityContext: defaultSecurityContext
			resources: limits: {
				cpu:    "300m"
				memory: "300Mi"
			}
		}
		vmstorage: {
			replicaCount:    2
			securityContext: defaultSecurityContext
			storageDataPath: "/vm-data"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "16Gi"
			}
			resources: limits: {
				cpu:    "500m"
				memory: "500Mi"
			}
		}
	}
}]
