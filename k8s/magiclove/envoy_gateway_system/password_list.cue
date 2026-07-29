package envoy_gateway_system

import corev1 "k8s.io/api/core/v1"

#PasswordList: corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "generators.external-secrets.io/v1alpha1"
		kind:       "Password"
	}]
}

// Random HMAC key used by Envoy's OAuth2 filter to protect OIDC cookies.
// This has no external state, so it can be generated again after a complete
// cluster rebuild. Rotating it invalidates existing OIDC cookies.
#PasswordList: items: [{
	metadata: name: "envoy-oidc-hmac"
	spec: {
		length:      64
		digits:      12
		symbols:     0
		noUpper:     false
		allowRepeat: true
	}
}]
