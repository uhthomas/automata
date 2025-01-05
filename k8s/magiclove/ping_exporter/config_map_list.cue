package ping_exporter

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
		targets: ["1.1.1.1", "1.0.0.1", "8.8.8.8", "8.8.4.4"]
		dns: {
			refresh:    "2m15s"
			nameserver: "1.1.1.1"
		}
		ping: {
			interval:       "2s"
			timeout:        "3s"
			"history-size": 42
			"payload-size": 120
		}
	})
}]
