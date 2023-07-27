package tdarr

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
					name: "media"
					persistentVolumeClaim: claimName: "media"
				}]
				containers: [{
					name:  #Name
					image: "haveagitgat/tdarr_acc:\(#Version)"
					// image: "ghcr.io/haveagitgat/tdarr:\(#Version)@sha256:75e128ebb10f769615e5878fc2dad618adbd17a01e3a96060338e28dc8978a1c"
					ports: [{
						name:          "http"
						containerPort: 8265
					}, {
						name:          "server"
						containerPort: 8266
					}]
					env: [{
						name:  "PUID"
						value: "1000"
					}, {
						name:  "PGID"
						value: "3000"
					}, {
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "nodeName"
						value: "$(POD_NAME)"
					}, {
						name:  "internalNode"
						value: "true"
					}]
					resources: {
						limits: {
							(v1.#ResourceCPU):                 "2"
							memory:               "8Gi"
							"gpu.intel.com/i915": 1
						}
						requests: {
							(v1.#ResourceCPU):   "1"
							(v1.#ResourceMemory): "2Gi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/app/configs"
					}, {
						name:      "server"
						mountPath: "/app/server"
					}, {
						name:      "media"
						mountPath: "/media"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						// capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
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
				resources: requests: (v1.#ResourceStorage): "32Gi"
			}
		}, {
			metadata: name: "server"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: (v1.#ResourceStorage): "32Gi"
			}
		}]
		serviceName: #Name
	}
}]
