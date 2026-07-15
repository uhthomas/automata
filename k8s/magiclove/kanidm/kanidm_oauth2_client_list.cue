package kanidm

#KanidmOAuth2ClientList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmOAuth2ClientList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "KanidmOAuth2Client"
	}]
}

#KanidmOAuth2ClientList: items: [{
	metadata: name: "kubernetes"
	spec: {
		kanidmRef: name: #Name
		displayname: "Kubernetes CLI"
		origin:      "https://magiclove.hipparcos.net:6443"
		redirectUrl: ["http://localhost:8000"]
		public: true
		scopeMap: [{
			group: "kubernetes-users"
			scopes: ["openid", "profile", "groups_name"]
		}]
		preferShortUsername:    true
		allowLocalhostRedirect: true
	}
}]
