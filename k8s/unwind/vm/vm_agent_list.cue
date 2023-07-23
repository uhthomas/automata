package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMAgentList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAgentList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAgent"
	}]
}

#VMAgentList: items: [{
	spec: {
		replicaCount: 3
		resources: limits: {
			cpu:    "400m"
			memory: "512Mi"
		}
		securityContext: {
			runAsUser:    1000
			runAsGroup:   3000
			runAsNonRoot: true
			fsGroup:      2000
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}
		externalLabels: cluster: "unwind"
		remoteWrite: [{url: "http://vminsert-vm:8480/insert/0/prometheus/api/v1/write"}]
		selectAllByDefault: true
		serviceSpec: {
			metadata: annotations: "tailscale.com/hostname": "vmagent-unwind-k8s"
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
}]
