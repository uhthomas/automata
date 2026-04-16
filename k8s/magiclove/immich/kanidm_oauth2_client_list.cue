package immich

#KanidmOAuth2ClientList: {
	apiVersion: "kaniop.rs/v1beta1"
	kind:       "KanidmOAuth2ClientList"
	items: [...{
		apiVersion: "kaniop.rs/v1beta1"
		kind:       "KanidmOAuth2Client"
	}]
}

#KanidmOAuth2ClientList: items: [{
	metadata: name: #Name
	spec: {
		kanidmRef: {
			name:      "kanidm"
			namespace: "kanidm"
		}
		displayname: "Immich"
		origin:      "https://\(#Name)-magiclove.hipparcos.net"
		redirectUrl: [
			"https://\(#Name)-magiclove.hipparcos.net/auth/login",
			"app.immich:///oauth-callback",
		]
		preferShortUsername: true
		scopeMap: [{
			group: "immich-users"
			scopes: ["openid", "profile", "email"]
		}]
	}
}]
