package immich

import (
	crunchydatav1 "github.com/crunchydata/postgres-operator/pkg/apis/postgres-operator.crunchydata.com/v1beta1"
	"k8s.io/api/core/v1"
)

#PostgresClusterList: crunchydatav1.#PostgresClusterList & {
	apiVersion: "postgres-operator.crunchydata.com/v1beta1"
	kind:       "PostgresClusterList"
	items: [...{
		apiVersion: "postgres-operator.crunchydata.com/v1beta1"
		kind:       "PostgresCluster"
	}]
}

#PostgresClusterList: items: [{
	metadata: {
		name: "postgres"
		labels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "postgres"
		}
	}
	spec: {
		backups: pgbackrest: {
			image: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbackrest:ubi8-2.41-4"
			repos: [{
				name: "repo1"
				volume: volumeClaimSpec: {
					accessModes: [v1.#ReadWriteOnce]
					storageClassName: "rook-ceph-nvme-ec-delete-block"
					resources: requests: storage: "16Gi"
				}
			}]
		}
		image:           "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.2-0"
		imagePullPolicy: v1.#PullIfNotPresent
		instances: [{
			name: ""
			dataVolumeClaimSpec: {
				accessModes: [v1.#ReadWriteOnce]
				storageClassName: "rook-ceph-nvme-ec-delete-block"
				resources: requests: storage: "8Gi"
			}
			resources: limits: {
				cpu:    "1"
				memory: "1Gi"
			}
		}]
		postgresVersion: 15
		monitoring: pgmonitor: exporter: image: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-exporter:ubi8-5.3.2-0"
		users: [{
			name: "immich"
			databases: ["immich"]
			options: "SUPERUSER"
		}]
	}
}]
