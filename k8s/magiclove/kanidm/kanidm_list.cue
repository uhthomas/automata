package kanidm

#KanidmList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "Kanidm"
	}]
}

#KanidmList: items: [{
	spec: {
		domain: "kanidm-magiclove.hipparcos.net"
		replicaGroups: [{
			name:     "default"
			replicas: 1
		}]
		storage: volumeClaimTemplate: spec: {
			storageClassName: "rook-ceph-nvme"
			resources: requests: storage: "256Mi"
			accessModes: ["ReadWriteOnce"]
		}
	}
}]
