package melonade_backup

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
					image: "syncthing/syncthing:1.28.1@sha256:289b4ca86d77e4938d3e0af7d11f5c0a0fb786e469d5f697c25ab0f9e1f29f34"
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
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: (v1.#ResourceStorage): "8Gi"
			}
		}]
		serviceName: metadata.name
	}
}]
