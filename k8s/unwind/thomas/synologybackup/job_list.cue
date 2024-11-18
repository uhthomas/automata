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
				image: "rclone/rclone:1.68.2@sha256:74c51b8817e5431bd6d7ed27cb2a50d8ee78d77f6807b72a41ef6f898845942b"
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
