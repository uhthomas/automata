package cert_manager_csi_driver

import storagev1 "k8s.io/api/storage/v1"

#CSIDriverList: storagev1.#CSIDriverList & {
	apiVersion: "storage.k8s.io/v1"
	kind:       "CSIDriverList"
	items: [...{
		apiVersion: "storage.k8s.io/v1"
		kind:       "CSIDriver"
	}]
}

#CSIDriverList: items: [{
	metadata: name: "csi.cert-manager.io"
	spec: {
		podInfoOnMount: true
		volumeLifecycleModes: [storagev1.#VolumeLifecycleEphemeral]
	}
}]
