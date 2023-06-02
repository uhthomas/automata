// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go kubevirt.io/api/core/v1

package v1

import corev1 "k8s.io/api/core/v1"

// NodePlacement describes node scheduling configuration.
#NodePlacement: {
	// nodeSelector is the node selector applied to the relevant kind of pods
	// It specifies a map of key-value pairs: for the pod to be eligible to run on a node,
	// the node must have each of the indicated key-value pairs as labels
	// (it can have additional labels as well).
	// See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector
	// +kubebuilder:validation:Optional
	// +optional
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)

	// affinity enables pod affinity/anti-affinity placement expanding the types of constraints
	// that can be expressed with nodeSelector.
	// affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector
	// See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity
	// +kubebuilder:validation:Optional
	// +optional
	affinity?: null | corev1.#Affinity @go(Affinity,*corev1.Affinity)

	// tolerations is a list of tolerations applied to the relevant kind of pods
	// See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ for more info.
	// These are additional tolerations other than default ones.
	// +kubebuilder:validation:Optional
	// +optional
	tolerations?: [...corev1.#Toleration] @go(Tolerations,[]corev1.Toleration)
}

#ComponentConfig: {
	// nodePlacement describes scheduling configuration for specific
	// KubeVirt components
	//+optional
	nodePlacement?: null | #NodePlacement @go(NodePlacement,*NodePlacement)

	// replicas indicates how many replicas should be created for each KubeVirt infrastructure
	// component (like virt-api or virt-controller). Defaults to 2.
	// WARNING: this is an advanced feature that prevents auto-scaling for core kubevirt components. Please use with caution!
	//+optional
	replicas?: null | uint8 @go(Replicas,*uint8)
}