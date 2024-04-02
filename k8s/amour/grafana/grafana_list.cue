package grafana

import grafanav1beta1 "github.com/grafana/grafana-operator/v5/api/v1beta1"

#GrafanaList: grafanav1beta1.#GrafanaList & {
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaList"
	items: [...{
		apiVersion: "grafana.integreatly.org/v1beta1"
		kind:       "Grafana"
	}]
}

#GrafanaList: items: [{
	spec: external: {
		url: "http://\(#Name).\(#Namespace)"
		adminUser: {
			name: "grafana"
			key:  "username"
		}
		adminPassword: {
			name: "grafana"
			key:  "password"
		}
	}
}]
