package unwind_bootstrap

import "k8s.io/api/core/v1"

talosConfigTemplateList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "bootstrap.cluster.x-k8s.io/v1alpha3"
		kind:       "TalosConfigTemplate"
	}]
}

talosConfigTemplateList: items: [{
	metadata: {
		name:      "unwind-workers"
		namespace: "default"
	}
	spec: template: spec: {
		generateType: "join"
		talosVersion: "v1.4.0-alpha.4"
	}
}]
