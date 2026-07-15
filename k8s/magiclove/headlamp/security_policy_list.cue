package headlamp

import envoygatewayv1alpha1 "github.com/envoyproxy/gateway/api/v1alpha1"

#SecurityPolicyList: envoygatewayv1alpha1.#SecurityPolicyList & {
	apiVersion: "gateway.envoyproxy.io/v1alpha1"
	kind:       "SecurityPolicyList"
	items: [...{
		apiVersion: "gateway.envoyproxy.io/v1alpha1"
		kind:       "SecurityPolicy"
	}]
}

#SecurityPolicyList: items: [{
	spec: {
		targetRefs: [{
			group: "gateway.networking.k8s.io"
			kind:  "HTTPRoute"
			name:  "\(#Name)-https"
		}]
		oidc: {
			provider: issuer: "https://kanidm-magiclove.hipparcos.net/oauth2/openid/headlamp"
			clientID: #Name
			clientSecret: name: #OIDCSecretName
			scopes: ["profile", "email"]
			redirectURL: "https://headlamp-magiclove.hipparcos.net/oauth2/callback"
		}
	}
}]
