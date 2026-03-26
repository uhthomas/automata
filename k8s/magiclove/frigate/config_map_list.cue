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
			host:     "mosquitto.mosquitto.svc.cluster.local"
			user:     "frigate"
			password: "{FRIGATE_MQTT_PASSWORD}"
		}
		ffmpeg: {
			hwaccel_args: "preset-nvidia-h264"
			output_args: record: "preset-record-generic-audio-aac"
		}
		detect: enabled: false
		record: {
			enabled: true
			continuous: days: 7
		}
		snapshots: {
			enabled: true
			retain: default: 7
		}
		cameras: {
			doorbell: {
				ffmpeg: inputs: [{
					path: "rtsps://192.168.1.1:7441/{FRIGATE_DOORBELL_SECRET}?enableSrtp"
					roles: ["record"]
				}]
				detect: fps: 30
			}
			maple: {
				let hostname = "192.168.1.72"
				ffmpeg: inputs: [{
					path: "rtsp://frigate:{FRIGATE_WJBC516A003968_PASSWORD}@\(hostname)/Preview_01_main"
					roles: ["record"]
				}]
				detect: fps: 25
				onvif: {
					host:     hostname
					user:     "frigate"
					password: "{FRIGATE_WJBC516A003968_PASSWORD}"
				}
			}
		}
	})
}]
