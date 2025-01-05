package fstrim

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
	spec: {
		schedule:          "0 0 * * *" // every day
		concurrencyPolicy: batchv1.#ForbidConcurrent
		jobTemplate: spec: template: spec: {
			volumes: [{
				name: "host-proc"
				hostPath: {
					path: "/proc"
					type: v1.#HostPathDirectory
				}
			}]
			containers: [{
				name:  #Name
				image: "ghcr.io/onedr0p/kubanetics:\(#Version)"
				env: [{
					name:  "SCRIPT_NAME"
					value: "fstrim.sh"
				}]
				volumeMounts: [{
					name:      "host-proc"
					mountPath: "/host/proc"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: privileged: true
			}]
			restartPolicy: v1.#RestartPolicyOnFailure
			hostPID:       true
		}
	}
}]
