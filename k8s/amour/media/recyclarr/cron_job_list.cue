package recyclarr

import (
	"k8s.io/api/core/v1"
	batchv1 "k8s.io/api/batch/v1"
)

#CronJobList: batchv1.#CronJobList & {
	apiVersion: "batch/v1"
	kind:       "CronJobList"
	items: [...{
		apiVersion: "batch/v1"
		kind:       "CronJob"
	}]
}

#CronJobList: items: [{
	let configDirectory = "/etc/\(#Name)"
	let configPath = "\(configDirectory)/config.yaml"
	spec: {
		schedule:          "0 0 * * *" // every day
		concurrencyPolicy: batchv1.#ForbidConcurrent
		jobTemplate: spec: template: spec: {
			volumes: [{
				name: "config-init"
				configMap: name: #Name
			}, {
				name: "config"
				emptyDir: {}
			}, {
				name: "tmp"
				emptyDir: {}
			}]
			// CUE doesn't support writing YAML tags.
			//
			// https://github.com/cue-lang/cue/issues/2316
			initContainers: [{
				let initConfigPath = "/tmp/init/config.yaml"
				name:  "copy-config"
				image: "alpine:3.17.2@sha256:e2e16842c9b54d985bf1ef9242a313f36b856181f188de21313820e177002501"
				command: ["cp"]
				args: [initConfigPath, configPath]
				volumeMounts: [{
					name:      "config-init"
					mountPath: initConfigPath
					subPath:   "config.yaml"
				}, {
					name:      "config"
					mountPath: configDirectory
					subPath:   "config.yaml"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: {
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem:   true
					allowPrivilegeEscalation: false
				}
			}, {
				name:  "yaml-tags"
				image: "mikefarah/yq:4.33.1@sha256:ddf60fa876a4f73414477fab551bcfb864a179cad6ce998b13ba4180e0f5702d"
				args: ["-i", ".[][].api_key tag = \"!env_var\"", configPath]
				volumeMounts: [{
					name:      "config"
					mountPath: configDirectory
					subPath:   "config.yaml"
				}, {
					name:      "tmp"
					mountPath: "/tmp"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: {
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem:   true
					allowPrivilegeEscalation: false
				}
			}]
			containers: [{
				name:  #Name
				image: "recyclarr/recyclarr:\(#Version)"
				command: ["recyclarr"]
				args: ["sync", "-c", configPath]
				env: [{
					// .NET CoreCLR crashes when run
					// in a container with a
					// read-only filesystem.
					//
					// https://github.com/Radarr/Radarr/issues/7030#issuecomment-1039689518
					// https://github.com/dotnet/runtime/issues/9336
					name:  "COMPlus_EnableDiagnostics"
					value: "0"
				}, {
					name: "RADARR_API_KEY"
					valueFrom: secretKeyRef: {
						name: #Name
						key:  "radarr-api-key"
					}
				}, {
					name: "SONARR_API_KEY"
					valueFrom: secretKeyRef: {
						name: #Name
						key:  "sonarr-api-key"
					}
				}]
				volumeMounts: [{
					name:      "config"
					mountPath: configDirectory
					subPath:   "config.yaml"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: {
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem:   true
					allowPrivilegeEscalation: false
				}
			}]
			restartPolicy: v1.#RestartPolicyOnFailure
			securityContext: {
				runAsUser:    1000
				runAsGroup:   3000
				runAsNonRoot: true
				fsGroup:      2000
				seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
			}
		}
	}
}]
