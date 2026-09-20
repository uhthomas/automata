package flux_system

import kustomizev1 "github.com/fluxcd/kustomize-controller/api/v1"

#KustomizationList: kustomizev1.#KustomizationList & {
	apiVersion: "kustomize.toolkit.fluxcd.io/v1"
	kind:       "KustomizationList"
	items: [...{
		apiVersion: "kustomize.toolkit.fluxcd.io/v1"
		kind:       "Kustomization"
	}]
}

#KustomizationList: items: [{
	metadata: name: "magiclove"
	spec: {
		interval:       "10m"
		retryInterval:  "1m"
		prune:          true
		deletionPolicy: "Orphan"
		sourceRef: {
			kind: "OCIRepository"
			name: "magiclove"
		}
		timeout: "10m"
		force:   false
	}
}]
