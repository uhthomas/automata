package envoy_gateway

#PasswordList: {
	apiVersion: "generators.external-secrets.io/v1alpha1"
	kind:       "PasswordList"
	items: [...{
		apiVersion: "generators.external-secrets.io/v1alpha1"
		kind:       "Password"
	}]
}

#PasswordList: items: [{
	metadata: name: "envoy-oidc-hmac"
	spec: {
		length:      64
		digits:      16
		symbols:     0
		noUpper:     false
		allowRepeat: true
		secretKeys: ["hmac-secret"]
	}
}]
