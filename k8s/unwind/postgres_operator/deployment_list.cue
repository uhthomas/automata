package postgres_operator

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DeploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

#DeploymentList: items: [{
	metadata: labels: "postgres-operator.crunchydata.com/control-plane": #Name
	spec: {
		selector: matchLabels: "postgres-operator.crunchydata.com/control-plane": #Name
		template: {
			metadata: labels: "postgres-operator.crunchydata.com/control-plane": #Name
			spec: {
				containers: [{
					name:  "operator"
					image: "registry.developers.crunchydata.com/crunchydata/postgres-operator:ubi8-5.3.1-0"
					env: [{
						name:  "CRUNCHY_DEBUG"
						value: "false"
					}, {
						name: "PGO_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "RELATED_IMAGE_PGADMIN"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgadmin4:ubi8-4.30-10"
					}, {
						name:  "RELATED_IMAGE_PGBACKREST"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbackrest:ubi8-2.41-4"
					}, {
						name:  "RELATED_IMAGE_PGBOUNCER"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbouncer:ubi8-1.18-0"
					}, {
						name:  "RELATED_IMAGE_PGEXPORTER"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-exporter:ubi8-5.3.1-0"
					}, {
						name:  "RELATED_IMAGE_PGUPGRADE"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-upgrade:ubi8-5.3.1-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-14.7-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.1"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.1-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.2"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.2-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.3"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.3-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_15"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.2-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_15_GIS_3.3"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-15.2-3.3-0"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}, {
	_name: "\(#Name)-upgrade"

	metadata: {
		name: _name
		labels: "postgres-operator.crunchydata.com/control-plane": _name
	}
	spec: {
		selector: matchLabels: "postgres-operator.crunchydata.com/control-plane": _name
		template: {
			metadata: labels: "postgres-operator.crunchydata.com/control-plane": _name
			spec: {
				containers: [{
					name:  "operator"
					image: "registry.developers.crunchydata.com/crunchydata/postgres-operator-upgrade:ubi8-5.3.1-0"
					env: [{
						name:  "CRUNCHY_DEBUG"
						value: "false"
					}, {
						name:  "RELATED_IMAGE_PGADMIN"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgadmin4:ubi8-4.30-10"
					}, {
						name:  "RELATED_IMAGE_PGBACKREST"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbackrest:ubi8-2.41-4"
					}, {
						name:  "RELATED_IMAGE_PGBOUNCER"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-pgbouncer:ubi8-1.18-0"
					}, {
						name:  "RELATED_IMAGE_PGEXPORTER"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-exporter:ubi8-5.3.1-0"
					}, {
						name:  "RELATED_IMAGE_PGUPGRADE"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-upgrade:ubi8-5.3.1-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-14.7-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.1"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.1-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.2"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.2-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_14_GIS_3.3"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.7-3.3-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_15"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.2-0"
					}, {
						name:  "RELATED_IMAGE_POSTGRES_15_GIS_3.3"
						value: "registry.developers.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-15.2-3.3-0"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: _name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
