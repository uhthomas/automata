package vm

import (
	operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"
	"k8s.io/api/core/v1"
)

#VMAlertList: operatorv1beta1.#VMAlertList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlert"
	}]
}

#VMAlertList: items: [{
	spec: {
		resources: limits: {
			(v1.#ResourceCPU):    "150m"
			(v1.#ResourceMemory): "128Mi"
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
			name: "vmalert"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		evaluationInterval: "1m"
		selectAllByDefault: true
		serviceSpec: spec: ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		notifiers: [{selector: labelSelector: matchLabels: "app.kubernetes.io/name": #Name}]
		remoteWrite: url: "http://vmsingle-vm:8429/api/v1/write"
		remoteRead: url:  "http://vmsingle-vm:8429"
		datasource: url:  "http://vmsingle-vm:8429"
		extraArgs: {
			"external.url":                  "https://vmalert-magiclove.hipparcos.net"
			"remoteWrite.disablePathAppend": "true"
		}
	}
}]
