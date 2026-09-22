package grafana

import corev1 "k8s.io/api/core/v1"

#PasswordList: corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "generators.external-secrets.io/v1alpha1"
		kind:       "Password"
	}]
}

#PasswordList: items: [{
	spec: {
		length:      64
		digits:      12
		symbols:     0
		noUpper:     false
		allowRepeat: true
	}
}]
