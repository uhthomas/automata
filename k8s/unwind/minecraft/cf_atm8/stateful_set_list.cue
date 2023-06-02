package cf_atm8

import (
	"strings"

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
						volumeAttributes: secretProviderClass: "minecraft"
					}
				}]
				initContainers: [{
					name:  "download"
					image: "ghcr.io/uhthomas/automata/curl:{STABLE_GIT_COMMIT}"
					command: ["curl"]
					let urls = strings.Join([
						"https://mediafilez.forgecdn.net/files/4178/188/ExperienceBugFix-1.19-1.41.2.3.jar",
						"https://mediafilez.forgecdn.net/files/4322/445/moreoverlays-1.21.5-mc1.19.2.jar",
						"https://mediafilez.forgecdn.net/files/4466/686/hexerei-0.3.0.jar",
					], ",")
					args: ["-C", "-", "-LOf", "{\(urls)}"]
					workingDir: "/downloads"
					resources: limits: {
						cpu:    "1"
						memory: "1Gi"
					}
					volumeMounts: [{
						name:      "downloads"
						mountPath: "/downloads"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
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
						name:  "TYPE"
						value: "AUTO_CURSEFORGE"
					}, {
						name: "CF_API_KEY"
						valueFrom: secretKeyRef: {
							name: "minecraft"
							key:  "cf-api-key"
						}
					}, {
						name:  "CF_SLUG"
						value: "all-the-mods-8"
					}, {
						name:  "CF_FILE_ID"
						value: "4545872"
					}, {
						name:  "CF_PARALLEL_DOWNLOADS"
						value: "1"
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
					}, {
						name:      "downloads"
						mountPath: "/downloads"
					}, {
						name:      "secrets-store-inline"
						readOnly:  true
						mountPath: "/mnt/secrets-store"
					}]

					let probe = {exec: command: ["mc-health"]}

					livenessProbe:  probe
					readinessProbe: probe
					startupProbe:   probe & {initialDelaySeconds: 360}

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
		}, {
			metadata: name: "downloads"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
		}]
		serviceName: #Name
	}
}]
