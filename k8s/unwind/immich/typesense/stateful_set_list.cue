package typesense

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
					name: "secrets-store-inline"
					csi: {
						driver:   "secrets-store.csi.k8s.io"
						readOnly: true
						volumeAttributes: secretProviderClass: #Name
					}
				}]
				containers: [{
					name:  #Name
					image: "typesense/typesense:v\(#Version)@sha256:e6ef6a082a62fb19c7fa80f596293f6519ce445670a59ae6ec4b750283865859"
					ports: [{
						name:          "http"
						containerPort: 8108
					}]
					env: [{
						name:  "TYPESENSE_DATA_DIR"
						value: "/var/lib/typesense"
					}, {
						name: "TYPESENSE_API_KEY"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "typesense-api-key"
						}
					}]

					let probe = {
						httpGet: {
							path: "/health"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/lib/typesense"
					}, {
						name:      "secrets-store-inline"
						readOnly:  true
						mountPath: "/mnt/secrets-store"
					}]
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
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
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "32Gi"
			}
		}]
		serviceName: #Name
	}
}]
