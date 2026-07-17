package vm

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#NotificationTitle: """
	{{- $alerts := .Alerts.Firing -}}
	{{- if eq .Status "resolved" -}}
		{{- $alerts = .Alerts.Resolved -}}
	{{- end -}}
	{{- if eq .Status "resolved" -}}
		✅ Resolved
	{{- else if eq .CommonLabels.severity "critical" -}}
		🚨 Critical
	{{- else if eq .CommonLabels.severity "warning" -}}
		⚠️ Warning
	{{- else if eq .CommonLabels.severity "info" -}}
		ℹ️ Info
	{{- else -}}
		🔥 Firing
	{{- end }} · {{ .CommonLabels.alertname }}{{ if gt (len $alerts) 1 }} ({{ len $alerts }}){{ end -}}
	"""

#DiscordNotificationMessage: """
	{{- $alerts := .Alerts.Firing -}}
	{{- if eq .Status "resolved" -}}
		{{- $alerts = .Alerts.Resolved -}}
	{{- end -}}
	{{- range $index, $alert := $alerts -}}
		{{- if $index }}{{ "\\n\\n" }}{{ end -}}
		• {{ if $alert.Annotations.description }}{{ $alert.Annotations.description }}{{ else if $alert.Annotations.summary }}{{ $alert.Annotations.summary }}{{ else }}No details provided.{{ end }}{{ if or $alert.Annotations.dashboard $alert.Annotations.dashboard_url $alert.Annotations.runbook_url $alert.GeneratorURL }}{{ "\\n" }}{{ end }}{{ if $alert.Annotations.dashboard }}[Dashboard]({{ $alert.Annotations.dashboard }}){{ else if $alert.Annotations.dashboard_url }}[Dashboard]({{ $alert.Annotations.dashboard_url }}){{ end }}{{ if and (or $alert.Annotations.dashboard $alert.Annotations.dashboard_url) (or $alert.Annotations.runbook_url $alert.GeneratorURL) }} · {{ end }}{{ if $alert.Annotations.runbook_url }}[Runbook]({{ $alert.Annotations.runbook_url }}){{ end }}{{ if and $alert.Annotations.runbook_url $alert.GeneratorURL }} · {{ end }}{{ if $alert.GeneratorURL }}[Source]({{ $alert.GeneratorURL }}){{ end }}
	{{- end -}}
	"""

#PushoverNotificationMessage: """
	{{- $alerts := .Alerts.Firing -}}
	{{- if eq .Status "resolved" -}}
		{{- $alerts = .Alerts.Resolved -}}
	{{- end -}}
	{{- range $index, $alert := $alerts -}}
		{{- if $index }}{{ "\\n\\n" }}{{ end -}}
		• {{ if $alert.Annotations.description }}{{ $alert.Annotations.description }}{{ else if $alert.Annotations.summary }}{{ $alert.Annotations.summary }}{{ else }}No details provided.{{ end }}{{ if or $alert.Annotations.dashboard $alert.Annotations.dashboard_url $alert.Annotations.runbook_url $alert.GeneratorURL }}{{ "\\n" }}{{ end }}{{ if $alert.Annotations.dashboard }}<a href="{{ $alert.Annotations.dashboard }}">Dashboard</a>{{ else if $alert.Annotations.dashboard_url }}<a href="{{ $alert.Annotations.dashboard_url }}">Dashboard</a>{{ end }}{{ if and (or $alert.Annotations.dashboard $alert.Annotations.dashboard_url) (or $alert.Annotations.runbook_url $alert.GeneratorURL) }} · {{ end }}{{ if $alert.Annotations.runbook_url }}<a href="{{ $alert.Annotations.runbook_url }}">Runbook</a>{{ end }}{{ if and $alert.Annotations.runbook_url $alert.GeneratorURL }} · {{ end }}{{ if $alert.GeneratorURL }}<a href="{{ $alert.GeneratorURL }}">Source</a>{{ end }}
	{{- end -}}
	"""

#VMAlertmanagerConfigList: operatorv1beta1.#VMAlertmanagerConfigList & {
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
			receiver: "default"
			group_by: ["alertname", "cluster", "namespace", "severity"]
			routes: [{
				receiver: "discard"
				matchers: ["alertname=~\"^(InfoInhibitor|Watchdog)$\""]
			}]
		}
		inhibit_rules: [{
			source_matchers: ["alertname=\"InfoInhibitor\""]
			target_matchers: ["severity=\"info\""]
			equal: ["cluster", "namespace"]
		}]
		receivers: [{
			name: "discard"
		}, {
			name: "default"
			discord_configs: [{
				send_resolved: true
				webhook_url_secret: {
					name: "\(#Name)-discord-webhook-url"
					key:  "webhook-url"
				}
				title:   #NotificationTitle
				message: #DiscordNotificationMessage
			}]
			pushover_configs: [{
				send_resolved: true
				user_key: {
					name: "\(#Name)-pushover"
					key:  "user-key"
				}
				token: {
					name: "\(#Name)-pushover"
					key:  "token"
				}
				title:     #NotificationTitle
				message:   #PushoverNotificationMessage
				url_title: "Open Alertmanager"
				html:      true
			}]
		}]
	}
}]
