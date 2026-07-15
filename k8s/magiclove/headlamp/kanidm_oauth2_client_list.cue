package headlamp

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
		displayname: "Headlamp"
		origin:      "https://headlamp-magiclove.hipparcos.net"
		redirectUrl: ["https://headlamp-magiclove.hipparcos.net/oauth2/callback"]
		preferShortUsername: true
		scopeMap: [{
			group: "headlamp-admins"
			scopes: ["openid", "profile", "email"]
		}]
	}
}]
