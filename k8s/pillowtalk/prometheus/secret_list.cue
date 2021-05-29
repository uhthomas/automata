package prometheus

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
	metadata: name:                     "additional-scrape-configs"
	data: "prometheus-additional.yaml": ''
}]
