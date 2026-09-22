package grafana

#KanidmOAuth2ClientList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmOAuth2ClientList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "KanidmOAuth2Client"
	}]
}

#KanidmOAuth2ClientList: items: [{
	spec: {
		kanidmRef: {
			name:      "kanidm"
			namespace: "kanidm"
		}
		displayname: "Grafana"
		origin:      "https://grafana-magiclove.hipparcos.net"
		redirectUrl: ["https://grafana-magiclove.hipparcos.net/login/generic_oauth"]
		preferShortUsername: true
		scopeMap: [{
			group: "grafana-users"
			scopes: ["openid", "profile", "email", "groups_spn"]
		}]
	}
}]
