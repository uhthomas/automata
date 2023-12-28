package vm

import (
	victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"
	"k8s.io/api/core/v1"
)

#VMAlertList: victoriametricsv1beta1.#VMAlertList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlert"
	}]
}

#VMAlertList: items: [{
	spec: {
		image: tag: "v1.91.3"
		replicaCount: 2
		resources: limits: {
			(v1.#ResourceCPU):    "50m"
			(v1.#ResourceMemory): "128Mi"
		}
		securityContext: {
			runAsUser:    1000
			runAsGroup:   3000
			runAsNonRoot: true
			fsGroup:      2000
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}
		containers: [{
			name: "vmalert"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		evaluationInterval: "1m"
		selectAllByDefault: true
		notifiers: [{selector: labelSelector: matchLabels: "app.kubernetes.io/name": #Name}]
		remoteWrite: url:                           "http://vmsingle-vm:8429/api/v1/write"
		remoteRead: url:                            "http://vmsingle-vm:8429"
		datasource: url:                            "http://vmsingle-vm:8429"
		extraArgs: "remoteWrite.disablePathAppend": "true"
	}
}]
