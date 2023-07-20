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
		replicas: 0
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
					image: "curlimages/curl:8.1.2"
					// Can be templated directly with args,
					// but syntax highlighting for vscode is
					// broken.
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
					image: "itzg/minecraft-server@sha256:2dac9ce79aa6e106cd0107ed2b47e6c7cb73f133fd23057faa160739cf6fc2b0"
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
						name:  "PVP"
						value: "false"
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
						name:  "MEMORY"
						value: ""
					}, {
						name: "JVM_XX_OPTS"
						// https://www.reddit.com/r/feedthebeast/comments/5jhuk9/modded_mc_and_memory_usage_a_history_with_a/
						value: "-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75 -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
					}]
					resources: limits: {
						cpu:    "6"
						memory: "24Gi"
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
					startupProbe:   probe & {
						initialDelaySeconds: 240
						failureThreshold:    30
					}

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
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "32Gi"
			}
		}, {
			metadata: name: "downloads"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
		}]
		serviceName: #Name
	}
}]
