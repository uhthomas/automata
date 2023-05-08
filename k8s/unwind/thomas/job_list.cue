package thomas

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

_disks: [{
	node: "talos-su3-l23"
	wwn:  "wwn-0x50014ee2b1149946"
}, {
	node: "talos-e5f-w4m"
	wwn:  "wwn-0x50024e9204d5be47"
}]

#JobList: items: [ for disk in _disks {
	metadata: name: "shred-\(disk.wwn)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk"
				hostPath: path: "/dev/disk/by-id/\(disk.wwn)"
			}]
			containers: [{
				name:  "shred"
				image: "debian:bookworm-slim@sha256:5c1586cd384b778f88ece4920aa36d083da02a26ea628036cc20af86f15ed42e"
				command: ["shred"]
				args: ["-vfz", "/dev/sda"]
				volumeMounts: [{
					name:      "disk"
					mountPath: "/dev/sda"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: privileged: true
			}]
			restartPolicy: v1.#RestartPolicyNever
			nodeName:      disk.node
		}
	}
}]
