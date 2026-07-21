package vm

import operatorv1beta1 "github.com/VictoriaMetrics/operator/api/operator/v1beta1"

#KarmaURL: "https://karma-magiclove.hipparcos.net"

#NotificationTitle: """
	{{- $alerts := .Alerts.Firing -}}
	{{- if eq .Status "resolved" -}}
		{{- $alerts = .Alerts.Resolved -}}
	{{- end -}}
	{{- if eq .Status "resolved" -}}
		✅ Resolved
	{{- else if or (eq .CommonLabels.severity "critical") (eq .CommonLabels.severity "error") -}}
		🚨 Critical
	{{- else if eq .CommonLabels.severity "warning" -}}
		⚠️ Warning
	{{- else if eq .CommonLabels.severity "info" -}}
		ℹ️ Info
	{{- else -}}
		Firing
	{{- end }} · {{ .CommonLabels.alertname }}{{ if gt (len $alerts) 1 }} ({{ len $alerts }}){{ end -}}
	"""

#DiscordNotificationMessage: """
	{{- range $index, $alert := .Alerts -}}
		{{- if $index }}{{ "\\n\\n" }}{{ end -}}
		• {{ if $alert.Annotations.summary }}**{{ $alert.Annotations.summary }}**{{ else if $alert.Annotations.message }}{{ $alert.Annotations.message }}{{ else if $alert.Annotations.description }}{{ $alert.Annotations.description }}{{ else }}No details provided.{{ end -}}
		{{- if and $alert.Annotations.summary $alert.Annotations.description (ne $alert.Annotations.summary $alert.Annotations.description) }}{{ "\\n" }}{{ $alert.Annotations.description }}{{ end -}}
		{{- $labels := $alert.Labels.Remove (stringSlice "alertname" "severity") -}}
		{{- if $labels }}{{ "\\n" }}{{ range $labelIndex, $label := $labels.SortedPairs }}{{ if $labelIndex }} · {{ end }}`{{ $label.Name }}={{ $label.Value }}`{{ end }}{{ end -}}
		{{- if eq $alert.Status "resolved" }}{{ "\\n" }}Resolved: {{ $alert.EndsAt.Format "2006-01-02 15:04 MST" }}{{ else }}{{ "\\n" }}Firing since: {{ $alert.StartsAt.Format "2006-01-02 15:04 MST" }}{{ end -}}
		{{ "\\n" -}}
		{{- if $alert.Annotations.dashboard }}[Dashboard]({{ $alert.Annotations.dashboard }}) · {{ else if $alert.Annotations.dashboard_url }}[Dashboard]({{ $alert.Annotations.dashboard_url }}) · {{ end -}}
		{{- if $alert.Annotations.documentation }}[Documentation]({{ $alert.Annotations.documentation }}) · {{ end -}}
		{{- if $alert.Annotations.runbook_url }}[Runbook]({{ $alert.Annotations.runbook_url }}) · {{ end -}}
		{{- if $alert.GeneratorURL }}[Source]({{ $alert.GeneratorURL }}) · {{ end -}}
		[Karma](\(#KarmaURL))
	{{- end -}}
	"""

#PushoverNotificationMessage: """
	{{- range $index, $alert := .Alerts -}}
		{{- if $index }}{{ "\\n\\n" }}{{ end -}}
		• {{ if $alert.Annotations.summary }}<b>{{ $alert.Annotations.summary }}</b>{{ else if $alert.Annotations.message }}{{ $alert.Annotations.message }}{{ else if $alert.Annotations.description }}{{ $alert.Annotations.description }}{{ else }}No details provided.{{ end -}}
		{{- if and $alert.Annotations.summary $alert.Annotations.description (ne $alert.Annotations.summary $alert.Annotations.description) }}{{ "\\n" }}{{ $alert.Annotations.description }}{{ end -}}
		{{- $labels := $alert.Labels.Remove (stringSlice "alertname" "severity") -}}
		{{- if $labels }}{{ "\\n" }}{{ range $labelIndex, $label := $labels.SortedPairs }}{{ if $labelIndex }} · {{ end }}{{ $label.Name }}={{ $label.Value }}{{ end }}{{ end -}}
		{{- if eq $alert.Status "resolved" }}{{ "\\n" }}Resolved: {{ $alert.EndsAt.Format "2006-01-02 15:04 MST" }}{{ else }}{{ "\\n" }}Firing since: {{ $alert.StartsAt.Format "2006-01-02 15:04 MST" }}{{ end -}}
		{{ "\\n" -}}
		{{- if $alert.Annotations.dashboard }}<a href="{{ $alert.Annotations.dashboard }}">Dashboard</a> · {{ else if $alert.Annotations.dashboard_url }}<a href="{{ $alert.Annotations.dashboard_url }}">Dashboard</a> · {{ end -}}
		{{- if $alert.Annotations.documentation }}<a href="{{ $alert.Annotations.documentation }}">Documentation</a> · {{ end -}}
		{{- if $alert.Annotations.runbook_url }}<a href="{{ $alert.Annotations.runbook_url }}">Runbook</a> · {{ end -}}
		{{- if $alert.GeneratorURL }}<a href="{{ $alert.GeneratorURL }}">Source</a> · {{ end -}}
		<a href="\(#KarmaURL)">Karma</a>
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
				url:       #KarmaURL
				url_title: "Open Karma"
				html:      true
			}]
		}]
	}
}]
