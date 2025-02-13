package zigbee2mqtt

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
	data: "configuration.yaml": yaml.Marshal({
		homeassistant: {
			enabled:                  true
			discovery_topic:          "homeassistant"
			status_topic:             "hass/status"
			legacy_entity_attributes: true
			legacy_triggers:          false
		}
		permit_join: true
		mqtt: {
			server: "mqtt://mosquitto.mosquitto.svc.cluster.local:1883"
			user:   "zigbee2mqtt"
		}
		serial: {
			port:    "tcp://slzb-06.internal:6638"
			adapter: "zstack"
		}
		frontend: enabled: true
	})
}]
