package cloudflared

import (
	"encoding/yaml"
	"k8s.io/api/core/v1"
)

configMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

configMapList: items: [{
	data: "config.yaml": yaml.Marshal({
		tunnel:             "pillowtalk"
		"credentials-file": "/etc/cloudflared/creds/credentials.json"
		// Serves the metrics server under /metrics and the readiness server under /ready
		metrics: "0.0.0.0:2000"
		"no-autoupdate": true
		ingress: [{service:  "http://ingress-nginx-controller.ingress-nginx"}]
	})
}]
