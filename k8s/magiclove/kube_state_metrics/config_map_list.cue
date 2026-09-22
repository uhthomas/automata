package kube_state_metrics

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#ConfigMapList: v1.#ConfigMapList & {
	apiVersion: "v1"
	kind:       "ConfigMapList"
	items: [...{
		apiVersion: "v1"
		kind:       "ConfigMap"
	}]
}

#ConfigMapList: items: [{
	data: "custom-resource-state.yaml": yaml.Marshal({
		spec: resources: [{
			groupVersionKind: {
				group:   "kustomize.toolkit.fluxcd.io"
				version: "v1"
				kind:    "Kustomization"
			}
			metricNamePrefix: "gotk"
			metrics: [{
				name: "resource_info"
				help: "The current state of a Flux Kustomization resource."
				each: {
					type: "Info"
					info: labelsFromPath: name: ["metadata", "name"]
				}
				labelsFromPath: {
					exported_namespace: ["metadata", "namespace"]
					ready: ["status", "conditions", "[type=Ready]", "status"]
					suspended: ["spec", "suspend"]
					revision: ["status", "lastAppliedRevision"]
					source_name: ["spec", "sourceRef", "name"]
				}
			}]
		}, {
			groupVersionKind: {
				group:   "source.toolkit.fluxcd.io"
				version: "v1"
				kind:    "OCIRepository"
			}
			metricNamePrefix: "gotk"
			metrics: [{
				name: "resource_info"
				help: "The current state of a Flux OCIRepository resource."
				each: {
					type: "Info"
					info: labelsFromPath: name: ["metadata", "name"]
				}
				labelsFromPath: {
					exported_namespace: ["metadata", "namespace"]
					ready: ["status", "conditions", "[type=Ready]", "status"]
					suspended: ["spec", "suspend"]
					revision: ["status", "artifact", "revision"]
					url: ["spec", "url"]
				}
			}]
		}]
	})
}]
