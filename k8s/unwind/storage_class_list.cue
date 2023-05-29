package unwind

import storagev1 "k8s.io/api/storage/v1"

#StorageClassList: storagev1.#StorageClassList & {
	apiVersion: "v1"
	kind:       "StorageClassList"
	items: [...{
		apiVersion: "storage.k8s.io/v1"
		kind:       "StorageClass"
	}]
}

#StorageClassList: items: [{
	metadata: name: "local-storage"
	provisioner:       "kubernetes.io/no-provisioner"
	volumeBindingMode: storagev1.#VolumeBindingWaitForFirstConsumer
}]
