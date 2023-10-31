package onepassword_connect

import "k8s.io/api/core/v1"

#SecretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

#SecretList: items: [{metadata: name: "onepassword-credentials"}]
