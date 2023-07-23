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
			replicaCount: 3
			resources: limits: {
				cpu:    "1"
				memory: "512Mi"
			}
			securityContext: defaultSecurityContext
			cacheMountPath:  "/select-cache"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
			serviceSpec: {
				metadata: annotations: "tailscale.com/hostname": "vmselect-unwind-k8s"
				spec: {
					ports: [{
						name:       "http"
						port:       80
						targetPort: "http"
					}]
					type:              v1.#ServiceTypeLoadBalancer
					loadBalancerClass: "tailscale"
				}
			}
		}
		vminsert: {
			replicaCount: 3
			resources: limits: {
				cpu:    "1"
				memory: "512Mi"
			}
			securityContext: defaultSecurityContext
			extraArgs: "maxLabelsPerTimeseries": "100"
		}
		vmstorage: {
			replicaCount: 3
			resources: limits: {
				cpu:    "1"
				memory: "1Gi"
			}
			securityContext: defaultSecurityContext
			storageDataPath: "/vm-data"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "16Gi"
			}
			extraArgs: "dedup.minScrapeInterval": "30s"
		}
	}
}]
