package breakfast

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#StatefulSetList: appsv1.#StatefulSetList & {
	apiVersion: "apps/v1"
	kind:       "StatefulSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
	}]
}

#StatefulSetList: items: [{
	metadata: name: "\(#Name)-syncthing"
	spec: {
		replicas: 0
		selector: matchLabels: "app.kubernetes.io/name": "\(#Name)-syncthing"
		template: {
			metadata: labels: "app.kubernetes.io/name": "\(#Name)-syncthing"
			spec: {
				volumes: [{
					name: "data"
					persistentVolumeClaim: claimName: #Name
				}]
				containers: [{
					name:  "syncthing"
					image: "syncthing/syncthing:edge@sha256:a200af1e5b2aee7c184c848c3af179d6fedca55e899c15a9c2851c35501f1943"
					ports: [{
						name:          "http"
						containerPort: 8384
					}, {
						name:          "sync"
						containerPort: 22000
					}, {
						name:          "sync-udp"
						containerPort: 22000
						protocol:      v1.#ProtocolUDP
					}, {
						name:          "discovery"
						containerPort: 21027
						protocol:      v1.#ProtocolUDP
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "2Gi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/var/syncthing/config"
					}, {
						name:      "data"
						mountPath: "/data"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "4Gi"
			}
		}]
		serviceName: metadata.name
	}
}]
