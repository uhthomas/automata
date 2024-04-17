package vm

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	"k8s.io/api/core/v1"
)

#VMSingleList: victoriametricsv1beta1.#VMSingleList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMSingleList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMSingle"
	}]
}

#VMSingleList: items: [{
	spec: {
		storage: {
			storageClassName: "rook-ceph-nvme"
			resources: requests: (v1.#ResourceStorage): "16Gi"
			accessModes: [v1.#ReadWriteOnce]
		}
		resources: limits: {
			(v1.#ResourceCPU):    "2"
			(v1.#ResourceMemory): "1.5Gi"
		}
		securityContext: {
			runAsUser:           1000
			runAsGroup:          3000
			runAsNonRoot:        true
			fsGroup:             2000
			fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}
		containers: [{
			name: "vmsingle"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		removePvcAfterDelete: true
		retentionPeriod:      "2y"
		extraArgs: {
			"maxLabelsPerTimeseries": "150"
			"vmalert.proxyURL":       "http://vmalert-\(#Name):8080"
		}
	}
}]
