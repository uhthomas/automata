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
			image: "redis:7.2.5-alpine@sha256:de14eedfbd1fc871d0f5aa1773fd80743930e45354d035b6f3b551e7ffa44df8"
			exporter: enabled: true
			resources: {
				requests: {
					(v1.#ResourceCPU):   "100m"
					(v1.#ResourceMemory): "100Mi"
				}
				limits: {
					(v1.#ResourceCPU):   "400m"
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
			image: "redis:7.2.5-alpine@sha256:de14eedfbd1fc871d0f5aa1773fd80743930e45354d035b6f3b551e7ffa44df8"
			exporter: enabled: true
			resources: {
				requests: {
					(v1.#ResourceCPU):   "100m"
					(v1.#ResourceMemory): "100Mi"
				}
				limits: {
					(v1.#ResourceCPU):   "400m"
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
