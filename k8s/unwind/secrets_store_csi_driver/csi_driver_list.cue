package secrets_store_csi_driver

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
	metadata: name: "secrets-store.csi.k8s.io"
	spec: {
		podInfoOnMount: true
		attachRequired: false
		volumeLifecycleModes: [storagev1.#VolumeLifecycleEphemeral]
	}
}]
