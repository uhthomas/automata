package smartctl_exporter

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#VMRuleList: operatorv1beta1.#VMRuleList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRuleList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMRule"
	}]
}

#VMRuleList: items: [{
	metadata: name: "\(#Name).rules"
	spec: groups: [{
		name: "\(#Name).rules"
		rules: [{
			alert: "SmartCTLDeviceMediaErrors"
			expr:  "smartctl_device_media_errors != 0"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} reports {{ $value }} media errors."
				summary:     "SMART media errors detected"
			}
			for: "1m"
			labels: severity: "critical"
		}, {
			alert: "SmartCTLDeviceCriticalWarning"
			expr:  "smartctl_device_critical_warning != 0"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} reports critical warning value {{ $value }}."
				summary:     "SMART critical warning detected"
			}
			for: "1m"
			labels: severity: "critical"
		}, {
			alert: "SmartCTLDeviceAvailableSpareUnderThreshold"
			expr:  "smartctl_device_available_spare_threshold > smartctl_device_available_spare"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} has available spare below its threshold."
				summary:     "SMART available spare is below threshold"
			}
			for: "1m"
			labels: severity: "warning"
		}, {
			alert: "SmartCTLDeviceStatus"
			expr:  "smartctl_device_smart_status != 1"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} reports bad SMART status {{ $value }}."
				summary:     "SMART device status is bad"
			}
			for: "1m"
			labels: severity: "critical"
		}, {
			alert: "SmartCTLDInterfaceSlow"
			expr:  "smartctl_device_interface_speed{speed_type=\"current\"} != on(device, instance, namespace, pod) smartctl_device_interface_speed{speed_type=\"max\"}"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} is using an interface speed below its maximum."
				summary:     "SMART device interface is slow"
			}
			for: "1m"
			labels: severity: "warning"
		}, {
			alert: "SmartCTLDeviceTemperature"
			expr:  "smartctl_device_temperature{temperature_type=\"current\"} > 60"
			annotations: {
				description: "Device {{ $labels.device }} on instance {{ $labels.instance }} is at {{ $value }}°C (threshold: 60°C)."
				summary:     "SMART device temperature is high"
			}
			for: "1m"
			labels: severity: "warning"
		}]
	}]
}]
