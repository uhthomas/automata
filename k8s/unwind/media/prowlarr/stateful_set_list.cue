package prowlarr

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
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}, {
					name: "secrets-store-inline"
					csi: {
						driver:   "secrets-store.csi.k8s.io"
						readOnly: true
						volumeAttributes: secretProviderClass: "\(#Name)-tailscale"
					}
				}]
				containers: [{
					name:  #Name
					image: "linuxserver/prowlarr:\(#Version)@sha256:05fa9628c7c86c50faf208d519b5d4721609e000f7cbf6f5b7e34491e4bcdca8"
					ports: [{
						name:          "http"
						containerPort: 9696
					}]
					resources: {
						limits: {
							cpu:    "1"
							memory: "2Gi"
						}
						requests: {
							cpu:    "1"
							memory: "1Gi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}]
					livenessProbe: httpGet: {
						path: "/health"
						port: "http"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						// capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "tailscale"
					image: "tailscale/tailscale:v1.38.2@sha256:176f2bca0906d605f411f189bd6a9747a1cf8418ca5fa55908879497774cb73b"
					env: [{
						name:  "TS_KUBE_SECRET"
						value: "\(#Name)-tailscale-state"
					}, {
						name:  "TS_USERSPACE"
						value: "true"
					}, {
						name: "TS_AUTHKEY"
						valueFrom: secretKeyRef: {
							name: "\(#Name)-tailscale"
							key:  "authkey"
						}
					}, {
						name:  "TS_TAILSCALED_EXTRA_ARGS"
						value: "--socks5-server=localhost:1055"
					}, {
						name:  "TS_EXTRA_ARGS"
						value: "--exit-node=100.87.32.47"
					}]
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "secrets-store-inline"
						readOnly:  true
						mountPath: "/mnt/secrets-store"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						runAsUser:                1000
						runAsGroup:               3000
						runAsNonRoot:             true
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
				// The s6 overlay requires root... It may be
				// better to build our own image instead.
				//
				// https://github.com/linuxserver/docker-radarr/issues/203
				securityContext: {
					runAsUser:    0
					runAsGroup:   0
					runAsNonRoot: false
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "32Gi"
			}
		}]
		serviceName: #Name
	}
}]
