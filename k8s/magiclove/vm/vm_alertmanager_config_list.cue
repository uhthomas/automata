package vm

import victoriametricsv1beta1 "github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1"

#VMAlertmanagerConfigList: victoriametricsv1beta1.#VMAlertmanagerConfigList & {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertmanagerConfigList"
	items: [...{
		apiVersion: "operator.victoriametrics.com/v1beta1"
		kind:       "VMAlertmanagerConfig"
	}]
}

#VMAlertmanagerConfigList: items: [{
	spec: {
		route: {
			receiver: "discord"
			routes: [{
				receiver: "discard"
				matchers: ["alertname=Watchdog"]
			}, {
				receiver: "discord"
			}]
		}
		receivers: [{
			name: "discard"
		}, {
			name: "discord"
			discord_configs: [{
				webhook_url_secret: {
					name: "\(#Name)-discord-webhook-url"
					key:  "webhook-url"
				}
			}]
		}]
	}
}]
