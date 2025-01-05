package cf_atm9

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
						"https://mediafilez.forgecdn.net/files/5239/660/totw_modded-forge-1.20.1-1.0.5.jar",
						"https://mediafilez.forgecdn.net/files/5351/581/Structory_1.20.x_v1.3.5.jar",
						"https://mediafilez.forgecdn.net/files/5101/975/PacketFixer-forge-1.20.1-1.2.7.jar",
						"https://mediafilez.forgecdn.net/files/5352/30/allthewizardgear-1.20.1-1.1.3.jar",
					], ",")
					args: ["-C", "-", "-LOf", "{\(urls)}"]
					workingDir: "/downloads"
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
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
						name:  "TYPE"
						value: "AUTO_CURSEFORGE"
					}, {
						name: "CF_API_KEY"
						valueFrom: secretKeyRef: {
							name: #Name
							key:  "cf-api-key"
						}
					}, {
						name:  "CF_SLUG"
						value: "all-the-mods-9"
					}, {
						name:  "CF_FILE_ID"
						value: "5354808"
					}, {
						name:  "EULA"
						value: "TRUE"
					}, {
						name:  "ALLOW_FLIGHT"
						value: "true"
					}, {
						name:  "PVP"
						value: "false"
					},
						// }, {
						// 	name:  "VIEW_DISTANCE"
						// 	value: "12"
						{
							name:  "USE_SIMD_FLAGS"
							value: "true"
						}, {
							name:  "MEMORY"
							value: ""
						},
						// TODO:: Maybe calculate based
						// on resourceFieldRef?
						// value: "12G"
						{
							name: "JVM_XX_OPTS"
							// https://www.reddit.com/r/feedthebeast/comments/5jhuk9/modded_mc_and_memory_usage_a_history_with_a/
							value: "-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75 -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
						},
						// }, {
						// 	name:  "USE_AIKAR_FLAGS"
						// 	value: "true"
					]
					resources: limits: {
						(v1.#ResourceCPU):    "4"
						(v1.#ResourceMemory): "12Gi"
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
					}]

					let probe = v1.#Probe & {exec: command: ["mc-health"]}

					livenessProbe:  probe
					readinessProbe: probe
					startupProbe: probe & {
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
				resources: requests: (v1.#ResourceStorage): "32Gi"
			}
		}, {
			metadata: name: "downloads"
			spec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme"
				resources: requests: (v1.#ResourceStorage): "8Gi"
			}
		}]
		serviceName: #Name
	}
}]
