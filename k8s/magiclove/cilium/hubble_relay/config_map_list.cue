package hubble_relay

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
	metadata: name: "hubble-relay-config"
	data: "config.yaml": yaml.Marshal({
		"cluster-name":                "default"
		"peer-service":                "hubble-peer.cilium.svc.cluster.local.:443"
		"listen-address":              ":4245"
		gops:                          true
		"gops-port":                   "9893"
		"metrics-listen-address":      ":9966"
		"tls-hubble-client-cert-file": "/var/lib/hubble-relay/tls/client.crt"
		"tls-hubble-client-key-file":  "/var/lib/hubble-relay/tls/client.key"
		"tls-hubble-server-ca-files":  "/var/lib/hubble-relay/tls/hubble-server-ca.crt"
		"tls-relay-server-cert-file":  "/var/lib/hubble-relay/tls/server.crt"
		"tls-relay-server-key-file":   "/var/lib/hubble-relay/tls/server.key"
		"tls-relay-client-ca-files":   "/var/lib/hubble-relay/tls/hubble-server-ca.crt"
	})
}]
