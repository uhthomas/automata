package flux_system

import sourcev1 "github.com/fluxcd/source-controller/api/v1"

#OCIRepositoryList: sourcev1.#OCIRepositoryList & {
	apiVersion: "source.toolkit.fluxcd.io/v1"
	kind:       "OCIRepositoryList"
	items: [...{
		apiVersion: "source.toolkit.fluxcd.io/v1"
		kind:       "OCIRepository"
	}]
}

#OCIRepositoryList: items: [{
	metadata: name: "magiclove"
	spec: {
		url: "oci://ghcr.io/uhthomas/automata/magiclove"
		ref: tag: "main"
		provider: "generic"
		interval: "1m"
	}
}]
