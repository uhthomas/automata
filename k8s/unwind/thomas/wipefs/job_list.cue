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

#JobList: items: [{
	let disk = "wwn-0x5000cca26c015ed8"
	metadata: name: "\(#Name)-\(disk)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk"
				hostPath: path: "/dev/disk/by-id/\(disk)"
			}]
			containers: [{
				name:  "inspect"
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
			nodeName:      "talos-avz-rb5"
		}
	}
}]