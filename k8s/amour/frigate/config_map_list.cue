package frigate

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
		mqtt: {
			// Required: host name
			host: "mqtt.server.com"
			// Optional: port (default: shown below)
			port: 1883
			// Optional: topic prefix (default: shown below)
			// WARNING: must be unique if you are running multiple instances
			topic_prefix: "frigate"
			// Optional: client id (default: shown below)
			// WARNING: must be unique if you are running multiple instances
			client_id: "frigate"
			// Optional: user
			user: "mqtt_user"
			// Optional: password
			// NOTE: Environment variables that begin with 'FRIGATE_' may be referenced in {}.
			//       eg. password: '{FRIGATE_MQTT_PASSWORD}'
			password: "password"
			// Optional: interval in seconds for publishing stats (default: shown below)
			stats_interval: 60
		}
		detectors: {
			// coral:
			//   type: edgetpu
			//   device: usb
			cpu1: {
				type: "cpu"
			}
		}
	})
}]
