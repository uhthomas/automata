// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/external-dns/endpoint

package endpoint

_#heritage: "external-dns"

// OwnerLabelKey is the name of the label that defines the owner of an Endpoint.
#OwnerLabelKey: "owner"

// ResourceLabelKey is the name of the label that identifies k8s resource which wants to acquire the DNS name
#ResourceLabelKey: "resource"

// OwnedRecordLabelKey is the name of the label that identifies the record that is owned by the labeled TXT registry record
#OwnedRecordLabelKey: "ownedRecord"

// AWSSDDescriptionLabel label responsible for storing raw owner/resource combination information in the Labels
// supposed to be inserted by AWS SD Provider, and parsed into OwnerLabelKey and ResourceLabelKey key by AWS SD Registry
#AWSSDDescriptionLabel: "aws-sd-description"

// DualstackLabelKey is the name of the label that identifies dualstack endpoints
#DualstackLabelKey: "dualstack"

// txtEncryptionNonce label for keep same nonce for same txt records, for prevent different result of encryption for same txt record, it can cause issues for some providers
_#txtEncryptionNonce: "txt-encryption-nonce"

// Labels store metadata related to the endpoint
// it is then stored in a persistent storage via serialization
#Labels: {[string]: string}
