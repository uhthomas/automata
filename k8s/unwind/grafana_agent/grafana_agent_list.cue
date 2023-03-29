package grafana_agent

import "k8s.io/api/core/v1"

#GrafanaAgentList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "GrafanaAgentList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "GrafanaAgent"
	}]
}

#GrafanaAgentList: items: [{
	spec: {
		image: "grafana/agent:v0.32.1"
		integrations: selector: matchLabels: "app.kubernetes.io/name": #Name
		logs: instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
		metrics: {
			externalLabels: cluster: "unwind"
			instanceSelector: matchLabels: "app.kubernetes.io/name": #Name
			scrapeInterval: "15s"
		}
		serviceAccountName: #Name
		volumes: [{
			name: "secrets-store-inline"
			csi: {
				driver:   "secrets-store.csi.k8s.io"
				readOnly: true
				volumeAttributes: secretProviderClass: "\(#Name)-grafana-cloud"
			}
		}]
		volumeMounts: [{
			name:      "secrets-store-inline"
			readOnly:  true
			mountPath: "/mnt/secrets-store"
		}]
	}
}]
