package kubernetes_dashboard

import "k8s.io/api/core/v1"

#SecretList: v1.#SecretList & {
	apiVersion: "v1"
	kind:       "SecretList"
	items: [...{
		apiVersion: "v1"
		kind:       "Secret"
	}]
}

#SecretList: items: [{
	metadata: name: "\(#Name)-certs"
}, {
	metadata: name: "\(#Name)-csrf"
	data: csrf:     ''
}, {
	metadata: name: "\(#Name)-key-holder"
}]
