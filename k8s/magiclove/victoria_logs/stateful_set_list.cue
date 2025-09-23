package victoria_logs

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
				containers: [{
					name:  #Name
					image: "victoriametrics/victoria-logs:v\(#Version)"
					args: [
						"--retentionPeriod=1",
						"--storageDataPath=/var/lib/victoria-logs",
						"--defaultMsgValue=",
					]
					ports: [{
						name:          "http"
						containerPort: 9428
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "400m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/var/lib/victoria-logs"
					}]

					let probe = {
						httpGet: {
							path: "/"
							port: "http"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "10Gi"
			}
		}]
		serviceName: #Name
	}
}]
