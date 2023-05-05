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

// _disks: [
//  "wwn-0x50014ee20a85be27", // talos-su3-l23 WDC WD40EFRX-68W
//  "wwn-0x5000c500c95641d1", // talos-su3-l23 ST6000DM003-2CY1
//  "wwn-0x50014ee20a0d98d1", // talos-e5f-w4m WDC WD40EFRX-68W
//  "wwn-0x5000c500c9566239", // talos-e5f-w4m ST6000DM003-2CY1
// ]

_disks: [{
	node: "talos-su3-l23"
	wwn:  "wwn-0x50014ee20a85be27"
}, {
	node: "talos-su3-l23"
	wwn:  "wwn-0x5000c500c95641d1"
}, {
	node: "talos-e5f-w4m"
	wwn:  "wwn-0x50014ee20a0d98d1"
}, {
	node: "talos-e5f-w4m"
	wwn:  "wwn-0x5000c500c9566239"
}]

#JobList: items: [ for disk in _disks {
	metadata: name: "smartmontools-\(disk.node)-\(disk.wwn)"
	spec: template: spec: {
		volumes: [{
			name: "disk"
			hostPath: path: "/disk/by-id/\(disk.wwn)"
		}]
		containers: [{
			name:  metadata.name
			image: "ghcr.io/uhthomas/automata/smartmontools:{STABLE_GIT_COMMIT}"
			command: ["smartctl"]
			args: ["-a", "/dev/sda"]
			volumeMounts: [{
				name:      "disk"
				mountPath: "/dev/sda"
			}]
		}]
		restartPolicy: v1.#RestartPolicyNever
		nodeName:      disk.node
	}
}]
