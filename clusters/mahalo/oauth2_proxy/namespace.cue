package oauth2_proxy

import "k8s.io/api/core/v1"

namespace: [...v1.#Namespace]

namespace: [{
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "oauth2-proxy"
}]
