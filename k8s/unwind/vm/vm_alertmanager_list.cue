package vm

import "k8s.io/api/core/v1"

// TODO: Use generated types.
//
// https://github.com/cue-lang/cue/issues/2466
#VMAlertmanagerList: v1.#List & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertmanagerList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlertmanager"
	}]
}

#VMAlertmanagerList: items: [{
	spec: {
		replicaCount: 2
		storage: volumeClaimTemplate: spec: {
			storageClassName: "rook-ceph-nvme-ec-delete-block"
			resources: requests: storage: "512Mi"
		}
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
			name: "alertmanager"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		serviceSpec: {
			metadata: annotations: "tailscale.com/hostname": "vmalertmanager-unwind-k8s"
			spec: {
				ports: [{
					name:       "http"
					port:       80
					targetPort: "web"
				}]
				type:              v1.#ServiceTypeLoadBalancer
				loadBalancerClass: "tailscale"
			}
		}
		selectAllByDefault: true
	}
}]
