// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1

package v2alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	slimv1 "github.com/cilium/cilium/pkg/k8s/slim/k8s/apis/meta/v1"
)

// CiliumL2AnnouncementPolicy is a Kubernetes third-party resource which
// is used to defined which nodes should announce what services on the
// L2 network.
#CiliumL2AnnouncementPolicy: {
	metav1.#TypeMeta

	// +deepequal-gen=false
	metadata: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec is a human readable description of a L2 announcement policy
	//
	// +kubebuilder:validation:Optional
	spec?: #CiliumL2AnnouncementPolicySpec @go(Spec)

	// Status is the status of the policy.
	//
	// +deepequal-gen=false
	// +kubebuilder:validation:Optional
	status: #CiliumL2AnnouncementPolicyStatus @go(Status)
}

// CiliumL2AnnouncementPolicyList is a list of
// CiliumL2AnnouncementPolicy objects.
#CiliumL2AnnouncementPolicyList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)

	// Items is a list of CiliumL2AnnouncementPolicies.
	items: [...#CiliumL2AnnouncementPolicy] @go(Items,[]CiliumL2AnnouncementPolicy)
}

// CiliumL2AnnouncementPolicySpec specifies which nodes should announce what
// services to the L2 networks attached to the given list of interfaces.
#CiliumL2AnnouncementPolicySpec: {
	// NodeSelector selects a group of nodes which will announce the IPs for
	// the services selected by the service selector.
	//
	// If nil this policy applies to all nodes.
	//
	// +kubebuilder:validation:Optional
	nodeSelector?: null | slimv1.#LabelSelector @go(NodeSelector,*slimv1.LabelSelector)

	// ServiceSelector selects a set of services which will be announced over L2 networks
	//
	// If nil this policy applies to all services.
	//
	// +kubebuilder:validation:Optional
	serviceSelector?: null | slimv1.#LabelSelector @go(ServiceSelector,*slimv1.LabelSelector)

	// If true, the loadbalancer IPs of the services are announced
	//
	// If nil this policy applies to all services.
	//
	// +kubebuilder:validation:Optional
	loadBalancerIPs: bool @go(LoadBalancerIPs)

	// If true, the external IPs of the services are announced
	//
	// +kubebuilder:validation:Optional
	externalIPs: bool @go(ExternalIPs)

	// A list of regular expressions that express which network interface(s) should be used
	// to announce the services over. If nil, all network interfaces are used.
	//
	// +kubebuilder:validation:Optional
	interfaces: [...string] @go(Interfaces,[]string)
}

// CiliumL2AnnouncementPolicyStatus contains the status of a CiliumL2AnnouncementPolicy.
#CiliumL2AnnouncementPolicyStatus: {
	// Current service state
	// +optional
	// +patchMergeKey=type
	// +patchStrategy=merge
	// +listType=map
	// +listMapKey=type
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)
}
