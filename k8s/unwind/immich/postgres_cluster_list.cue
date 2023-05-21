package immich

import "k8s.io/api/core/v1"

#PostgresClusterList: v1.#List & {
	apiVersion: "postgres-operator.crunchydata.com/v1beta1"
	kind:       "PostgresClusterList"
	items: [...{
		apiVersion: "postgres-operator.crunchydata.com/v1beta1"
		kind:       "PostgresCluster"
	}]
}

#PostgresClusterList: items: [{
	metadata: {
		name: "hippo"
		labels: "app.kubernetes.io/name": name
	}
	spec: {
		image:           "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.2-0"
		postgresVersion: 15
		instances: [{
			dataVolumeClaimSpec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-hdd-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
		}]
		backups: pgbackrest: {
			image: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbackrest:ubi8-2.41-4"
			repos: [{
				name: "repo1"
				volume: volumeClaimSpec: {
					accessModes: [v1.#ReadWriteOnce]
					storageClassName: "rook-ceph-hdd-ec-delete-block"
					resources: requests: storage: "16Gi"
				}
			}]
		}
	}
}]
