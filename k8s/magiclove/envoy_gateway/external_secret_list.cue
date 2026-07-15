package envoy_gateway

#ExternalSecretList: {
	apiVersion: "external-secrets.io/v1"
	kind:       "ExternalSecretList"
	items: [...{
		apiVersion: "external-secrets.io/v1"
		kind:       "ExternalSecret"
	}]
}

#ExternalSecretList: items: [{
	metadata: name: "envoy-oidc-hmac"
	spec: {
		target: name: "envoy-oidc-hmac"
		refreshInterval: "0"
		dataFrom: [{
			sourceRef: generatorRef: {
				apiVersion: "generators.external-secrets.io/v1alpha1"
				kind:       "Password"
				name:       "envoy-oidc-hmac"
			}
		}]
	}
}]
