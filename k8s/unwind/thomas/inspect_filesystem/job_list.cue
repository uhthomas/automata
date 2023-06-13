package inspect_filesystem

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
	let disk = "wwn-0x5000cca26c015ed8"
	metadata: name: "\(#Name)-\(disk)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk-part2"
				hostPath: path: "/dev/disk/by-id/\(disk)-part2"
			}]
			containers: [{
				name:  "inspect"
				image: "ghcr.io/uhthomas/automata/ntfs3g:{STABLE_GIT_COMMIT}"
				command: ["sh", "-c"]
				args: ["""
					mount -t ntfs /dev/sda2 /mnt
					ls -al /mnt
					"""]
				volumeMounts: [{
					name:      "disk-part2"
					mountPath: "/dev/sda2"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: privileged: true
			}]
			restartPolicy: v1.#RestartPolicyNever
			nodeName:      "talos-l94-p4c"
		}
	}
}]
