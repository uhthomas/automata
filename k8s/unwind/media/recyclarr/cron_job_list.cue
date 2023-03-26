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
	let configPath = "/etc/\(#Name)/config.yaml"
	spec: {
		schedule:          "0 0 * * *" // every day
		concurrencyPolicy: batchv1.#ForbidConcurrent
		jobTemplate: spec: template: spec: {
			volumes: [{
				name: "config"
				configMap: name: #Name
			}, {
				name: "secrets-store-inline"
				csi: {
					driver:   "secrets-store.csi.k8s.io"
					readOnly: true
					volumeAttributes: secretProviderClass: #Name
				}
			}]
			containers: [{
				name:  #Name
				image: "recyclarr/recyclarr:\(#Version)@sha256:5eaf56031aa5f8675eb335a65d413a4bf04d0c86ddb7b213cdd09d4b5c2095be"
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
						name: "\(#Name)-api-keys"
						key:  "radarr-api-key"
					}
				}, {
					name: "SONARR_API_KEY"
					valueFrom: secretKeyRef: {
						name: "\(#Name)-api-keys"
						key:  "sonarr-api-key"
					}
				}]
				volumeMounts: [{
					name:      "config"
					mountPath: configPath
					subPath:   "config.yaml"
				}, {
					name:      "secrets-store-inline"
					readOnly:  true
					mountPath: "/mnt/secrets-store"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: {
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem:   true
					allowPrivilegeEscalation: false
				}
			}]
			restartPolicy:      v1.#RestartPolicyOnFailure
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
}]
