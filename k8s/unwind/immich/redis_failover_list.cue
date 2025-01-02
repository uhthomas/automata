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
	let _name = "redis"

	metadata: {
		name: _name
		labels: "app.kubernetes.io/name": _name
	}
	spec: {
		sentinel: {
			image: "redis:7.0.11-alpine@sha256:121bac949fb5f623b9fa0b4e4c9fb358ffd045966e754cfa3eb9963f3af2fe3b"
			exporter: enabled: true
			resources: {
				requests: {
					(v1.#ResourceCPU):    "100m"
					(v1.#ResourceMemory): "100Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "400m"
					(v1.#ResourceMemory): "500Mi"
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
			image: "redis:7.0.11-alpine@sha256:121bac949fb5f623b9fa0b4e4c9fb358ffd045966e754cfa3eb9963f3af2fe3b"
			exporter: enabled: true
			resources: {
				requests: {
					(v1.#ResourceCPU):    "100m"
					(v1.#ResourceMemory): "100Mi"
				}
				limits: {
					(v1.#ResourceCPU):    "400m"
					(v1.#ResourceMemory): "500Mi"
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
					resources: requests: (v1.#ResourceStorage): "16Gi"
				}
			}
		}
		labelWhitelist: ["~^"]
	}
}]
