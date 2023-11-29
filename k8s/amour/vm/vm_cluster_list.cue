package vm

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	"k8s.io/api/core/v1"
)

#VMClusterList: victoriametricsv1beta1.#VMClusterList & {
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
				(v1.#ResourceCPU):    "200m"
				(v1.#ResourceMemory): "256Mi"
			}
			securityContext: defaultPodSecurityContext
			containers: [{
				name:            "vmselect"
				securityContext: defaultsecurityContext
			}]
			cacheMountPath: "/select-cache"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "8Gi"
			}
			extraArgs: {
				"dedup.minScrapeInterval":     "30s"
				"search.minStalenessInterval": "5m"
				"vmalert.proxyURL":            "http://vmalert-\(#Name):8080"
			}
			serviceSpec: {
				// metadata: annotations: "tailscale.com/hostname": "vmselect-unwind-k8s"
				spec: {
					ports: [{
						name:       "http"
						port:       80
						targetPort: "http"
					}]
					// type:              v1.#ServiceTypeLoadBalancer
					// loadBalancerClass: "tailscale"
				}
			}
		}
		vminsert: {
			replicaCount: 2
			resources: limits: {
				(v1.#ResourceCPU):    "200m"
				(v1.#ResourceMemory): "256Mi"
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
				(v1.#ResourceCPU):    "200m"
				(v1.#ResourceMemory): "1.2Gi"
			}
			securityContext: defaultPodSecurityContext
			containers: [{
				name:            "vmstorage"
				securityContext: defaultsecurityContext
			}]
			storageDataPath: "/vm-data"
			storage: volumeClaimTemplate: spec: {
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "16Gi"
			}
			extraArgs: "dedup.minScrapeInterval": "30s"
		}
	}
}]
