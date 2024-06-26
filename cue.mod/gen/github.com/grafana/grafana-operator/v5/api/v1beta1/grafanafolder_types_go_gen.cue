// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-operator/v5/api/v1beta1

package v1beta1

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// GrafanaFolderSpec defines the desired state of GrafanaFolder
#GrafanaFolderSpec: {
	// +optional
	title?: string @go(Title)

	// raw json with folder permissions
	// +optional
	permissions?: string @go(Permissions)

	// selects Grafanas for import
	instanceSelector?: null | metav1.#LabelSelector @go(InstanceSelector,*metav1.LabelSelector)

	// allow to import this resources from an operator in a different namespace
	// +optional
	allowCrossNamespaceImport?: null | bool @go(AllowCrossNamespaceImport,*bool)

	// how often the folder is synced, defaults to 5m if not set
	// +optional
	resyncPeriod?: string @go(ResyncPeriod)
}

// GrafanaFolderStatus defines the observed state of GrafanaFolder
#GrafanaFolderStatus: {
	// INSERT ADDITIONAL STATUS FIELD - define observed state of cluster
	// Important: Run "make" to regenerate code after modifying this file
	hash?: string @go(Hash)

	// The folder instanceSelector can't find matching grafana instances
	NoMatchingInstances?: bool

	// Last time the folder was resynced
	lastResync?: metav1.#Time @go(LastResync)
}

// GrafanaFolder is the Schema for the grafanafolders API
// +kubebuilder:printcolumn:name="No matching instances",type="boolean",JSONPath=".status.NoMatchingInstances",description=""
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp",description=""
#GrafanaFolder: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta   @go(ObjectMeta)
	spec?:     #GrafanaFolderSpec   @go(Spec)
	status?:   #GrafanaFolderStatus @go(Status)
}

// GrafanaFolderList contains a list of GrafanaFolder
#GrafanaFolderList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GrafanaFolder] @go(Items,[]GrafanaFolder)
}
