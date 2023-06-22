package wipefs

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

let disks = [{
	wwn:  "wwn-0x5000cca26697af28"
	node: "talos-su3-l23"
}, {
	wwn: "wwn-0x5000cca2669799a0"
	node: "talos-god-636"
}]

#JobList: items: [ for disk in disks {
	metadata: name: "\(#Name)-\(disk.wwn)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk"
				hostPath: path: "/dev/disk/by-id/\(disk.wwn)"
			}]
			containers: [{
				name:  "wipefs"
				image: "debian:bullseye-slim"
				args: ["wipefs", "-a", "/dev/sda"]
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
