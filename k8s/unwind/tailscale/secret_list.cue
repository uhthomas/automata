package tailscale

import "k8s.io/api/core/v1"

secretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

secretList: items: [{
	metadata: name: "operator-oauth"
	stringData: {
		client_id:     "kayEzK7CNTRL"
		client_secret: "tskey-client-kayEzK7CNTRL-Ct9Nn5zXdrKCLkxDene3oKCQfMtMxwBF"
	}
}]
