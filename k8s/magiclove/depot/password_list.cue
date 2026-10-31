package depot

import "k8s.io/api/core/v1"

#PasswordList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "generators.external-secrets.io/v1alpha1"
		kind:       "Password"
	}]
}

#PasswordList: items: [{
	spec: {
		length:      32
		digits:      8
		symbols:     0
		noUpper:     false
		allowRepeat: true
	}
}]
