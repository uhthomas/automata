package vm

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	"k8s.io/api/core/v1"
)

#VMAgentList: victoriametricsv1beta1.#VMAgentList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAgentList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAgent"
	}]
}

#VMAgentList: items: [{
	spec: {
		resources: limits: {
			(v1.#ResourceCPU):    "500m"
			(v1.#ResourceMemory): "768Mi"
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
			name: "vmagent"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		scrapeInterval: "30s"
		externalLabels: cluster: "amour"
		remoteWrite: [{url: "http://vmsingle-vm:8429/api/v1/write"}]
		selectAllByDefault: true
		serviceSpec: spec: ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		statefulMode: true
		statefulStorage: volumeClaimTemplate: spec: {
			storageClassName: "rook-ceph-nvme"
			resources: requests: (v1.#ResourceStorage): "4Gi"
		}
	}
}]
