package smartctl

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

#JobList: items: [ for disk in [
	// HUH721010AL5200
	"wwn-0x5000cca2669799a0",
	// HUH721010AL5200
	"wwn-0x5000cca26697af28",
	// HUH721010AL5200
	"wwn-0x5000cca26c015ed8",
] {
	metadata: name: "\(#Name)-t-short-\(disk)"
	spec: {
		backoffLimit: 0
		template: spec: {
			volumes: [{
				name: "disk"
				hostPath: path: "/dev/disk/by-id/\(disk)"
			}]
			containers: [{
				name:  "smartctl"
				image: "ghcr.io/uhthomas/automata/smartmontools:{STABLE_GIT_COMMIT}"
				args: ["-t", "short", "/dev/sda"]
				volumeMounts: [{
					name:      "disk"
					mountPath: "/dev/sda"
				}]
				imagePullPolicy: v1.#PullIfNotPresent
				securityContext: privileged: true
			}]
			restartPolicy: v1.#RestartPolicyNever
			nodeName:      "talos-l94-p4c"
		}
	}
}]
