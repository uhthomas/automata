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
			image: "redis:4.0.9-alpine@sha256:26cb6d6cd7ea424a78266c5a5e08e7df9919f52729a6b0e820e10597337ce9a2"
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
			image: "redis:7.0.11-alpine@sha256:e20345b7ec692815860c07f0209eb0465687b0c28cd85df412811ae1ac7b653e"
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
