package synologybackup

import (
	"k8s.io/api/core/v1"
	batchv1 "k8s.io/api/batch/v1"
)

#JobList: batchv1.#JobList & {
	apiVersion: "batch/v1"
	kind:       "JobList"
	items: [...{
		apiVersion: "batch/v1"
		kind:       "Job"
	}]
}

#JobList: items: [{
	metadata: name: "\(#Name)-rclone"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "data"
				persistentVolumeClaim: claimName: #Name
			}, {
				name: "config"
				configMap: name: "\(#Name)-rclone"
			}]
			containers: [{
				name:  "rclone"
				image: "rclone/rclone:1.62.2@sha256:a293da661307f1fb1a8f84e45c96c8a5db4af4a76f28d10ea2f4e48344e4eee3"
				args: ["copy", "-P", "--checkers=8", "--transfers=200", "smb:/E", "/data"]
				volumeMounts: [{
					name:      "data"
					mountPath: "/data"
				}, {
					name:      "config"
					mountPath: "/config/rclone/rclone.conf"
					subPath:   "rclone.conf"
				}]
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
			restartPolicy: v1.#RestartPolicyNever
		}
	}
}]
