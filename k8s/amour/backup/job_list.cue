package backup

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
	metadata: name: "lola-copy"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "from"
				persistentVolumeClaim: claimName: "lola-large2"
			}, {
				name: "to"
				persistentVolumeClaim: claimName: "lola"
			}]
			containers: [{
				name:  "rsync"
				image: "ghcr.io/uhthomas/automata/rsync:a363ad3135d5334d5aea94a40fcf6b26f0bb3c4c"
				command: ["rsync"]
				args: ["-ahimrvz", "--info=progress2", "/data/from/", "/data/to/"]
				volumeMounts: [{
					name:      "from"
					mountPath: "/data/from"
				}, {
					name:      "to"
					mountPath: "/data/to"
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
