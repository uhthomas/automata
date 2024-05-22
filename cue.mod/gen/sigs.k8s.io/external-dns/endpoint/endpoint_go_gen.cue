// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/external-dns/endpoint

package endpoint

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// RecordTypeA is a RecordType enum value
#RecordTypeA: "A"

// RecordTypeAAAA is a RecordType enum value
#RecordTypeAAAA: "AAAA"

// RecordTypeCNAME is a RecordType enum value
#RecordTypeCNAME: "CNAME"

// RecordTypeTXT is a RecordType enum value
#RecordTypeTXT: "TXT"

// RecordTypeSRV is a RecordType enum value
#RecordTypeSRV: "SRV"

// RecordTypeNS is a RecordType enum value
#RecordTypeNS: "NS"

// RecordTypePTR is a RecordType enum value
#RecordTypePTR: "PTR"

// RecordTypeMX is a RecordType enum value
#RecordTypeMX: "MX"

// RecordTypeNAPTR is a RecordType enum value
#RecordTypeNAPTR: "NAPTR"

// TTL is a structure defining the TTL of a DNS record
#TTL: int64

// Targets is a representation of a list of targets for an endpoint.
#Targets: [...string]

// ProviderSpecificProperty holds the name and value of a configuration which is specific to individual DNS providers
#ProviderSpecificProperty: {
	name?:  string @go(Name)
	value?: string @go(Value)
}

// ProviderSpecific holds configuration which is specific to individual DNS providers
#ProviderSpecific: [...#ProviderSpecificProperty]

// EndpointKey is the type of a map key for separating endpoints or targets.
#EndpointKey: {
	DNSName:       string
	RecordType:    string
	SetIdentifier: string
}

// Endpoint is a high-level way of a connection between a service and an IP
#Endpoint: {
	// The hostname of the DNS record
	dnsName?: string @go(DNSName)

	// The targets the DNS record points to
	targets?: #Targets @go(Targets)

	// RecordType type of record, e.g. CNAME, A, AAAA, SRV, TXT etc
	recordType?: string @go(RecordType)

	// Identifier to distinguish multiple records with the same name and type (e.g. Route53 records with routing policies other than 'simple')
	setIdentifier?: string @go(SetIdentifier)

	// TTL for the record
	recordTTL?: #TTL @go(RecordTTL)

	// Labels stores labels defined for the Endpoint
	// +optional
	labels?: #Labels @go(Labels)

	// ProviderSpecific stores provider specific config
	// +optional
	providerSpecific?: #ProviderSpecific @go(ProviderSpecific)
}

// DNSEndpointSpec defines the desired state of DNSEndpoint
#DNSEndpointSpec: {
	endpoints?: [...null | #Endpoint] @go(Endpoints,[]*Endpoint)
}

// DNSEndpointStatus defines the observed state of DNSEndpoint
#DNSEndpointStatus: {
	// The generation observed by the external-dns controller.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)
}

#DNSEndpoint: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #DNSEndpointSpec   @go(Spec)
	status?:   #DNSEndpointStatus @go(Status)
}

// +kubebuilder:object:root=true
// DNSEndpointList is a list of DNSEndpoint objects
#DNSEndpointList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DNSEndpoint] @go(Items,[]DNSEndpoint)
}
