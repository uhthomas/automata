package legacybackup

import "k8s.io/api/core/v1"

#PersistentVolumeList: v1.#PersistentVolumeList & {
	apiVersion: "v1"
	kind:       "PersistentVolumeList"
	items: [...{
		apiVersion: "v1"
		kind:       "PersistentVolume"
	}]
}

#PersistentVolumeList: items: [{
	metadata: name: "\(#Name)-legacy"
	spec: {
		capacity: storage: "16Ti"
		local: path:       "/dev/disk/by-id/wwn-0x5000c500cb5f5237-part1"
		claimRef: {
			apiVersion: "v1"
			kind:       "PersistentVolumeClaim"
			name:       "\(#Name)-legacy"
			namespace:  #Namespace
		}
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "local-storage"
		nodeAffinity: required: nodeSelectorTerms: [{
			matchExpressions: [{
				key:      v1.#LabelHostname
				operator: v1.#NodeSelectorOpIn
				values: ["talos-avz-rb5"]
			}]
		}]
	}
}]
