package vm

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	"k8s.io/api/core/v1"
)

#VMAlertmanagerList: victoriametricsv1beta1.#VMAlertmanagerList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertmanagerList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlertmanager"
	}]
}

#VMAlertmanagerList: items: [{
	spec: {
		image: tag: "main@sha256:889198464d4f78f7b0781d5ab76fa7c97a054dc3ba0f00395b1a4efdb9f7edd4"
		configSecret: "vmalertmanager-vm-config"
		storage: volumeClaimTemplate: spec: {
			storageClassName: "rook-ceph-nvme"
			resources: requests: (v1.#ResourceStorage): "512Mi"
		}
		resources: limits: {
			(v1.#ResourceCPU):    "100m"
			(v1.#ResourceMemory): "64Mi"
		}
		securityContext: {
			runAsUser:    1000
			runAsGroup:   3000
			runAsNonRoot: true
			fsGroup:      2000
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}
		containers: [{
			name: "alertmanager"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		serviceSpec: spec: ports: [{
			name:       "http"
			port:       80
			targetPort: "web"
		}]
		selectAllByDefault: true
	}
}]
