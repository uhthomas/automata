// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/VictoriaMetrics/operator/api/victoriametrics/v1beta1

package v1beta1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// VMUserSpec defines the desired state of VMUser
#VMUserSpec: {
	// Name of the VMUser object.
	// +optional
	name?: null | string @go(Name,*string)

	// UserName basic auth user name for accessing protected endpoint,
	// will be replaced with metadata.name of VMUser if omitted.
	// +optional
	username?: null | string @go(UserName,*string)

	// Password basic auth password for accessing protected endpoint.
	// +optional
	password?: null | string @go(Password,*string)

	// PasswordRef allows fetching password from user-create secret by its name and key.
	// +optional
	passwordRef?: null | v1.#SecretKeySelector @go(PasswordRef,*v1.SecretKeySelector)

	// TokenRef allows fetching token from user-created secrets by its name and key.
	// +optional
	tokenRef?: null | v1.#SecretKeySelector @go(TokenRef,*v1.SecretKeySelector)

	// GeneratePassword instructs operator to generate password for user
	// if spec.password if empty.
	// +optional
	generatePassword?: bool @go(GeneratePassword)

	// BearerToken Authorization header value for accessing protected endpoint.
	// +optional
	bearerToken?: null | string @go(BearerToken,*string)

	// TargetRefs - reference to endpoints, which user may access.
	targetRefs: [...#TargetRef] @go(TargetRefs,[]TargetRef)

	// DefaultURLs backend url for non-matching paths filter
	// usually used for default backend with error message
	// +optional
	default_url?: [...string] @go(DefaultURLs,[]string)

	// IPFilters defines per target src ip filters
	// supported only with enterprise version of vmauth
	// https://docs.victoriametrics.com/vmauth.html#ip-filters
	// +optional
	ip_filters?: #VMUserIPFilters @go(IPFilters)

	// Headers represent additional http headers, that vmauth uses
	// in form of ["header_key: header_value"]
	// multiple values for header key:
	// ["header_key: value1,value2"]
	// it's available since 1.68.0 version of vmauth
	// +optional
	headers?: [...string] @go(Headers,[]string)

	// ResponseHeaders represent additional http headers, that vmauth adds for request response
	// in form of ["header_key: header_value"]
	// multiple values for header key:
	// ["header_key: value1,value2"]
	// it's available since 1.93.0 version of vmauth
	// +optional
	response_headers?: [...string] @go(ResponseHeaders,[]string)

	// RetryStatusCodes defines http status codes in numeric format for request retries
	// e.g. [429,503]
	// +optional
	retry_status_codes?: [...int] @go(RetryStatusCodes,[]int)

	// MaxConcurrentRequests defines max concurrent requests per user
	// 300 is default value for vmauth
	// +optional
	max_concurrent_requests?: null | int @go(MaxConcurrentRequests,*int)

	// DisableSecretCreation skips related secret creation for vmuser
	disable_secret_creation?: bool @go(DisableSecretCreation)
}

// TargetRef describes target for user traffic forwarding.
// one of target types can be chosen:
// crd or static per targetRef.
// user can define multiple targetRefs with different ref Types.
#TargetRef: {
	// CRD describes exist operator's CRD object,
	// operator generates access url based on CRD params.
	// +optional
	crd?: null | #CRDRef @go(CRD,*CRDRef)

	// Static - user defined url for traffic forward,
	// for instance http://vmsingle:8429
	// +optional
	static?: null | #StaticRef @go(Static,*StaticRef)

	// Paths - matched path to route.
	// +optional
	paths?: [...string] @go(Paths,[]string)

	// QueryParams []string `json:"queryParams,omitempty"`
	// TargetPathSuffix allows to add some suffix to the target path
	// It allows to hide tenant configuration from user with crd as ref.
	// it also may contain any url encoded params.
	// +optional
	target_path_suffix?: string @go(TargetPathSuffix)

	// Headers represent additional http headers, that vmauth uses
	// in form of ["header_key: header_value"]
	// multiple values for header key:
	// ["header_key: value1,value2"]
	// it's available since 1.68.0 version of vmauth
	// +optional
	headers?: [...string] @go(Headers,[]string)

	// ResponseHeaders represent additional http headers, that vmauth adds for request response
	// in form of ["header_key: header_value"]
	// multiple values for header key:
	// ["header_key: value1,value2"]
	// it's available since 1.93.0 version of vmauth
	// +optional
	response_headers?: [...string] @go(ResponseHeaders,[]string)

	// RetryStatusCodes defines http status codes in numeric format for request retries
	// Can be defined per target or at VMUser.spec level
	// e.g. [429,503]
	// +optional
	retry_status_codes?: [...int] @go(RetryStatusCodes,[]int)
}

// VMUserIPFilters defines filters for IP addresses
// supported only with enterprise version of vmauth
// https://docs.victoriametrics.com/vmauth.html#ip-filters
#VMUserIPFilters: {
	deny_list?: [...string] @go(DenyList,[]string)
	allow_list?: [...string] @go(AllowList,[]string)
}

// CRDRef describe CRD target reference.
#CRDRef: {
	// Kind one of:
	// VMAgent VMAlert VMCluster VMSingle or VMAlertManager
	kind: string @go(Kind)

	// Name target CRD object name
	name: string @go(Name)

	// Namespace target CRD object namespace.
	namespace: string @go(Namespace)
}

// StaticRef - user-defined routing host address.
#StaticRef: {
	// URL http url for given staticRef.
	url?: string @go(URL)

	// URLs allows setting multiple urls for load-balancing at vmauth-side.
	// +optional
	urls?: [...string] @go(URLs,[]string)
}

// VMUserStatus defines the observed state of VMUser
#VMUserStatus: {
}

// VMUser is the Schema for the vmusers API
// +kubebuilder:object:root=true
// +kubebuilder:subresource:status
// +genclient
#VMUser: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #VMUserSpec        @go(Spec)
	status?:   #VMUserStatus      @go(Status)
}

// VMUserList contains a list of VMUser
#VMUserList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VMUser] @go(Items,[]VMUser)
}