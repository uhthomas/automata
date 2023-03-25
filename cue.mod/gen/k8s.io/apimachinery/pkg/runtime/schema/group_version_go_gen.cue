// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apimachinery/pkg/runtime/schema

package schema

// GroupResource specifies a Group and a Resource, but does not force a version.  This is useful for identifying
// concepts during lookup stages without having partially valid types
#GroupResource: {
	Group:    string
	Resource: string
}

// GroupVersionResource unambiguously identifies a resource.  It doesn't anonymously include GroupVersion
// to avoid automatic coercion.  It doesn't use a GroupVersion to avoid custom marshalling
#GroupVersionResource: {
	Group:    string
	Version:  string
	Resource: string
}

// GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying
// concepts during lookup stages without having partially valid types
#GroupKind: {
	Group: string
	Kind:  string
}

// GroupVersionKind unambiguously identifies a kind.  It doesn't anonymously include GroupVersion
// to avoid automatic coercion.  It doesn't use a GroupVersion to avoid custom marshalling
#GroupVersionKind: {
	Group:   string
	Version: string
	Kind:    string
}

// GroupVersion contains the "group" and the "version", which uniquely identifies the API.
#GroupVersion: {
	Group:   string
	Version: string
}

// GroupVersions can be used to represent a set of desired group versions.
// TODO: Move GroupVersions to a package under pkg/runtime, since it's used by scheme.
// TODO: Introduce an adapter type between GroupVersions and runtime.GroupVersioner, and use LegacyCodec(GroupVersion)
//
// in fewer places.
#GroupVersions: [...#GroupVersion]
