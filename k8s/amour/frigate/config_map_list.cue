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
		ffmpeg: hwaccel_args: "preset-nvidia-h264"
		detectors: tensorrt: {
			type:   "tensorrt"
			device: 0
		}
		model: {
			path:               "/config/model_cache/tensorrt/yolov7-320.trt"
			input_tensor:       "nchw"
			input_pixel_format: "rgb"
			width:              320
			height:             320
		}
		cameras: dummy_camera: {
			enabled: false
			ffmpeg: inputs: [{
				path: "rtsp://127.0.0.1:554/rtsp"
				roles: ["detect"]
			}]

		}
	})
}]
