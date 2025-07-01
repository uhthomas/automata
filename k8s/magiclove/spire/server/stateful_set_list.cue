package server

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
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: {
				namespace: "spire"
				labels: "app.kubernetes.io/name": #Name
			}
			spec: {
				volumes: [{
					name: "spire-config"
					configMap: name: #Name
				}]
				containers: [{
					name:  "spire-server"
					image: "ghcr.io/spiffe/spire-server:1.12.4"
					args: [
						"-config",
						"/run/spire/config/server.conf",
					]
					ports: [{
						name:          "healthz"
						containerPort: 8080
					}, {
						name:          "grpc"
						containerPort: 8081
					}]
					volumeMounts: [{
						name:      "spire-config"
						mountPath: "/run/spire/config"
						readOnly:  true
					}, {
						name:      "data"
						mountPath: "/run/spire/data"
					}]
					livenessProbe: {
						httpGet: {
							path: "/live"
							port: "healthz"
						}
						failureThreshold:    2
						initialDelaySeconds: 15
						periodSeconds:       60
						timeoutSeconds:      3
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "healthz"
						}
						initialDelaySeconds: 5
						periodSeconds:       5
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				serviceAccountName: #Name
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "64Mi"
			}
		}]
		serviceName: #Name
	}
}]
