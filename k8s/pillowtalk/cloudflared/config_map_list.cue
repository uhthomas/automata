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
		// Name of the tunnel you want to run
		tunnel:             "pillowtalk"
		"credentials-file": "/etc/cloudflared/creds/credentials.json"
		// Serves the metrics server under /metrics and the readiness server under /ready
		metrics: "0.0.0.0:2000"
		// Autoupdates applied in a k8s pod will be lost when the pod is removed or restarted, so
		// autoupdate doesn't make sense in Kubernetes. However, outside of Kubernetes, we strongly
		// recommend using autoupdate.
		"no-autoupdate": true
		// The `ingress` block tells cloudflared which local service to route incoming
		// requests to. For more about ingress rules, see
		// https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/configuration/ingress
		//
		// Remember, these rules route traffic from cloudflared to a local service. To route traffic
		// from the internet to cloudflared, run `cloudflared tunnel route dns <tunnel> <hostname>`.
		// E.g. `cloudflared tunnel route dns example-tunnel tunnel.example.com`.
		ingress: [{
			hostname: "prometheus-pillowtalk.starjunk.net"
			service:  "http://prometheus-operated.prometheus.svc:9090"
		}, {
			hostname: "ceph-pillowtalk.starjunk.net"
			service: "https://rook-ceph-mgr-dashboard.rook-ceph.svc:8443"
			noTLSVerify: true
		}, {
			// This rule matches any traffic which didn't match a previous rule, and responds with HTTP 404.
			service: "http_status:404"
		}]
	})
}]
