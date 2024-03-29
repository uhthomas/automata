// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crunchydata/postgres-operator/pkg/apis/postgres-operator.crunchydata.com/v1beta1

package v1beta1

import corev1 "k8s.io/api/core/v1"

// SchemalessObject is a map compatible with JSON object.
//
// Use with the following markers:
// - kubebuilder:pruning:PreserveUnknownFields
// - kubebuilder:validation:Schemaless
// - kubebuilder:validation:Type=object
#SchemalessObject: {...}

#ServiceSpec: {
	// +optional
	metadata?: null | #Metadata @go(Metadata,*Metadata)

	// The port on which this service is exposed when type is NodePort or
	// LoadBalancer. Value must be in-range and not in use or the operation will
	// fail. If unspecified, a port will be allocated if this Service requires one.
	// - https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
	// +optional
	nodePort?: null | int32 @go(NodePort,*int32)

	// More info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
	//
	// +optional
	// +kubebuilder:default=ClusterIP
	// +kubebuilder:validation:Enum={ClusterIP,NodePort,LoadBalancer}
	type: string @go(Type)
}

// Sidecar defines the configuration of a sidecar container
#Sidecar: {
	// Resource requirements for a sidecar container
	// +optional
	resources?: null | corev1.#ResourceRequirements @go(Resources,*corev1.ResourceRequirements)
}

// Metadata contains metadata for custom resources
#Metadata: {
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string)

	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string)
}
