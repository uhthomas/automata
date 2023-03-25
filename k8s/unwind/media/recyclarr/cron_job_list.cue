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
		schedule:          "0 * * * *" // every hour
		concurrencyPolicy: batchv1.#ForbidConcurrent
		jobTemplate: spec: template: spec: {
			volumes: [{
				name: "config"
				configMap: name: #Name
			}]
			containers: [{
				name:  #Name
				image: "recyclarr/recyclarr:\(#Version)@sha256:5eaf56031aa5f8675eb335a65d413a4bf04d0c86ddb7b213cdd09d4b5c2095be"
				command: ["recyclarr"]
				args: ["sync", "-c", configPath]
				volumeMounts: [{
					name:      "config"
					mountPath: configPath
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
		// We're not ready to run recyclarr yet.
		suspend: true
	}
}]
