package immich

import (
	cnpgv1 "github.com/cloudnative-pg/cloudnative-pg/api/v1"
	v1 "k8s.io/api/core/v1"
)

#ClusterList: cnpgv1.#ClusterList & {
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "ClusterList"
	items: [...{
		apiVersion: "postgresql.cnpg.io/v1"
		kind:       "Cluster"
	}]
}

#ClusterList: items: [{
	metadata: name: "immich-pg-db"
	spec: {
		imageName: "ghcr.io/tensorchord/cloudnative-pgvecto.rs:16.5-v0.3.0@sha256:be3f025d79aa1b747817f478e07e71be43236e14d00d8a9eb3914146245035ba"
		instances: 1
		postgresql: shared_preload_libraries: ["vectors.so"]
		superuserSecret: name: "immich-pg-db-credentials"
		enableSuperuserAccess: true
		storage: {
			storageClass: "rook-ceph-nvme"
			size:         "4Gi"
		}
		resources: limits: {
			(v1.#ResourceCPU):    "1"
			(v1.#ResourceMemory): "1Gi"
		}
	}
}]
