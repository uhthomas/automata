package envoy_gateway

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: "config.yaml": yaml.Marshal({
		apiVersion: "gateway.envoyproxy.io/v1alpha1"
		kind:       "EnvoyGateway"
		extensionApis: {}
		gateway: controllerName: "gateway.envoyproxy.io/gatewayclass-controller"
		logging: level: default: "info"
		provider: {
			kubernetes: {
				rateLimitDeployment: {
					container: image: "docker.io/envoyproxy/ratelimit:bb4dae24"
					patch: {
						type: "StrategicMerge"
						value: spec: template: spec: containers: [{
							imagePullPolicy: "IfNotPresent"
							name:            "envoy-ratelimit"
						}]
					}
				}
				shutdownManager: image: "docker.io/envoyproxy/gateway:v1.4.2"
			}
			type: "Kubernetes"
		}
	})
}]
