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

#JobList: items: [{
	metadata: name: "smartmontoolstest"
	spec: template: spec: {
		containers: [{
			name:  metadata.name
			image: "ghcr.io/uhthomas/automata/smartmontools:{STABLE_GIT_COMMIT}"
		}]
		restartPolicy: v1.#RestartPolicyNever
	}
}]
