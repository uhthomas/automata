package kanidm

import "k8s.io/api/core/v1"

#KanidmList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "Kanidm"
	}]
}

#KanidmList: items: [{
	spec: {
		domain:          "kanidm-magiclove.hipparcos.net"
		image:           "kanidm/server:1.11.2"
		imagePullPolicy: "IfNotPresent"
		securityContext: {
			runAsUser:           1000
			runAsGroup:          3000
			runAsNonRoot:        true
			fsGroup:             2000
			fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
			seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
		}
		containers: [{
			name: "kanidm"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		initContainers: [{
			name: "kanidm-generate-replication-config"
			securityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}]
		oauth2ClientNamespaceSelector: matchExpressions: [{
			key:      "kubernetes.io/metadata.name"
			operator: "In"
			values: ["grafana", "headlamp", "immich", "kanidm"]
		}]
		replicaGroups: [{
			name:     "default"
			replicas: 1
		}]
		storage: volumeClaimTemplate: spec: {
			storageClassName: "rook-ceph-nvme"
			resources: requests: storage: "256Mi"
			accessModes: ["ReadWriteOnce"]
		}
	}
}]
