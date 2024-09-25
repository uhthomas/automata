// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2

package v2

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// CiliumNodeConfig is a list of configuration key-value pairs. It is applied to
// nodes indicated by a label selector.
//
// If multiple overrides apply to the same node, they will be ordered by name
// with later Overrides overwriting any conflicting keys.
#CiliumNodeConfig: {
	metav1.#TypeMeta

	// +deepequal-gen=false
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec is the desired Cilium configuration overrides for a given node
	spec: #CiliumNodeConfigSpec @go(Spec)
}

// +deepequal-gen=false
#CiliumNodeConfigSpec: {
	// Defaults is treated the same as the cilium-config ConfigMap - a set
	// of key-value pairs parsed by the agent and operator processes.
	// Each key must be a valid config-map data field (i.e. a-z, A-Z, -, _, and .)
	defaults: {[string]: string} @go(Defaults,map[string]string)

	// NodeSelector is a label selector that determines to which nodes
	// this configuration applies.
	// If not supplied, then this config applies to no nodes. If
	// empty, then it applies to all nodes.
	nodeSelector?: null | metav1.#LabelSelector @go(NodeSelector,*metav1.LabelSelector)
}

#CiliumNodeConfigList: {
	metav1.#TypeMeta

	// +deepequal-gen=false
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#CiliumNodeConfig] @go(Items,[]CiliumNodeConfig)
}
