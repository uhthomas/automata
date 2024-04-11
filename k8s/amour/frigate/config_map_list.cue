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
			host:     "emqx.emqx"
			user:     "frigate"
			password: "{FRIGATE_MQTT_PASSWORD}"
		}
		detectors: tensorrt: {
			type:   "tensorrt"
			device: 0
		}
		ffmpeg: hwaccel_args: "preset-nvidia-h264"
		record: {
			enabled: true
			retain: {
				days: 7
				mode: "all"
			}
		}
		snapshots: {
			enabled: true
			retain: default: 7
		}
		model: {
			path:               "/config/model_cache/tensorrt/yolov7-320.trt"
			input_tensor:       "nchw"
			input_pixel_format: "rgb"
			width:              320
			height:             320
		}
		cameras: maple: {
			let hostname = "192.168.1.72"
			ffmpeg: inputs: [{
				path: "rtsp://frigate:{FRIGATE_WJBC516A003968_PASSWORD}@\(hostname)/Preview_01_main"
				roles: ["record"]
			}]
			onvif: {
				host:     hostname
				user:     "frigate"
				password: "{FRIGATE_WJBC516A003968_PASSWORD}"
			}
		}
	})
}]
