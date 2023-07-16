package breakfast_backup

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "data"
					persistentVolumeClaim: claimName: #Name
				}]
				containers: [{
					name:  "syncthing"
					image: "syncthing/syncthing:1.23.6@sha256:88d6c8516d27876f6dacf7b9b544075d70e0d42480a2e85ec4dbb313764cc1e6"
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
						cpu:    "1"
						memory: "2Gi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/syncthing"
					}, {
						name:      "config"
						mountPath: "/var/syncthing/config"
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
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
		}]
		serviceName: metadata.name
	}
}]
