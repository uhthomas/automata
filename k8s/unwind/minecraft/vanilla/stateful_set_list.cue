package vanilla

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
				}]
				containers: [{
					name:  "minecraft-server"
					image: "itzg/minecraft-server:\(#Version)"
					ports: [{
						name:          "minecraft"
						containerPort: 25565
					}, {
						name:          "rcon"
						containerPort: 25575
					}]
					env: [{
						name:  "EULA"
						value: "TRUE"
					}, {
						name:  "MEMORY"
						value: ""
					}, {
						name:  "JVM_XX_OPTS"
						value: "-XX:MaxRAMPercentage=75"
					}]
					resources: {
						limits: {
							cpu:    "4"
							memory: "16Gi"
						}
						requests: {
							cpu:    "2"
							memory: "8Gi"
						}
					}
					volumeMounts: [{
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "data"
						mountPath: "/data"
					}]

					let probe = {exec: command: ["mc-health"]}

					livenessProbe:  probe
					readinessProbe: probe
					startupProbe:   probe & {initialDelaySeconds: 60}

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
