// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go kubevirt.io/api/pool/v1alpha1

package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	virtv1 "kubevirt.io/api/core/v1"
	k8sv1 "k8s.io/api/core/v1"
)

#VirtualMachinePoolKind: "VirtualMachinePool"

// VirtualMachinePool resource contains a VirtualMachine configuration
// that can be used to replicate multiple VirtualMachine resources.
//
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
// +k8s:openapi-gen=true
// +genclient
#VirtualMachinePool: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta        @go(ObjectMeta)
	spec:      #VirtualMachinePoolSpec   @go(Spec)
	status?:   #VirtualMachinePoolStatus @go(Status)
}

// +k8s:openapi-gen=true
#VirtualMachineTemplateSpec: {
	// +kubebuilder:pruning:PreserveUnknownFields
	// +nullable
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// VirtualMachineSpec contains the VirtualMachine specification.
	spec?: virtv1.#VirtualMachineSpec @go(Spec)
}

// +k8s:openapi-gen=true
#VirtualMachinePoolConditionType: string // #enumVirtualMachinePoolConditionType

#enumVirtualMachinePoolConditionType:
	#VirtualMachinePoolReplicaFailure |
	#VirtualMachinePoolReplicaPaused

// VirtualMachinePoolReplicaFailure is added in a pool when one of its vms
// fails to be created.
#VirtualMachinePoolReplicaFailure: #VirtualMachinePoolConditionType & "ReplicaFailure"

// VirtualMachinePoolReplicaPaused is added in a pool when the pool got paused by the controller.
// After this condition was added, it is safe to remove or add vms by hand and adjust the replica count manually
#VirtualMachinePoolReplicaPaused: #VirtualMachinePoolConditionType & "ReplicaPaused"

// +k8s:openapi-gen=true
#VirtualMachinePoolCondition: {
	type:   #VirtualMachinePoolConditionType @go(Type)
	status: k8sv1.#ConditionStatus           @go(Status)

	// +nullable
	lastProbeTime?: metav1.#Time @go(LastProbeTime)

	// +nullable
	lastTransitionTime?: metav1.#Time @go(LastTransitionTime)
	reason?:             string       @go(Reason)
	message?:            string       @go(Message)
}

// +k8s:openapi-gen=true
#VirtualMachinePoolStatus: {
	replicas?:      int32 @go(Replicas)
	readyReplicas?: int32 @go(ReadyReplicas)

	// +listType=atomic
	conditions?: [...#VirtualMachinePoolCondition] @go(Conditions,[]VirtualMachinePoolCondition)

	// Canonical form of the label selector for HPA which consumes it through the scale subresource.
	labelSelector?: string @go(LabelSelector)
}

// +k8s:openapi-gen=true
#VirtualMachinePoolSpec: {
	// Number of desired pods. This is a pointer to distinguish between explicit
	// zero and not specified. Defaults to 1.
	// +optional
	replicas?: null | int32 @go(Replicas,*int32)

	// Label selector for pods. Existing Poolss whose pods are
	// selected by this will be the ones affected by this deployment.
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector)

	// Template describes the VM that will be created.
	virtualMachineTemplate?: null | #VirtualMachineTemplateSpec @go(VirtualMachineTemplate,*VirtualMachineTemplateSpec)

	// Indicates that the pool is paused.
	// +optional
	paused?: bool @go(Paused) @protobuf(7,varint,opt)
}

// VirtualMachinePoolList is a list of VirtualMachinePool resources.
//
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
// +k8s:openapi-gen=true
#VirtualMachinePoolList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VirtualMachinePool] @go(Items,[]VirtualMachinePool)
}
