package descheduler

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
	deschedulerv1alpha2 "sigs.k8s.io/descheduler/pkg/api/v1alpha2"
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
	data: "policy.yaml": yaml.Marshal(deschedulerv1alpha2.#DeschedulerPolicy & {
		apiVersion: "descheduler/v1alpha2"
		kind:       "DeschedulerPolicy"
		profiles: [{
			name: "Main"
			plugins: deschedule: enabled: ["RemoveFailedPods"]
		}]
	})
}]
