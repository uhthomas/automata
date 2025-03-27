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
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} has media errors"
			for: "1m"
			labels: severity: "error"
		}, {
			alert: "SmartCTLDeviceCriticalWarning"
			expr:  "smartctl_device_critical_warning != 0"
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} has media errors"
			for: "1m"
			labels: severity: "warning"
		}, {
			alert: "SmartCTLDeviceAvailableSpareUnderThreshold"
			expr:  "smartctl_device_available_spare_threshold > smartctl_device_available_spare"
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} is under available spare threshold."
			for: "1m"
			labels: severity: "warning"
		}, {
			alert: "SmartCTLDeviceStatus"
			expr:  "smartctl_device_status != 1"
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} has a bad status"
			for: "1m"
			labels: severity: "error"
		}, {
			alert: "SmartCTLDInterfaceSlow"
			expr:  "smartctl_device_interface_speed{speed_type=\"current\"} != on(device, instance, namespace, pod) smartctl_device_interface_speed{speed_type=\"max\"}"
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} interface is slower then it should be"
			for: "1m"
			labels: severity: "warning"
		}, {
			alert: "SmartCTLDeviceTemperature"
			expr:  "smartctl_device_temperature{temperature_type=\"current\"} > 60"
			annotations: message: "Device {{ $labels.device }} on instance {{ $labels.instance }} has temperature higher than 60°C"
			for: "1m"
			labels: severity: "warning"
		}]
	}]
}]
