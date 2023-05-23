package immich

import "k8s.io/api/core/v1"

#RedisFailoverList: v1.#List & {
	apiVersion: "databases.spotahome.com/v1"
	kind:       "RedisFailoverList"
	items: [...{
		apiVersion: "databases.spotahome.com/v1"
		kind:       "RedisFailover"
	}]
}

#RedisFailoverList: items: [{
	_name: "redis"

	metadata: {
		name: _name
		labels: "app.kubernetes.io/name": _name
	}
	spec: {
		sentinel: {
			image: "redis:7.0.11-alpine@sha256:e20345b7ec692815860c07f0209eb0465687b0c28cd85df412811ae1ac7b653e"
			exporter: enabled: true
			resources: {
				requests: {
					cpu:    "100m"
					memory: "100Mi"
				}
				limits: {
					cpu:    "400m"
					memory: "500Mi"
				}
			}
			securityContext: {
				runAsUser:    1000
				runAsGroup:   3000
				runAsNonRoot: true
				fsGroup:      2000
				seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
			}
			containerSecurityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
		}
		redis: {
			image: "redis:7.0.11-alpine@sha256:e20345b7ec692815860c07f0209eb0465687b0c28cd85df412811ae1ac7b653e"
			exporter: enabled: true
			resources: {
				requests: {
					cpu:    "100m"
					memory: "100Mi"
				}
				limits: {
					cpu:    "400m"
					memory: "500Mi"
				}
			}
			securityContext: {
				runAsUser:    1000
				runAsGroup:   3000
				runAsNonRoot: true
				fsGroup:      2000
				seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
			}
			containerSecurityContext: {
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem:   true
				allowPrivilegeEscalation: false
			}
			storage: persistentVolumeClaim: {
				metadata: name: _name
				spec: {
					accessModes: [v1.#ReadWriteOnce]
					storageClassName: "rook-ceph-hdd-ec-delete-block"
					resources: requests: storage: "16Gi"
				}
			}
		}
		labelWhitelist: ["~^"]
	}
}]
