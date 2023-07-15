package blkdiscard

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

#JobList: items: [ for disk in [{
	name: "nvme-eui.0025385531b3b814"
	node: "talos-avz-rb5"
}, {
	name: "nvme-eui.0025385531b3a96f"
	node: "talos-god-636"
}, {
	name: "nvme-eui.0025385531b39d87"
	node: "talos-su3-l23"
}] {
	metadata: name: "\(#Name)-\(disk.name)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk"
				hostPath: path: "/dev/disk/by-id/\(disk.name)"
			}]
			containers: [{
				name:  "blkdiscard"
				image: "debian:bookworm-slim"
				args: ["blkdiscard", "/dev/nvme0n1"]
				volumeMounts: [{
					name:      "disk"
					mountPath: "/dev/nvme0n1"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: privileged: true
			}]
			restartPolicy: v1.#RestartPolicyNever
			nodeName:      disk.node
		}
	}
}]
