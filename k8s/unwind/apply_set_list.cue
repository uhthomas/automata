package unwind

import "k8s.io/api/core/v1"

#ApplySetList: v1.#List & {
	apiVersion: "starjunk.net/v1"
	kind:       "ApplySetList"
	items: [...{
		apiVersion: "starjunk.net/v1"
		kind:       "ApplySet"
	}]
}

#ApplySetList: items: [{
	metadata: {
		name: "automata"
		annotations: "applyset.kubernetes.io/tooling": "kubectl/1.27"
	}
}]
