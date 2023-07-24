package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMAlertList: v1.#List & {
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
		replicaCount: 3
		resources: limits: {
			cpu:    "200m"
			memory: "256Mi"
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
		evaluationInterval: "15s"
		selectAllByDefault: true
		notifiers: [{selector: labelSelector: matchLabels: "app.kubernetes.io/name": #Name}]
		remoteWrite: url:                           "http://vminsert-vm:8480/insert/0/prometheus/api/v1/write"
		remoteRead: url:                            "http://vmselect-vm:8481/select/0/prometheus"
		datasource: url:                            "http://vmselect-vm:8481/select/0/prometheus"
		extraArgs: "remoteWrite.disablePathAppend": "true"
	}
}]
